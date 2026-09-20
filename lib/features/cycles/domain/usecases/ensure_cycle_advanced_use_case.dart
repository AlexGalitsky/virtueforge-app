import 'package:virtue_forge/features/cycles/domain/repositories/cycle_repository.dart';
import 'package:virtue_forge/features/cycles/domain/services/cycle_calculator.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/build_cycle_summary_use_case.dart';

class EnsureCycleAdvancedUseCase {
  EnsureCycleAdvancedUseCase({
    required CycleRepository cycleRepository,
    required BuildCycleSummaryUseCase buildSummary,
  })  : _cycles = cycleRepository,
        _buildSummary = buildSummary;

  final CycleRepository _cycles;
  final BuildCycleSummaryUseCase _buildSummary;

  Future<void> call({DateTime? now}) async {
    final moment = now ?? DateTime.now();
    var guard = 0;
    while (guard < 32) {
      guard++;
      final active = await _cycles.getActiveCycle();
      if (active == null) return;
      if (!CycleCalculator.isCycleComplete(active.startedAt, moment)) {
        return;
      }

      final end = CycleCalculator.nextCycleStart(active.startedAt);
      final summary = await _buildSummary(
        startedAt: active.startedAt,
        endedAt: end,
      );

      await _cycles.closeCycle(
        id: active.id,
        endedAt: end,
        successPercent: summary.successPercent,
        weakPillarId: summary.weakPillarId,
        totalStrikes: summary.totalStrikes,
      );

      await _cycles.createCycle(
        startedAt: end,
        sequenceNumber: active.sequenceNumber + 1,
      );
    }
  }
}
