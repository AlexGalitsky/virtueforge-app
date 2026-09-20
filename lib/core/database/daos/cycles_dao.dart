import 'package:drift/drift.dart';
import 'package:virtue_forge/core/database/app_database.dart';
import 'package:virtue_forge/core/database/tables/practice_cycles.dart';

part 'cycles_dao.g.dart';

@DriftAccessor(tables: [PracticeCycles])
class CyclesDao extends DatabaseAccessor<AppDatabase> with _$CyclesDaoMixin {
  CyclesDao(super.db);

  Stream<PracticeCycle?> watchActiveCycle() {
    return (select(practiceCycles)..where((t) => t.endedAt.isNull()))
        .watch()
        .map((rows) => rows.isEmpty ? null : rows.first);
  }

  Future<PracticeCycle?> getActiveCycle() {
    return (select(practiceCycles)..where((t) => t.endedAt.isNull()))
        .getSingleOrNull();
  }

  Stream<List<PracticeCycle>> watchArchivedCycles() {
    return (select(practiceCycles)
          ..where((t) => t.endedAt.isNotNull())
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
        .watch();
  }

  Future<PracticeCycle?> getEarliestCycle() {
    return (select(practiceCycles)
          ..orderBy([(t) => OrderingTerm.asc(t.startedAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<PracticeCycle?> getById(int id) {
    return (select(practiceCycles)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<PracticeCycle?> getBySequenceNumber(int sequenceNumber) {
    return (select(practiceCycles)
          ..where((t) => t.sequenceNumber.equals(sequenceNumber)))
        .getSingleOrNull();
  }

  Future<int> insertCycle(PracticeCyclesCompanion row) =>
      into(practiceCycles).insert(row);

  Future<void> closeCycle({
    required int id,
    required DateTime endedAt,
    required int successPercent,
    required int? weakPillarId,
    required int totalStrikes,
  }) {
    return (update(practiceCycles)..where((t) => t.id.equals(id))).write(
      PracticeCyclesCompanion(
        endedAt: Value(endedAt),
        successPercent: Value(successPercent),
        weakPillarId: Value(weakPillarId),
        totalStrikes: Value(totalStrikes),
      ),
    );
  }
}
