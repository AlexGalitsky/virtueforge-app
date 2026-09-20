import 'package:virtue_forge/features/journal/domain/entities/daily_log_entry.dart';
import 'package:virtue_forge/features/journal/domain/entities/strike_note_entry.dart';

abstract class JournalRepository {
  Stream<List<DailyLogEntry>> watchWeekLogs(DateTime startOfWeek);

  Stream<List<DailyLogEntry>> watchAllLogs();

  Future<List<DailyLogEntry>> getLogsInRange(DateTime start, DateTime end);

  Stream<DailyLogEntry?> watchLogForDay({
    required DateTime date,
    required int virtueId,
  });

  Future<void> updateStrike({
    required DateTime date,
    required int virtueId,
    required int amount,
  });

  Future<void> saveReflection({
    required DateTime date,
    required int virtueId,
    required String noteControlled,
    required String noteUncontrolled,
  });

  Stream<List<StrikeNoteEntry>> watchNotesForWeek(DateTime startOfWeek);

  Stream<List<StrikeNoteEntry>> watchNotesForDay({
    required DateTime date,
    required int virtueId,
  });

  Future<List<StrikeNoteEntry>> getNotesForDay({
    required DateTime date,
    required int virtueId,
  });

  Future<void> upsertStrikeNote({
    required DateTime date,
    required int virtueId,
    required int ordinal,
    required String body,
  });

  Future<void> deleteStrikeNote({
    required DateTime date,
    required int virtueId,
    required int ordinal,
  });
}
