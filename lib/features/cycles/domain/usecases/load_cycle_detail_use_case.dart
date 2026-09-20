import 'package:virtue_forge/features/cycles/domain/models/cycle_detail_snapshot.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/cycle_repository.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/focus_shift_repository.dart';
import 'package:virtue_forge/features/cycles/domain/services/cycle_calculator.dart';
import 'package:virtue_forge/features/cycles/domain/services/cycle_detail_aggregator.dart';
import 'package:virtue_forge/features/journal/domain/repositories/catalog_repository.dart';
import 'package:virtue_forge/features/journal/domain/repositories/journal_repository.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/calculate_week_xp_use_case.dart';

class LoadCycleDetailUseCase {
  LoadCycleDetailUseCase({
    required CycleRepository cycleRepository,
    required JournalRepository journalRepository,
    required CatalogRepository catalogRepository,
    required FocusShiftRepository focusShiftRepository,
    required CalculateWeekXpUseCase calculateWeekXp,
    CycleDetailAggregator aggregator = const CycleDetailAggregator(),
  })  : _cycles = cycleRepository,
        _journal = journalRepository,
        _catalog = catalogRepository,
        _focusShift = focusShiftRepository,
        _calculateWeekXp = calculateWeekXp,
        _aggregator = aggregator;

  final CycleRepository _cycles;
  final JournalRepository _journal;
  final CatalogRepository _catalog;
  final FocusShiftRepository _focusShift;
  final CalculateWeekXpUseCase _calculateWeekXp;
  final CycleDetailAggregator _aggregator;

  Future<CycleDetailSnapshot?> call(int cycleId, {DateTime? now}) async {
    final at = now ?? DateTime.now();
    final cycle = await _cycles.getCycleById(cycleId);
    if (cycle == null) return null;

    final rangeEnd = cycle.endedAt ??
        CycleCalculator.nextCycleStart(cycle.startedAt);
    final logs = await _journal.getLogsInRange(cycle.startedAt, rangeEnd);
    final virtues = await _catalog.watchVirtues().first;
    final categories = await _catalog.watchCategories().first;
    final shift = _focusShift.load();

    final aggregation = _aggregator.aggregate(
      startedAt: cycle.startedAt,
      rangeEnd: rangeEnd,
      logs: logs,
      virtues: virtues,
      categories: categories,
      shift: shift,
      calculateWeekXp: _calculateWeekXp,
      asOf: at,
    );

    // Archived rows keep stored summary; active recomputes live.
    final successPercent = cycle.isActive
        ? aggregation.successPercent
        : (cycle.successPercent ?? aggregation.successPercent);
    final totalStrikes = cycle.isActive
        ? aggregation.totalStrikes
        : (cycle.totalStrikes ?? aggregation.totalStrikes);
    final weakPillarId = cycle.isActive
        ? aggregation.weakPillarId
        : (cycle.weakPillarId ?? aggregation.weakPillarId);

    CycleCompareSnapshot? compare;
    if (cycle.sequenceNumber > 1) {
      final previous =
          await _cycles.getCycleBySequenceNumber(cycle.sequenceNumber - 1);
      if (previous != null && !previous.isActive) {
        final prevPercent = previous.successPercent ?? 0;
        final prevStrikes = previous.totalStrikes ?? 0;
        compare = CycleCompareSnapshot(
          previous: previous,
          successDelta: successPercent - prevPercent,
          strikesDelta: totalStrikes - prevStrikes,
          previousWeakPillarId: previous.weakPillarId,
        );
      }
    }

    return CycleDetailSnapshot(
      cycle: cycle,
      rangeEnd: rangeEnd,
      successPercent: successPercent,
      totalStrikes: totalStrikes,
      weakPillarId: weakPillarId,
      virtueBars: aggregation.virtueBars,
      pillarBars: aggregation.pillarBars,
      weekPoints: aggregation.weekPoints,
      compare: compare,
    );
  }
}
