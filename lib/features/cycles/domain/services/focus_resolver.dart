import 'package:virtue_forge/core/utils/week_date_utils.dart';

/// Manual focus sequence shift starting at [anchorWeekStart] (Monday).
class FocusShift {
  const FocusShift({
    required this.anchorWeekStart,
    required this.anchorWeekNumber,
  });

  /// Monday of the week when the user set the focus.
  final DateTime anchorWeekStart;

  /// Franklin week number 1–13 chosen for that Monday.
  final int anchorWeekNumber;
}

/// Resolves focus virtue week number with optional manual shift.
abstract final class FocusResolver {
  /// Weeks before [FocusShift.anchorWeekStart] use classic [origin] sequence.
  /// From the anchor week onward: `anchorWeekNumber + weeksSince` (mod 13).
  static int effectiveFocusWeekNumber({
    required DateTime origin,
    required FocusShift? shift,
    required DateTime date,
  }) {
    final weekStart = WeekDateUtils.startOfWeek(date);

    if (shift != null) {
      final anchor = WeekDateUtils.normalizeDate(shift.anchorWeekStart);
      if (!weekStart.isBefore(anchor)) {
        final weeksSince = weekStart.difference(anchor).inDays ~/ 7;
        final index =
            (shift.anchorWeekNumber - 1 + weeksSince) % weeksPerCycle;
        return index + 1;
      }
    }

    return classicFocusWeekNumber(origin, date);
  }

  static const int weeksPerCycle = 13;

  /// Classic Franklin sequence from practice [origin] (no manual shift).
  static int classicFocusWeekNumber(DateTime origin, DateTime date) {
    final start = WeekDateUtils.normalizeDate(origin);
    final day = WeekDateUtils.normalizeDate(date);
    final index = day.difference(start).inDays ~/ 7;
    if (index < 0) return 1;
    return (index % weeksPerCycle) + 1;
  }
}
