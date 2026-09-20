import 'package:drift/drift.dart';
import 'package:virtue_forge/core/database/app_database.dart';
import 'package:virtue_forge/core/database/tables/xp_events.dart';
import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/profile_progress/domain/models/xp_ledger_models.dart';

part 'xp_events_dao.g.dart';

@DriftAccessor(tables: [XpEvents])
class XpEventsDao extends DatabaseAccessor<AppDatabase>
    with _$XpEventsDaoMixin {
  XpEventsDao(super.db);

  Stream<List<XpEvent>> watchForCategory(int categoryId, {int limit = 40}) {
    return (select(xpEvents)
          ..where((t) => t.categoryId.equals(categoryId))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.eventDate,
                  mode: OrderingMode.desc,
                ),
            (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
          ])
          ..limit(limit))
        .watch();
  }

  Future<List<XpEvent>> getForCategory(int categoryId, {int limit = 40}) {
    return (select(xpEvents)
          ..where((t) => t.categoryId.equals(categoryId))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.eventDate,
                  mode: OrderingMode.desc,
                ),
            (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
          ])
          ..limit(limit))
        .get();
  }

  Future<void> upsertEvent(XpEventsCompanion row) {
    return into(xpEvents).insert(
      row,
      onConflict: DoUpdate(
        (_) => row,
        target: [xpEvents.dedupeKey],
      ),
    );
  }

  /// Removes ledger rows that are rebuilt from journal logs.
  Future<void> deleteNonDust() {
    return (delete(xpEvents)
          ..where((t) => t.kind.isNotValue(XpEventKind.dust)))
        .go();
  }

  Future<void> deleteWeekDerived(DateTime weekStart) {
    final start = WeekDateUtils.normalizeDate(weekStart);
    return (delete(xpEvents)
          ..where((t) => t.weekStart.equals(start))
          ..where((t) => t.kind.isNotValue(XpEventKind.dust))
          ..where((t) => t.kind.isNotValue(XpEventKind.archetypeBonus)))
        .go();
  }

  Future<Map<int, int>> sumByKind(String kind) async {
    final rows = await (select(xpEvents)..where((t) => t.kind.equals(kind))).get();
    final totals = <int, int>{};
    for (final row in rows) {
      totals[row.categoryId] = (totals[row.categoryId] ?? 0) + row.amount;
    }
    return totals;
  }

  /// Fires whenever the XP ledger table changes (for Temple live refresh).
  Stream<int> watchRowCount() {
    return select(xpEvents).watch().map((rows) => rows.length);
  }

  /// Rebuilds log-derived ledger rows atomically (dust rows preserved).
  Future<void> replaceNonDust(List<XpEventsCompanion> rows) {
    return transaction(() async {
      await deleteNonDust();
      if (rows.isNotEmpty) {
        await upsertAll(rows);
      }
    });
  }

  Future<void> upsertAll(List<XpEventsCompanion> rows) async {
    await batch((b) {
      for (final row in rows) {
        b.insert(
          xpEvents,
          row,
          onConflict: DoUpdate(
            (_) => row,
            target: [xpEvents.dedupeKey],
          ),
        );
      }
    });
  }
}
