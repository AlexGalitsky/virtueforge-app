import 'package:drift/drift.dart';
import 'package:virtue_forge/core/database/app_database.dart' hide FranklinVirtue;
import 'package:virtue_forge/core/database/daos/xp_events_dao.dart';
import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/cycle_repository.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/focus_shift_repository.dart';
import 'package:virtue_forge/features/cycles/domain/services/focus_resolver.dart';
import 'package:virtue_forge/features/journal/domain/entities/daily_log_entry.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/repositories/catalog_repository.dart';
import 'package:virtue_forge/features/journal/domain/repositories/journal_repository.dart';
import 'package:virtue_forge/features/profile_progress/data/pillar_level_floor_repository.dart';
import 'package:virtue_forge/features/profile_progress/domain/models/xp_ledger_models.dart';
import 'package:virtue_forge/features/profile_progress/domain/repositories/xp_ledger_repository.dart';
import 'package:virtue_forge/features/profile_progress/domain/services/progress_calculator.dart';

class XpLedgerRepositoryImpl implements XpLedgerRepository {
  XpLedgerRepositoryImpl({
    required XpEventsDao dao,
    required JournalRepository journal,
    required CatalogRepository catalog,
    required CycleRepository cycles,
    required FocusShiftRepository focusShift,
    required PillarLevelFloorRepository floors,
  })  : _dao = dao,
        _journal = journal,
        _catalog = catalog,
        _cycles = cycles,
        _focusShift = focusShift,
        _floors = floors;

  final XpEventsDao _dao;
  final JournalRepository _journal;
  final CatalogRepository _catalog;
  final CycleRepository _cycles;
  final FocusShiftRepository _focusShift;
  final PillarLevelFloorRepository _floors;

  @override
  Stream<List<XpLedgerEvent>> watchCategoryEvents(
    int categoryId, {
    int limit = 40,
  }) {
    return _dao.watchForCategory(categoryId, limit: limit).map(
          (rows) => rows.map(_map).toList(),
        );
  }

  @override
  Future<List<XpLedgerEvent>> getCategoryEvents(
    int categoryId, {
    int limit = 40,
  }) async {
    final rows = await _dao.getForCategory(categoryId, limit: limit);
    return rows.map(_map).toList();
  }

  @override
  Future<void> syncFromLogs() async {
    final logs = await _journal.watchAllLogs().first;
    final virtues = await _catalog.watchVirtues().first;
    final origin = await _cycles.practiceOrigin();
    final shift = await _focusShift.watch().first;
    final now = DateTime.now();
    final currentWeek = WeekDateUtils.startOfWeek(now);

    final logsByWeek = <DateTime, List<DailyLogEntry>>{};
    for (final log in logs) {
      final week = WeekDateUtils.startOfWeek(log.date);
      logsByWeek.putIfAbsent(week, () => []).add(log);
    }

    final practiceOrigin = origin ?? currentWeek;
    final rows = <XpEventsCompanion>[];

    for (final entry in logsByWeek.entries) {
      final weekStart = entry.key;
      final weekLogs = entry.value;
      final focusWeek = FocusResolver.effectiveFocusWeekNumber(
        origin: practiceOrigin,
        shift: shift,
        date: weekStart,
      );
      final asOf = weekStart == currentWeek ? now : null;
      rows.addAll(
        _eventsForWeek(
          weekStart: weekStart,
          weekLogs: weekLogs,
          virtues: virtues,
          focusWeekNumber: focusWeek,
          asOf: asOf,
        ),
      );
    }

    final bonusCat = await _floors.loadArchetypeBonusCategoryId();
    if (bonusCat != null) {
      rows.add(
        XpEventsCompanion.insert(
          categoryId: bonusCat,
          amount: PillarLevelFloorRepositoryImpl.archetypeBonusXp,
          kind: XpEventKind.archetypeBonus,
          eventDate: WeekDateUtils.normalizeDate(practiceOrigin),
          weekStart: const Value.absent(),
          dedupeKey: 'archetype:$bonusCat',
        ),
      );
    }

    await _dao.replaceNonDust(rows);
  }

  @override
  Future<void> appendDustEvents({
    required List<int> categoryIds,
    required int days,
    required DateTime firstDustDay,
    required int xpPerDay,
  }) async {
    final start = WeekDateUtils.normalizeDate(firstDustDay);
    final rows = <XpEventsCompanion>[];
    for (var d = 0; d < days; d++) {
      final day = start.add(Duration(days: d));
      for (final categoryId in categoryIds) {
        rows.add(
          XpEventsCompanion.insert(
            categoryId: categoryId,
            amount: -xpPerDay,
            kind: XpEventKind.dust,
            eventDate: day,
            weekStart: const Value.absent(),
            dedupeKey: 'dust:$categoryId:${day.toIso8601String()}',
          ),
        );
      }
    }
    if (rows.isNotEmpty) await _dao.upsertAll(rows);
  }

  @override
  Future<Map<int, int>> dustTotalsByCategory() =>
      _dao.sumByKind(XpEventKind.dust);

  @override
  Stream<void> watchChanges() => _dao.watchRowCount().map((_) {});

  List<XpEventsCompanion> _eventsForWeek({
    required DateTime weekStart,
    required List<DailyLogEntry> weekLogs,
    required List<FranklinVirtue> virtues,
    required int focusWeekNumber,
    DateTime? asOf,
  }) {
    final virtuesById = {for (final v in virtues) v.id: v};
    final virtuesByWeek = {
      for (final v in virtues) v.defaultWeekNumber: v,
    };
    final focusVirtue = virtuesByWeek[focusWeekNumber];
    if (focusVirtue == null) return const [];

    final categoryId = focusVirtue.stoicCategoryId;
    final start = WeekDateUtils.normalizeDate(weekStart);
    final result = <XpEventsCompanion>[];

    result.add(
      XpEventsCompanion.insert(
        categoryId: categoryId,
        amount: ProgressCalculator.baseMaxWeeklyXp,
        kind: XpEventKind.weekBase,
        virtueId: Value(focusVirtue.id),
        eventDate: start,
        weekStart: Value(start),
        dedupeKey: 'weekBase:$categoryId:${start.toIso8601String()}',
      ),
    );

    final strikesByDay = <DateTime, int>{};
    for (final log in weekLogs) {
      final day = WeekDateUtils.normalizeDate(log.date);
      strikesByDay[day] = (strikesByDay[day] ?? 0) + log.strikesCount;
    }

    final limit = asOf == null ? null : WeekDateUtils.normalizeDate(asOf);
    for (var i = 0; i < 7; i++) {
      final day = start.add(Duration(days: i));
      if (limit != null && day.isAfter(limit)) continue;
      if ((strikesByDay[day] ?? 0) != 0) continue;
      result.add(
        XpEventsCompanion.insert(
          categoryId: categoryId,
          amount: ProgressCalculator.cleanDayBonus,
          kind: XpEventKind.cleanDay,
          eventDate: day,
          weekStart: Value(start),
          dedupeKey: 'cleanDay:$categoryId:${day.toIso8601String()}',
        ),
      );
    }

    for (final log in weekLogs) {
      final virtue = virtuesById[log.virtueId];
      if (virtue == null || virtue.stoicCategoryId != categoryId) continue;
      final day = WeekDateUtils.normalizeDate(log.date);
      final isFocus = virtue.id == focusVirtue.id;
      final amount = isFocus
          ? -ProgressCalculator.focusStrikePenalty
          : -ProgressCalculator.nonFocusStrikePenalty;
      final kind =
          isFocus ? XpEventKind.focusStrike : XpEventKind.nonFocusStrike;
      for (var ordinal = 1; ordinal <= log.strikesCount; ordinal++) {
        result.add(
          XpEventsCompanion.insert(
            categoryId: categoryId,
            amount: amount,
            kind: kind,
            virtueId: Value(virtue.id),
            eventDate: day,
            weekStart: Value(start),
            dedupeKey:
                '$kind:$categoryId:${virtue.id}:${day.toIso8601String()}:$ordinal',
          ),
        );
      }
    }

    return result;
  }

  XpLedgerEvent _map(XpEvent row) => XpLedgerEvent(
        id: row.id,
        categoryId: row.categoryId,
        amount: row.amount,
        kind: row.kind,
        eventDate: row.eventDate,
        virtueId: row.virtueId,
        weekStart: row.weekStart,
      );
}
