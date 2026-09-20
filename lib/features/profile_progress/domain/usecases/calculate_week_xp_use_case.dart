import 'package:virtue_forge/features/journal/domain/entities/daily_log_entry.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/profile_progress/domain/services/progress_calculator.dart';

class WeekXpResult {
  const WeekXpResult({
    required this.focusWeekNumber,
    required this.focusCategoryId,
    required this.weekXp,
    required this.focusStrikes,
    required this.nonFocusStrikes,
    required this.cleanDays,
  });

  final int focusWeekNumber;
  final int focusCategoryId;
  final int weekXp;
  final int focusStrikes;
  final int nonFocusStrikes;
  final int cleanDays;
}

/// Pure week XP for an explicit focus virtue (used on focus change + pillars).
class CalculateWeekXpUseCase {
  CalculateWeekXpUseCase(this._calculator);

  final ProgressCalculator _calculator;

  WeekXpResult? call({
    required int focusWeekNumber,
    required List<DailyLogEntry> weekLogs,
    required List<FranklinVirtue> virtues,
    DateTime? weekStart,
    DateTime? asOf,
  }) {
    final virtuesById = {for (final v in virtues) v.id: v};
    final virtuesByWeek = {
      for (final v in virtues) v.defaultWeekNumber: v,
    };
    final focusVirtue = virtuesByWeek[focusWeekNumber];
    if (focusVirtue == null) return null;

    var focusStrikes = 0;
    var nonFocusStrikes = 0;
    for (final log in weekLogs) {
      final virtue = virtuesById[log.virtueId];
      if (virtue == null ||
          virtue.stoicCategoryId != focusVirtue.stoicCategoryId) {
        continue;
      }
      if (virtue.id == focusVirtue.id) {
        focusStrikes += log.strikesCount;
      } else {
        nonFocusStrikes += log.strikesCount;
      }
    }

    final cleanDays = _countCleanDays(
      weekLogs,
      weekStart: weekStart,
      asOf: asOf,
    );

    final weekXp = _calculator.calculateWeeklyXp(
      WeekStrikesData(
        focusVirtueStrikes: focusStrikes,
        nonFocusVirtuesStrikes: nonFocusStrikes,
        cleanDays: cleanDays,
      ),
    );

    return WeekXpResult(
      focusWeekNumber: focusWeekNumber,
      focusCategoryId: focusVirtue.stoicCategoryId,
      weekXp: weekXp,
      focusStrikes: focusStrikes,
      nonFocusStrikes: nonFocusStrikes,
      cleanDays: cleanDays,
    );
  }

  /// Days Mon–Sun with zero strikes across all virtues.
  /// When [weekStart] is set, evaluates each day of that week.
  /// [asOf] limits counting to days on/before that date (current week).
  int _countCleanDays(
    List<DailyLogEntry> weekLogs, {
    DateTime? weekStart,
    DateTime? asOf,
  }) {
    final strikesByDay = <DateTime, int>{};
    for (final log in weekLogs) {
      final day = DateTime(log.date.year, log.date.month, log.date.day);
      strikesByDay[day] = (strikesByDay[day] ?? 0) + log.strikesCount;
    }

    if (weekStart != null) {
      final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
      final limit = asOf == null
          ? null
          : DateTime(asOf.year, asOf.month, asOf.day);
      var clean = 0;
      for (var i = 0; i < 7; i++) {
        final day = start.add(Duration(days: i));
        if (limit != null && day.isAfter(limit)) continue;
        if ((strikesByDay[day] ?? 0) == 0) clean++;
      }
      return clean;
    }

    return strikesByDay.values.where((s) => s == 0).length;
  }
}
