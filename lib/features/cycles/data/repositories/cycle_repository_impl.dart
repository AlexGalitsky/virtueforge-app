import 'package:virtue_forge/core/database/app_database.dart';
import 'package:virtue_forge/core/database/daos/cycles_dao.dart';
import 'package:virtue_forge/features/cycles/domain/models/ui_practice_cycle.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/cycle_repository.dart';
import 'package:virtue_forge/features/cycles/domain/services/cycle_calculator.dart';

class CycleRepositoryImpl implements CycleRepository {
  CycleRepositoryImpl(this._cyclesDao);

  final CyclesDao _cyclesDao;

  @override
  Future<DateTime?> practiceOrigin() async {
    final earliest = await _cyclesDao.getEarliestCycle();
    return earliest?.startedAt;
  }

  @override
  Future<UIPracticeCycle?> getActiveCycle() async {
    final row = await _cyclesDao.getActiveCycle();
    if (row == null) return null;
    return _toUi(row, now: DateTime.now());
  }

  @override
  Future<UIPracticeCycle?> getCycleById(int id) async {
    final row = await _cyclesDao.getById(id);
    if (row == null) return null;
    return _toUi(row, now: DateTime.now());
  }

  @override
  Future<UIPracticeCycle?> getCycleBySequenceNumber(int sequenceNumber) async {
    final row = await _cyclesDao.getBySequenceNumber(sequenceNumber);
    if (row == null) return null;
    return _toUi(row, now: DateTime.now());
  }

  @override
  Future<bool> hasAnyCycle() async {
    final earliest = await _cyclesDao.getEarliestCycle();
    return earliest != null;
  }

  @override
  Stream<UIPracticeCycle?> watchActiveCycle() {
    return _cyclesDao.watchActiveCycle().map((row) {
      if (row == null) return null;
      return _toUi(row, now: DateTime.now());
    });
  }

  @override
  Stream<List<UIPracticeCycle>> watchArchivedCycles() {
    return _cyclesDao.watchArchivedCycles().map(
          (rows) => rows.map(_toUi).toList(),
        );
  }

  @override
  Future<void> createCycle({
    required DateTime startedAt,
    required int sequenceNumber,
  }) {
    return _cyclesDao.insertCycle(
      PracticeCyclesCompanion.insert(
        startedAt: startedAt,
        sequenceNumber: sequenceNumber,
      ),
    );
  }

  @override
  Future<void> closeCycle({
    required int id,
    required DateTime endedAt,
    required int successPercent,
    required int? weakPillarId,
    required int totalStrikes,
  }) {
    return _cyclesDao.closeCycle(
      id: id,
      endedAt: endedAt,
      successPercent: successPercent,
      weakPillarId: weakPillarId,
      totalStrikes: totalStrikes,
    );
  }

  UIPracticeCycle _toUi(PracticeCycle row, {DateTime? now}) {
    final active = row.endedAt == null;
    return UIPracticeCycle(
      id: row.id,
      startedAt: row.startedAt,
      endedAt: row.endedAt,
      sequenceNumber: row.sequenceNumber,
      cycleInYear: CycleCalculator.cycleInYear(row.sequenceNumber),
      isActive: active,
      successPercent: row.successPercent,
      weakPillarId: row.weakPillarId,
      totalStrikes: row.totalStrikes,
      weekInCycle: active && now != null
          ? CycleCalculator.weekInCycle(row.startedAt, now)
          : null,
    );
  }
}
