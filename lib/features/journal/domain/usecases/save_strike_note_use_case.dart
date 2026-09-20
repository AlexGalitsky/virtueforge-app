import 'package:virtue_forge/features/journal/domain/repositories/journal_repository.dart';

class SaveStrikeNoteUseCase {
  SaveStrikeNoteUseCase(this._journal);

  final JournalRepository _journal;

  Future<void> call({
    required DateTime date,
    required int virtueId,
    required int ordinal,
    required String body,
  }) {
    return _journal.upsertStrikeNote(
      date: date,
      virtueId: virtueId,
      ordinal: ordinal,
      body: body,
    );
  }
}
