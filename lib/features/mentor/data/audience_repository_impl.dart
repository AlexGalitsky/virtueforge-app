import 'package:drift/drift.dart';
import 'package:virtue_forge/core/database/app_database.dart';
import 'package:virtue_forge/core/database/daos/audiences_dao.dart';
import 'package:virtue_forge/features/mentor/domain/models/mentor_audience.dart';
import 'package:virtue_forge/features/mentor/domain/repositories/mentor_repositories.dart';

class AudienceRepositoryImpl implements AudienceRepository {
  AudienceRepositoryImpl(this._dao);

  final AudiencesDao _dao;

  @override
  Future<void> save(MentorAudience audience) {
    return _dao.insertAudience(
      StoicAudiencesCompanion.insert(
        id: audience.id,
        createdAt: audience.createdAt,
        virtueWeekNumber: audience.virtueWeekNumber,
        virtueLabel: audience.virtueLabel,
        misdeedSummary: Value(audience.misdeedSummary),
        note: Value(audience.note),
        userReflection: audience.userReflection,
        aiResponse: audience.aiResponse,
        modelId: audience.modelId,
        interrupted: Value(audience.interrupted),
      ),
    );
  }

  @override
  Future<void> updateResponse(
    String id,
    String aiResponse, {
    required bool interrupted,
  }) {
    return _dao.updateAiResponse(id, aiResponse, interrupted: interrupted);
  }

  @override
  Future<List<MentorAudience>> recent({int limit = 50}) async {
    final rows = await _dao.listRecent(limit: limit);
    return rows
        .map(
          (r) => MentorAudience(
            id: r.id,
            createdAt: r.createdAt,
            virtueWeekNumber: r.virtueWeekNumber,
            virtueLabel: r.virtueLabel,
            misdeedSummary: r.misdeedSummary,
            note: r.note,
            userReflection: r.userReflection,
            aiResponse: r.aiResponse,
            modelId: r.modelId,
            interrupted: r.interrupted,
          ),
        )
        .toList();
  }

  @override
  Future<void> clearAll() async {
    await _dao.clearAll();
  }
}
