import 'package:virtue_forge/features/journal/domain/repositories/journal_repository.dart';

class DeleteStrikeNoteUseCase {
  DeleteStrikeNoteUseCase(this._journal);

  final JournalRepository _journal;

  Future<void> call({
    required DateTime date,
    required int virtueId,
    required int ordinal,
  }) {
    return _journal.deleteStrikeNote(
      date: date,
      virtueId: virtueId,
      ordinal: ordinal,
    );
  }
}
