import 'package:virtue_forge/features/cycles/domain/models/cycle_detail_snapshot.dart';
import 'package:virtue_forge/features/cycles/domain/services/cycle_calculator.dart';
import 'package:virtue_forge/features/cycles/domain/services/focus_resolver.dart';
import 'package:virtue_forge/features/journal/domain/entities/daily_log_entry.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/entities/stoic_category.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/calculate_week_xp_use_case.dart';
import 'package:virtue_forge/core/utils/week_date_utils.dart';

/// Pure aggregation of cycle charts from logs (testable without Drift).
class CycleDetailAggregator {
  const CycleDetailAggregator();

  CycleDetailAggregation aggregate({
    required DateTime startedAt,
    required DateTime rangeEnd,
    required List<DailyLogEntry> logs,
    required List<FranklinVirtue> virtues,
    required List<StoicCategory> categories,
    required FocusShift? shift,
    required CalculateWeekXpUseCase calculateWeekXp,
    DateTime? asOf,
  }) {
    final now = asOf ?? DateTime.now();
    final origin = WeekDateUtils.normalizeDate(startedAt);
    final currentWeekStart = WeekDateUtils.startOfWeek(now);
    final virtuesSorted = [...virtues]
      ..sort((a, b) => a.defaultWeekNumber.compareTo(b.defaultWeekNumber));
    final virtuesById = {for (final v in virtues) v.id: v};

    final strikesByVirtue = <int, int>{
      for (final v in virtuesSorted) v.id: 0,
    };
    final strikesByCategory = <int, int>{
      for (final c in categories) c.id: 0,
    };
    var totalStrikes = 0;

    for (final log in logs) {
      totalStrikes += log.strikesCount;
      strikesByVirtue[log.virtueId] =
          (strikesByVirtue[log.virtueId] ?? 0) + log.strikesCount;
      final virtue = virtuesById[log.virtueId];
      if (virtue != null) {
        strikesByCategory[virtue.stoicCategoryId] =
            (strikesByCategory[virtue.stoicCategoryId] ?? 0) +
                log.strikesCount;
      }
    }

    final xpByCategory = <int, int>{
      for (final c in categories) c.id: 0,
    };
    final weekCountByCategory = <int, int>{
      for (final c in categories) c.id: 0,
    };
    final weekScores = <int>[];
    final weekPoints = <CycleWeekPoint>[];

    for (var week = 0; week < CycleCalculator.weeksPerCycle; week++) {
      final weekStart = origin.add(Duration(days: week * 7));
      final weekEnd = weekStart.add(const Duration(days: 7));
      if (!weekStart.isBefore(rangeEnd)) break;
      // Active cycle: skip future weeks.
      if (weekStart.isAfter(currentWeekStart)) break;

      final focusWeekNumber = FocusResolver.effectiveFocusWeekNumber(
        origin: origin,
        shift: shift,
        date: weekStart,
      );

      final weekLogs = logs.where((log) {
        final d = WeekDateUtils.normalizeDate(log.date);
        return !d.isBefore(weekStart) && d.isBefore(weekEnd);
      }).toList();

      final weekResult = calculateWeekXp(
        focusWeekNumber: focusWeekNumber,
        weekLogs: weekLogs,
        virtues: virtues,
        weekStart: weekStart,
        asOf: weekStart == currentWeekStart ? now : null,
      );
      if (weekResult == null) continue;

      weekScores.add(weekResult.weekXp);
      xpByCategory[weekResult.focusCategoryId] =
          (xpByCategory[weekResult.focusCategoryId] ?? 0) + weekResult.weekXp;
      weekCountByCategory[weekResult.focusCategoryId] =
          (weekCountByCategory[weekResult.focusCategoryId] ?? 0) + 1;

      var weekStrikes = 0;
      for (final log in weekLogs) {
        weekStrikes += log.strikesCount;
      }

      weekPoints.add(
        CycleWeekPoint(
          weekIndex: week,
          weekStart: weekStart,
          strikes: weekStrikes,
          cleanDays: weekResult.cleanDays,
          weekXp: weekResult.weekXp,
          focusWeekNumber: focusWeekNumber,
        ),
      );
    }

    final successPercent = weekScores.isEmpty
        ? 0
        : (weekScores.reduce((a, b) => a + b) / weekScores.length)
            .round()
            .clamp(0, 100);

    int? weakPillarId;
    var minXp = 1 << 30;
    for (final entry in xpByCategory.entries) {
      if (entry.value < minXp) {
        minXp = entry.value;
        weakPillarId = entry.key;
      }
    }

    final virtueBars = [
      for (final v in virtuesSorted)
        CycleVirtueBar(
          virtueId: v.id,
          nameKey: v.name,
          strikes: strikesByVirtue[v.id] ?? 0,
        ),
    ];

    final pillarBars = [
      for (final c in categories)
        CyclePillarBar(
          categoryId: c.id,
          nameKey: c.name,
          strikes: strikesByCategory[c.id] ?? 0,
          avgWeekXp: (weekCountByCategory[c.id] ?? 0) == 0
              ? 0
              : ((xpByCategory[c.id] ?? 0) / weekCountByCategory[c.id]!).round(),
          weekCount: weekCountByCategory[c.id] ?? 0,
        ),
    ];

    return CycleDetailAggregation(
      successPercent: successPercent,
      totalStrikes: totalStrikes,
      weakPillarId: weakPillarId,
      virtueBars: virtueBars,
      pillarBars: pillarBars,
      weekPoints: weekPoints,
    );
  }
}

class CycleDetailAggregation {
  const CycleDetailAggregation({
    required this.successPercent,
    required this.totalStrikes,
    required this.weakPillarId,
    required this.virtueBars,
    required this.pillarBars,
    required this.weekPoints,
  });

  final int successPercent;
  final int totalStrikes;
  final int? weakPillarId;
  final List<CycleVirtueBar> virtueBars;
  final List<CyclePillarBar> pillarBars;
  final List<CycleWeekPoint> weekPoints;
}
