import 'package:virtue_forge/features/profile_progress/domain/models/xp_ledger_models.dart';

abstract class XpLedgerRepository {
  Stream<List<XpLedgerEvent>> watchCategoryEvents(
    int categoryId, {
    int limit = 40,
  });

  Future<List<XpLedgerEvent>> getCategoryEvents(
    int categoryId, {
    int limit = 40,
  });

  /// Full rebuild of derived week/strike/clean events (+ archetype row).
  /// Preserves [XpEventKind.dust] rows.
  Future<void> syncFromLogs();

  /// Idempotent dust rows for absence days (dedupeKey-safe).
  Future<void> appendDustEvents({
    required List<int> categoryIds,
    required int days,
    required DateTime firstDustDay,
    required int xpPerDay,
  });

  /// Sum of dust amounts per category (typically ≤ 0).
  Future<Map<int, int>> dustTotalsByCategory();

  /// Emits when ledger rows change (dust, sync, etc.).
  Stream<void> watchChanges();
}
