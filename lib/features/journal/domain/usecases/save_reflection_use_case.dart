import 'package:virtue_forge/features/journal/domain/repositories/journal_repository.dart';

class SaveReflectionUseCase {
  SaveReflectionUseCase(this._journal);

  final JournalRepository _journal;

  Future<void> call({
    required DateTime date,
    required int virtueId,
    required String noteControlled,
    required String noteUncontrolled,
  }) {
    return _journal.saveReflection(
      date: date,
      virtueId: virtueId,
      noteControlled: noteControlled,
      noteUncontrolled: noteUncontrolled,
    );
  }
}
