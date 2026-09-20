import 'package:virtue_forge/features/journal/domain/repositories/journal_repository.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/sync_xp_ledger_use_case.dart';

class UpdateStrikeUseCase {
  UpdateStrikeUseCase(this._journal, this._syncLedger);

  final JournalRepository _journal;
  final SyncXpLedgerUseCase _syncLedger;

  Future<void> call({
    required DateTime date,
    required int virtueId,
    required int amount,
  }) async {
    await _journal.updateStrike(
      date: date,
      virtueId: virtueId,
      amount: amount,
    );
    await _syncLedger();
  }
}
