import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/cycles/domain/services/focus_resolver.dart';

/// Расчёт фокуса и границ 13-недельного цикла от якоря [cycleStart] / practice origin.
abstract final class CycleCalculator {
  static const int weeksPerCycle = 13;
  static const int cyclesPerYear = 4;

  /// Индекс недели относительно старта: 0 = первая неделя цикла.
  static int weekIndexSince(DateTime origin, DateTime date) {
    final start = WeekDateUtils.normalizeDate(origin);
    final day = WeekDateUtils.normalizeDate(date);
    return day.difference(start).inDays ~/ 7;
  }

  /// Фокусная добродетель 1–13. [origin] — старт первого (или текущего непрерывного) цикла.
  /// Для ручного сдвига используйте [FocusResolver.effectiveFocusWeekNumber].
  static int focusVirtueWeekNumber(DateTime origin, DateTime date) =>
      FocusResolver.classicFocusWeekNumber(origin, date);

  /// Неделя внутри текущего цикла: 1–13 (для UI).
  static int weekInCycle(DateTime cycleStart, DateTime date) {
    final index = weekIndexSince(cycleStart, date);
    if (index < 0) return 1;
    return (index % weeksPerCycle) + 1;
  }

  static bool isCycleComplete(DateTime cycleStart, DateTime now) =>
      weekIndexSince(cycleStart, now) >= weeksPerCycle;

  static DateTime nextCycleStart(DateTime cycleStart) =>
      WeekDateUtils.normalizeDate(cycleStart)
          .add(Duration(days: weeksPerCycle * 7));

  /// 1–4 внутри «года практики».
  static int cycleInYear(int sequenceNumber) =>
      ((sequenceNumber - 1) % cyclesPerYear) + 1;

  static String romanNumeral(int cycleInYear) {
    const numerals = ['I', 'II', 'III', 'IV'];
    final i = cycleInYear.clamp(1, 4) - 1;
    return numerals[i];
  }
}
