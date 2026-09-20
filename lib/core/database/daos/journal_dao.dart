import 'package:drift/drift.dart';
import 'package:virtue_forge/core/database/app_database.dart';
import 'package:virtue_forge/core/database/tables/daily_logs.dart';
import 'package:virtue_forge/core/database/tables/strike_notes.dart';
import 'package:virtue_forge/core/utils/week_date_utils.dart';

part 'journal_dao.g.dart';

@DriftAccessor(tables: [DailyLogs, StrikeNotes])
class JournalDao extends DatabaseAccessor<AppDatabase> with _$JournalDaoMixin {
  JournalDao(super.db);

  /// Реактивный стрим логов за неделю `[startOfWeek, startOfWeek + 7 дней)`.
  Stream<List<DailyLog>> watchLogsForWeek(DateTime startOfWeek) {
    final start = WeekDateUtils.normalizeDate(startOfWeek);
    final end = start.add(const Duration(days: 7));

    return (select(dailyLogs)
          ..where((t) => t.date.isBiggerOrEqualValue(start))
          ..where((t) => t.date.isSmallerThanValue(end)))
        .watch();
  }

  /// Все логи (для расчёта XP колонн).
  Stream<List<DailyLog>> watchAllLogs() => select(dailyLogs).watch();

  /// Логи в полуинтервале `[start, end)`.
  Future<List<DailyLog>> getLogsInRange(DateTime start, DateTime end) {
    final from = WeekDateUtils.normalizeDate(start);
    final to = WeekDateUtils.normalizeDate(end);
    return (select(dailyLogs)
          ..where((t) => t.date.isBiggerOrEqualValue(from))
          ..where((t) => t.date.isSmallerThanValue(to)))
        .get();
  }

  Future<DailyLog?> getLogForDay({
    required DateTime date,
    required int virtueId,
  }) {
    final normalized = WeekDateUtils.normalizeDate(date);
    return (select(dailyLogs)
          ..where((t) => t.date.equals(normalized))
          ..where((t) => t.virtueId.equals(virtueId)))
        .getSingleOrNull();
  }

  Stream<DailyLog?> watchLogForDay({
    required DateTime date,
    required int virtueId,
  }) {
    final normalized = WeekDateUtils.normalizeDate(date);
    return (select(dailyLogs)
          ..where((t) => t.date.equals(normalized))
          ..where((t) => t.virtueId.equals(virtueId)))
        .watch()
        .map((rows) => rows.isEmpty ? null : rows.first);
  }

  /// Атомарно +/-amount к `strikesCount`; обрезает заметки с ordinal выше нового счёта.
  Future<int> upsertStrike(DateTime date, int virtueId, int amount) async {
    final normalized = WeekDateUtils.normalizeDate(date);

    return transaction(() async {
      final existing = await (select(dailyLogs)
            ..where((t) => t.date.equals(normalized))
            ..where((t) => t.virtueId.equals(virtueId)))
          .getSingleOrNull();

      late final int newCount;
      if (existing == null) {
        newCount = amount > 0 ? amount : 0;
        if (newCount > 0) {
          await into(dailyLogs).insert(
            DailyLogsCompanion.insert(
              date: normalized,
              virtueId: virtueId,
              strikesCount: Value(newCount),
            ),
          );
        }
      } else {
        newCount = (existing.strikesCount + amount).clamp(0, 999);
        await (update(dailyLogs)..where((t) => t.id.equals(existing.id))).write(
          DailyLogsCompanion(strikesCount: Value(newCount)),
        );
      }

      await (delete(strikeNotes)
            ..where((t) => t.date.equals(normalized))
            ..where((t) => t.virtueId.equals(virtueId))
            ..where((t) => t.ordinal.isBiggerThanValue(newCount)))
          .go();

      return newCount;
    });
  }

  /// Сохраняет текст вечерней рефлексии для фокусной добродетели на дату.
  Future<void> saveReflection({
    required DateTime date,
    required int virtueId,
    required String noteControlled,
    required String noteUncontrolled,
  }) async {
    final normalized = WeekDateUtils.normalizeDate(date);

    await transaction(() async {
      final existing = await (select(dailyLogs)
            ..where((t) => t.date.equals(normalized))
            ..where((t) => t.virtueId.equals(virtueId)))
          .getSingleOrNull();

      if (existing == null) {
        await into(dailyLogs).insert(
          DailyLogsCompanion.insert(
            date: normalized,
            virtueId: virtueId,
            noteControlled: Value(noteControlled),
            noteUncontrolled: Value(noteUncontrolled),
          ),
        );
      } else {
        await (update(dailyLogs)..where((t) => t.id.equals(existing.id))).write(
          DailyLogsCompanion(
            noteControlled: Value(noteControlled),
            noteUncontrolled: Value(noteUncontrolled),
          ),
        );
      }
    });
  }

  Stream<List<StrikeNote>> watchNotesForWeek(DateTime startOfWeek) {
    final start = WeekDateUtils.normalizeDate(startOfWeek);
    final end = start.add(const Duration(days: 7));
    return (select(strikeNotes)
          ..where((t) => t.date.isBiggerOrEqualValue(start))
          ..where((t) => t.date.isSmallerThanValue(end)))
        .watch();
  }

  Stream<List<StrikeNote>> watchNotesForDay({
    required DateTime date,
    required int virtueId,
  }) {
    final normalized = WeekDateUtils.normalizeDate(date);
    return (select(strikeNotes)
          ..where((t) => t.date.equals(normalized))
          ..where((t) => t.virtueId.equals(virtueId))
          ..orderBy([(t) => OrderingTerm.asc(t.ordinal)]))
        .watch();
  }

  Future<List<StrikeNote>> getNotesForDay({
    required DateTime date,
    required int virtueId,
  }) {
    final normalized = WeekDateUtils.normalizeDate(date);
    return (select(strikeNotes)
          ..where((t) => t.date.equals(normalized))
          ..where((t) => t.virtueId.equals(virtueId))
          ..orderBy([(t) => OrderingTerm.asc(t.ordinal)]))
        .get();
  }

  Future<void> upsertStrikeNote({
    required DateTime date,
    required int virtueId,
    required int ordinal,
    required String body,
  }) async {
    final normalized = WeekDateUtils.normalizeDate(date);
    final trimmed = body.trim();
    if (trimmed.isEmpty) {
      await deleteStrikeNote(
        date: normalized,
        virtueId: virtueId,
        ordinal: ordinal,
      );
      return;
    }

    await transaction(() async {
      final existing = await (select(strikeNotes)
            ..where((t) => t.date.equals(normalized))
            ..where((t) => t.virtueId.equals(virtueId))
            ..where((t) => t.ordinal.equals(ordinal)))
          .getSingleOrNull();

      if (existing == null) {
        await into(strikeNotes).insert(
          StrikeNotesCompanion.insert(
            date: normalized,
            virtueId: virtueId,
            ordinal: ordinal,
            body: trimmed,
          ),
        );
      } else {
        await (update(strikeNotes)..where((t) => t.id.equals(existing.id)))
            .write(StrikeNotesCompanion(body: Value(trimmed)));
      }
    });
  }

  Future<void> deleteStrikeNote({
    required DateTime date,
    required int virtueId,
    required int ordinal,
  }) async {
    final normalized = WeekDateUtils.normalizeDate(date);
    await (delete(strikeNotes)
          ..where((t) => t.date.equals(normalized))
          ..where((t) => t.virtueId.equals(virtueId))
          ..where((t) => t.ordinal.equals(ordinal)))
        .go();
  }
}
