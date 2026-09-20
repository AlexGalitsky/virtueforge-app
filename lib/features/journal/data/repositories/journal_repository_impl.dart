import 'package:virtue_forge/core/database/daos/journal_dao.dart';
import 'package:virtue_forge/features/journal/data/mappers/drift_catalog_mappers.dart';
import 'package:virtue_forge/features/journal/domain/entities/daily_log_entry.dart';
import 'package:virtue_forge/features/journal/domain/entities/strike_note_entry.dart';
import 'package:virtue_forge/features/journal/domain/repositories/journal_repository.dart';

class JournalRepositoryImpl implements JournalRepository {
  JournalRepositoryImpl(this._journalDao);

  final JournalDao _journalDao;

  @override
  Stream<List<DailyLogEntry>> watchWeekLogs(DateTime startOfWeek) {
    return _journalDao
        .watchLogsForWeek(startOfWeek)
        .map(DailyLogDriftMapper.toEntries);
  }

  @override
  Stream<List<DailyLogEntry>> watchAllLogs() {
    return _journalDao.watchAllLogs().map(DailyLogDriftMapper.toEntries);
  }

  @override
  Future<List<DailyLogEntry>> getLogsInRange(DateTime start, DateTime end) async {
    final rows = await _journalDao.getLogsInRange(start, end);
    return DailyLogDriftMapper.toEntries(rows);
  }

  @override
  Stream<DailyLogEntry?> watchLogForDay({
    required DateTime date,
    required int virtueId,
  }) {
    return _journalDao.watchLogForDay(date: date, virtueId: virtueId).map(
          (row) => row == null ? null : DailyLogDriftMapper.toEntry(row),
        );
  }

  @override
  Future<void> updateStrike({
    required DateTime date,
    required int virtueId,
    required int amount,
  }) {
    return _journalDao.upsertStrike(date, virtueId, amount);
  }

  @override
  Future<void> saveReflection({
    required DateTime date,
    required int virtueId,
    required String noteControlled,
    required String noteUncontrolled,
  }) {
    return _journalDao.saveReflection(
      date: date,
      virtueId: virtueId,
      noteControlled: noteControlled,
      noteUncontrolled: noteUncontrolled,
    );
  }

  @override
  Stream<List<StrikeNoteEntry>> watchNotesForWeek(DateTime startOfWeek) {
    return _journalDao
        .watchNotesForWeek(startOfWeek)
        .map(DailyLogDriftMapper.toStrikeNotes);
  }

  @override
  Stream<List<StrikeNoteEntry>> watchNotesForDay({
    required DateTime date,
    required int virtueId,
  }) {
    return _journalDao
        .watchNotesForDay(date: date, virtueId: virtueId)
        .map(DailyLogDriftMapper.toStrikeNotes);
  }

  @override
  Future<List<StrikeNoteEntry>> getNotesForDay({
    required DateTime date,
    required int virtueId,
  }) async {
    final rows =
        await _journalDao.getNotesForDay(date: date, virtueId: virtueId);
    return DailyLogDriftMapper.toStrikeNotes(rows);
  }

  @override
  Future<void> upsertStrikeNote({
    required DateTime date,
    required int virtueId,
    required int ordinal,
    required String body,
  }) {
    return _journalDao.upsertStrikeNote(
      date: date,
      virtueId: virtueId,
      ordinal: ordinal,
      body: body,
    );
  }

  @override
  Future<void> deleteStrikeNote({
    required DateTime date,
    required int virtueId,
    required int ordinal,
  }) {
    return _journalDao.deleteStrikeNote(
      date: date,
      virtueId: virtueId,
      ordinal: ordinal,
    );
  }
}
