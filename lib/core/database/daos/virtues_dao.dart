import 'package:drift/drift.dart';
import 'package:virtue_forge/core/database/app_database.dart';
import 'package:virtue_forge/core/database/tables/franklin_virtues.dart';
import 'package:virtue_forge/core/database/tables/stoic_categories.dart';

part 'virtues_dao.g.dart';

@DriftAccessor(tables: [FranklinVirtues, StoicCategories])
class VirtuesDao extends DatabaseAccessor<AppDatabase> with _$VirtuesDaoMixin {
  VirtuesDao(super.db);

  Stream<List<FranklinVirtue>> watchAllVirtues() {
    return (select(franklinVirtues)
          ..orderBy([(t) => OrderingTerm.asc(t.defaultWeekNumber)]))
        .watch();
  }

  Future<List<FranklinVirtue>> getAllVirtues() {
    return (select(franklinVirtues)
          ..orderBy([(t) => OrderingTerm.asc(t.defaultWeekNumber)]))
        .get();
  }

  Stream<List<StoicCategory>> watchAllCategories() {
    return (select(stoicCategories)..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .watch();
  }

  Future<List<StoicCategory>> getAllCategories() {
    return (select(stoicCategories)..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
  }

  Future<void> updateCustomDescription(int virtueId, String? customDescription) {
    return (update(franklinVirtues)..where((t) => t.id.equals(virtueId))).write(
      FranklinVirtuesCompanion(
        customDescription: Value(customDescription),
      ),
    );
  }
}
