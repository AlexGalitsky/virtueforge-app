import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/journal/domain/entities/daily_log_entry.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/entities/strike_note_entry.dart';
import 'package:virtue_forge/features/journal/domain/models/ui_franklin_virtue.dart';

abstract final class JournalMapper {
  static List<UIFranklinVirtue> toUiVirtues({
    required List<FranklinVirtue> virtues,
    required List<DailyLogEntry> weekLogs,
    required List<StrikeNoteEntry> weekNotes,
    required DateTime weekStart,
    required int focusWeekNumber,
  }) {
    final start = WeekDateUtils.normalizeDate(weekStart);

    return virtues.map((virtue) {
      final strikes = List<int>.filled(7, 0);
      for (final log in weekLogs) {
        if (log.virtueId != virtue.id) continue;
        final dayIndex = WeekDateUtils.dayIndexInWeek(log.date, start);
        if (dayIndex >= 0) {
          strikes[dayIndex] = log.strikesCount;
        }
      }

      final noteCounts = List<int>.filled(7, 0);
      for (final note in weekNotes) {
        if (note.virtueId != virtue.id) continue;
        final dayIndex = WeekDateUtils.dayIndexInWeek(note.date, start);
        if (dayIndex >= 0) {
          noteCounts[dayIndex]++;
        }
      }

      return UIFranklinVirtue(
        id: virtue.id,
        name: virtue.name,
        description: virtue.customDescription?.isNotEmpty == true
            ? virtue.customDescription!
            : virtue.description,
        weekNumber: virtue.defaultWeekNumber,
        isCurrentWeekFocus: virtue.defaultWeekNumber == focusWeekNumber,
        weeklyStrikes: strikes,
        weeklyNoteCounts: noteCounts,
      );
    }).toList();
  }
}
