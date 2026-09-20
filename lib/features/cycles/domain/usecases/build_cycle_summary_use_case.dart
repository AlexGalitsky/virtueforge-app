import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/focus_shift_repository.dart';
import 'package:virtue_forge/features/cycles/domain/services/cycle_calculator.dart';
import 'package:virtue_forge/features/cycles/domain/services/focus_resolver.dart';
import 'package:virtue_forge/features/journal/domain/repositories/catalog_repository.dart';
import 'package:virtue_forge/features/journal/domain/repositories/journal_repository.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/calculate_week_xp_use_case.dart';

class CycleSummary {
  const CycleSummary({
    required this.successPercent,
    required this.weakPillarId,
    required this.totalStrikes,
  });

  final int successPercent;
  final int? weakPillarId;
  final int totalStrikes;
}

class BuildCycleSummaryUseCase {
  BuildCycleSummaryUseCase({
    required JournalRepository journalRepository,
    required CatalogRepository catalogRepository,
    required FocusShiftRepository focusShiftRepository,
    required CalculateWeekXpUseCase calculateWeekXp,
  })  : _journalRepository = journalRepository,
        _catalogRepository = catalogRepository,
        _focusShift = focusShiftRepository,
        _calculateWeekXp = calculateWeekXp;

  final JournalRepository _journalRepository;
  final CatalogRepository _catalogRepository;
  final FocusShiftRepository _focusShift;
  final CalculateWeekXpUseCase _calculateWeekXp;

  Future<CycleSummary> call({
    required DateTime startedAt,
    required DateTime endedAt,
  }) async {
    final logs = await _journalRepository.getLogsInRange(startedAt, endedAt);
    final virtues = await _catalogRepository.watchVirtues().first;
    final categories = await _catalogRepository.watchCategories().first;
    final shift = _focusShift.load();
    // Origin for weeks inside this cycle: cycle start is the sequence base
    // when no shift applies; FocusResolver still prefers shift when week >= anchor.
    final origin = WeekDateUtils.normalizeDate(startedAt);

    var totalStrikes = 0;
    for (final log in logs) {
      totalStrikes += log.strikesCount;
    }

    final xpByCategory = <int, int>{
      for (final c in categories) c.id: 0,
    };
    final weekScores = <int>[];

    for (var week = 0; week < CycleCalculator.weeksPerCycle; week++) {
      final weekStart = startedAt.add(Duration(days: week * 7));
      final weekEnd = weekStart.add(const Duration(days: 7));
      if (!weekStart.isBefore(endedAt)) break;

      final focusWeekNumber = FocusResolver.effectiveFocusWeekNumber(
        origin: origin,
        shift: shift,
        date: weekStart,
      );

      final weekLogs = logs.where((log) {
        final d = WeekDateUtils.normalizeDate(log.date);
        return !d.isBefore(weekStart) && d.isBefore(weekEnd);
      }).toList();

      final weekResult = _calculateWeekXp(
        focusWeekNumber: focusWeekNumber,
        weekLogs: weekLogs,
        virtues: virtues,
      );
      if (weekResult == null) continue;

      weekScores.add(weekResult.weekXp);
      xpByCategory[weekResult.focusCategoryId] =
          (xpByCategory[weekResult.focusCategoryId] ?? 0) + weekResult.weekXp;
    }

    final successPercent = weekScores.isEmpty
        ? 0
        : (weekScores.reduce((a, b) => a + b) / weekScores.length).round();

    int? weakPillarId;
    var minXp = 1 << 30;
    for (final entry in xpByCategory.entries) {
      if (entry.value < minXp) {
        minXp = entry.value;
        weakPillarId = entry.key;
      }
    }

    return CycleSummary(
      successPercent: successPercent.clamp(0, 100),
      weakPillarId: weakPillarId,
      totalStrikes: totalStrikes,
    );
  }
}
