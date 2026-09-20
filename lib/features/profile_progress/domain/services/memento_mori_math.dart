import 'package:virtue_forge/core/utils/week_date_utils.dart';

/// Life-week indices (0…4159) spent practicing in VirtueForge.
///
/// Aligns with Memento Mori grid indexing: floor(daysSinceBirth / 7).
abstract final class MementoMoriMath {
  static const int totalLifeWeeks = 4160;

  static int weekIndexSinceBirth(DateTime birthDate, DateTime date) {
    final birth = WeekDateUtils.normalizeDate(birthDate);
    final day = WeekDateUtils.normalizeDate(date);
    return day.difference(birth).inDays ~/ 7;
  }

  /// Mondays from [practiceOrigin] through the current week, mapped to life weeks.
  static Set<int> forgeCycleWeeks({
    required DateTime birthDate,
    required DateTime practiceOrigin,
    DateTime? now,
  }) {
    final current = WeekDateUtils.startOfWeek(now ?? DateTime.now());
    var week = WeekDateUtils.startOfWeek(practiceOrigin);
    if (week.isAfter(current)) return {};

    final result = <int>{};
    while (!week.isAfter(current)) {
      final index = weekIndexSinceBirth(birthDate, week);
      if (index >= 0 && index < totalLifeWeeks) {
        result.add(index);
      }
      week = week.add(const Duration(days: 7));
    }
    return result;
  }
}
