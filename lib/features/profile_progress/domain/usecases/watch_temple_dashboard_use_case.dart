import 'package:virtue_forge/core/utils/stream_combine.dart';
import 'package:virtue_forge/features/cycles/domain/models/ui_practice_cycle.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/cycle_repository.dart';
import 'package:virtue_forge/features/cycles/domain/services/cycle_calculator.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/ensure_cycle_advanced_use_case.dart';
import 'package:virtue_forge/features/profile_progress/domain/models/ui_stoic_pillar.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/watch_pillars_use_case.dart';

class TempleDashboard {
  const TempleDashboard({
    required this.pillars,
    required this.cycleInYear,
    required this.cyclesPerYear,
  });

  final List<UIStoicPillar> pillars;
  final int cycleInYear;
  final int cyclesPerYear;
}

class WatchTempleDashboardUseCase {
  WatchTempleDashboardUseCase({
    required EnsureCycleAdvancedUseCase ensureCycleAdvanced,
    required WatchPillarsUseCase watchPillars,
    required CycleRepository cycleRepository,
  })  : _ensureCycleAdvanced = ensureCycleAdvanced,
        _watchPillars = watchPillars,
        _cycles = cycleRepository;

  final EnsureCycleAdvancedUseCase _ensureCycleAdvanced;
  final WatchPillarsUseCase _watchPillars;
  final CycleRepository _cycles;

  Stream<TempleDashboard> call() async* {
    await _ensureCycleAdvanced();
    yield* combineLatest2(
      _watchPillars(),
      _cycles.watchActiveCycle(),
    ).map((tuple) {
      final (List<UIStoicPillar> pillars, UIPracticeCycle? active) = tuple;
      return TempleDashboard(
        pillars: pillars,
        cycleInYear: active?.cycleInYear ?? 1,
        cyclesPerYear: CycleCalculator.cyclesPerYear,
      );
    });
  }
}
