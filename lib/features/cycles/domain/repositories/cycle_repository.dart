import 'package:virtue_forge/features/cycles/domain/models/ui_practice_cycle.dart';

/// Persistence for practice cycles only (no cross-feature orchestration).
abstract class CycleRepository {
  Future<DateTime?> practiceOrigin();

  Future<UIPracticeCycle?> getActiveCycle();

  Future<UIPracticeCycle?> getCycleById(int id);

  Future<UIPracticeCycle?> getCycleBySequenceNumber(int sequenceNumber);

  Future<bool> hasAnyCycle();

  Stream<UIPracticeCycle?> watchActiveCycle();

  Stream<List<UIPracticeCycle>> watchArchivedCycles();

  Future<void> createCycle({
    required DateTime startedAt,
    required int sequenceNumber,
  });

  Future<void> closeCycle({
    required int id,
    required DateTime endedAt,
    required int successPercent,
    required int? weakPillarId,
    required int totalStrikes,
  });
}
