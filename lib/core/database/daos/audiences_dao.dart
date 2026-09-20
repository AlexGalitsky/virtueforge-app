import 'package:drift/drift.dart';
import 'package:virtue_forge/core/database/app_database.dart';
import 'package:virtue_forge/core/database/tables/stoic_audiences.dart';

part 'audiences_dao.g.dart';

@DriftAccessor(tables: [StoicAudiences])
class AudiencesDao extends DatabaseAccessor<AppDatabase>
    with _$AudiencesDaoMixin {
  AudiencesDao(super.db);

  Future<void> insertAudience(StoicAudiencesCompanion row) =>
      into(stoicAudiences).insert(row);

  Future<void> updateAiResponse(
    String id,
    String aiResponse, {
    required bool interrupted,
  }) {
    return (update(stoicAudiences)..where((t) => t.id.equals(id))).write(
      StoicAudiencesCompanion(
        aiResponse: Value(aiResponse),
        interrupted: Value(interrupted),
      ),
    );
  }

  Future<List<StoicAudience>> listRecent({int limit = 50}) {
    return (select(stoicAudiences)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .get();
  }

  Future<int> clearAll() => delete(stoicAudiences).go();
}
