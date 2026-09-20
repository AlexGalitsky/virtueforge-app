import 'package:virtue_forge/core/utils/stream_combine.dart';
import 'package:virtue_forge/features/cycles/domain/models/ui_practice_cycle.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/cycle_repository.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/ensure_cycle_advanced_use_case.dart';

class CycleArchiveSnapshot {
  const CycleArchiveSnapshot({
    required this.active,
    required this.archived,
  });

  final UIPracticeCycle? active;
  final List<UIPracticeCycle> archived;
}

class WatchCycleArchiveUseCase {
  WatchCycleArchiveUseCase({
    required EnsureCycleAdvancedUseCase ensureCycleAdvanced,
    required CycleRepository cycleRepository,
  })  : _ensureCycleAdvanced = ensureCycleAdvanced,
        _cycles = cycleRepository;

  final EnsureCycleAdvancedUseCase _ensureCycleAdvanced;
  final CycleRepository _cycles;

  Stream<CycleArchiveSnapshot> call() async* {
    await _ensureCycleAdvanced();
    yield* combineLatest2(
      _cycles.watchActiveCycle(),
      _cycles.watchArchivedCycles(),
    ).map((tuple) {
      final (active, archived) = tuple;
      return CycleArchiveSnapshot(active: active, archived: archived);
    });
  }
}
