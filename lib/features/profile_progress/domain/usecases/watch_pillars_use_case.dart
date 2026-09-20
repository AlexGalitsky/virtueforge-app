import 'dart:math' as math;

import 'package:virtue_forge/core/utils/stream_combine.dart';
import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/cycle_repository.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/focus_shift_repository.dart';
import 'package:virtue_forge/features/cycles/domain/services/focus_resolver.dart';
import 'package:virtue_forge/features/journal/domain/entities/daily_log_entry.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/entities/stoic_category.dart';
import 'package:virtue_forge/features/journal/domain/repositories/catalog_repository.dart';
import 'package:virtue_forge/features/journal/domain/repositories/journal_repository.dart';
import 'package:virtue_forge/features/profile_progress/data/pillar_level_floor_repository.dart';
import 'package:virtue_forge/features/profile_progress/domain/models/ui_stoic_pillar.dart';
import 'package:virtue_forge/features/profile_progress/domain/repositories/xp_ledger_repository.dart';
import 'package:virtue_forge/features/profile_progress/domain/services/progress_calculator.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/calculate_week_xp_use_case.dart';

class WatchPillarsUseCase {
  WatchPillarsUseCase({
    required CatalogRepository catalogRepository,
    required JournalRepository journalRepository,
    required CycleRepository cycleRepository,
    required FocusShiftRepository focusShiftRepository,
    required CalculateWeekXpUseCase calculateWeekXp,
    required ProgressCalculator calculator,
    required PillarLevelFloorRepository levelFloorRepository,
    required XpLedgerRepository xpLedgerRepository,
  })  : _catalog = catalogRepository,
        _journal = journalRepository,
        _cycles = cycleRepository,
        _focusShift = focusShiftRepository,
        _calculateWeekXp = calculateWeekXp,
        _calculator = calculator,
        _levelFloors = levelFloorRepository,
        _xpLedger = xpLedgerRepository;

  final CatalogRepository _catalog;
  final JournalRepository _journal;
  final CycleRepository _cycles;
  final FocusShiftRepository _focusShift;
  final CalculateWeekXpUseCase _calculateWeekXp;
  final ProgressCalculator _calculator;
  final PillarLevelFloorRepository _levelFloors;
  final XpLedgerRepository _xpLedger;

  Stream<List<UIStoicPillar>> call() {
    return combineLatest2(
      combineLatest2(
        _focusShift.watch(),
        combineLatest3(
          _catalog.watchCategories(),
          _catalog.watchVirtues(),
          _journal.watchAllLogs(),
        ),
      ),
      _xpLedger.watchChanges(),
    ).asyncMap((pair) async {
      final (outer, _) = pair;
      final (shift, inner) = outer;
      final (categories, virtues, logs) = inner;
      final origin = await _cycles.practiceOrigin();
      final floors = Map<int, int>.from(await _levelFloors.loadFloors());
      final bonusCategoryId =
          await _levelFloors.loadArchetypeBonusCategoryId();
      final dustByCategory = await _xpLedger.dustTotalsByCategory();
      return _buildPillars(
        categories: categories,
        virtues: virtues,
        logs: logs,
        practiceOrigin: origin,
        shift: shift,
        floors: floors,
        archetypeBonusCategoryId: bonusCategoryId,
        dustByCategory: dustByCategory,
      );
    });
  }

  Future<List<UIStoicPillar>> _buildPillars({
    required List<StoicCategory> categories,
    required List<FranklinVirtue> virtues,
    required List<DailyLogEntry> logs,
    required DateTime? practiceOrigin,
    required FocusShift? shift,
    required Map<int, int> floors,
    required int? archetypeBonusCategoryId,
    required Map<int, int> dustByCategory,
  }) async {
    final totalXpByCategory = <int, int>{
      for (final category in categories) category.id: 0,
    };
    final weekIntegrityByCategory = <int, double>{
      for (final category in categories) category.id: 1.0,
    };

    final logsByWeekStart = <DateTime, List<DailyLogEntry>>{};
    for (final log in logs) {
      final weekStart = WeekDateUtils.startOfWeek(log.date);
      logsByWeekStart.putIfAbsent(weekStart, () => []).add(log);
    }

    final currentWeekStart = WeekDateUtils.startOfWeek(DateTime.now());
    final origin = practiceOrigin ?? currentWeekStart;

    final currentFocusWeek = FocusResolver.effectiveFocusWeekNumber(
      origin: origin,
      shift: shift,
      date: currentWeekStart,
    );
    final currentWeekLogs = logsByWeekStart[currentWeekStart] ?? const [];
    final currentWeekResult = _calculateWeekXp(
      focusWeekNumber: currentFocusWeek,
      weekLogs: currentWeekLogs,
      virtues: virtues,
      weekStart: currentWeekStart,
      asOf: DateTime.now(),
    );
    if (currentWeekResult != null) {
      weekIntegrityByCategory[currentWeekResult.focusCategoryId] =
          _calculator.weekIntegrity(currentWeekResult.weekXp);
    }

    for (final entry in logsByWeekStart.entries) {
      final weekStart = entry.key;
      final weekLogs = entry.value;
      final focusWeekNumber = FocusResolver.effectiveFocusWeekNumber(
        origin: origin,
        shift: shift,
        date: weekStart,
      );

      final weekResult = _calculateWeekXp(
        focusWeekNumber: focusWeekNumber,
        weekLogs: weekLogs,
        virtues: virtues,
        weekStart: weekStart,
      );
      if (weekResult == null) continue;

      totalXpByCategory[weekResult.focusCategoryId] =
          (totalXpByCategory[weekResult.focusCategoryId] ?? 0) +
              weekResult.weekXp;
    }

    if (archetypeBonusCategoryId != null) {
      totalXpByCategory[archetypeBonusCategoryId] =
          (totalXpByCategory[archetypeBonusCategoryId] ?? 0) +
              PillarLevelFloorRepositoryImpl.archetypeBonusXp;
    }

    for (final entry in dustByCategory.entries) {
      totalXpByCategory[entry.key] =
          (totalXpByCategory[entry.key] ?? 0) + entry.value;
    }

    final pillars = <UIStoicPillar>[];
    for (final category in categories) {
      final totalXp = totalXpByCategory[category.id] ?? 0;
      final computed = _calculator.calculatePillarState(totalXp);
      final storedFloor = floors[category.id] ?? 1;

      if (computed.level > storedFloor) {
        await _levelFloors.saveFloor(
          categoryId: category.id,
          level: computed.level,
        );
        floors[category.id] = computed.level;
      }

      final floorLevel = math.max(storedFloor, floors[category.id] ?? 1);
      final floored = _calculator.applyLevelFloor(
        computed,
        floorLevel: floorLevel,
      );

      pillars.add(
        UIStoicPillar(
          id: category.id,
          nameKey: category.name,
          descriptionKey: category.description,
          level: floored.level,
          currentLevelXp: floored.currentLevelXp,
          nextLevelXp: floored.nextLevelXp,
          lifetimeProgress: floored.progress,
          weekIntegrity: weekIntegrityByCategory[category.id] ?? 1.0,
        ),
      );
    }
    return pillars;
  }
}
