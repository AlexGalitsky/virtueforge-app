import 'package:virtue_forge/features/profile_progress/domain/repositories/xp_ledger_repository.dart';

class SyncXpLedgerUseCase {
  SyncXpLedgerUseCase(this._ledger);

  final XpLedgerRepository _ledger;

  Future<void> call() => _ledger.syncFromLogs();
}
