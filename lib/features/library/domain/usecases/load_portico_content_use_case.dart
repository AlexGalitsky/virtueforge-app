import 'dart:async';

import 'package:virtue_forge/features/cycles/domain/repositories/cycle_repository.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/focus_shift_repository.dart';
import 'package:virtue_forge/features/cycles/domain/services/focus_resolver.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/ensure_cycle_advanced_use_case.dart';
import 'package:virtue_forge/features/library/domain/models/essay.dart';
import 'package:virtue_forge/features/library/domain/repositories/library_repository.dart';

class PorticoContent {
  const PorticoContent({
    required this.essays,
    required this.focusWeekNumber,
  });

  final List<Essay> essays;
  final int focusWeekNumber;
}

class LoadPorticoContentUseCase {
  LoadPorticoContentUseCase({
    required EnsureCycleAdvancedUseCase ensureCycleAdvanced,
    required CycleRepository cycleRepository,
    required FocusShiftRepository focusShiftRepository,
    required LibraryRepository libraryRepository,
  })  : _ensureCycleAdvanced = ensureCycleAdvanced,
        _cycles = cycleRepository,
        _focusShift = focusShiftRepository,
        _library = libraryRepository;

  final EnsureCycleAdvancedUseCase _ensureCycleAdvanced;
  final CycleRepository _cycles;
  final FocusShiftRepository _focusShift;
  final LibraryRepository _library;

  Future<PorticoContent> call() async {
    await _ensureCycleAdvanced();
    final origin = await _cycles.practiceOrigin();
    final shift = _focusShift.load();
    final now = DateTime.now();
    final focusWeek = origin == null
        ? 1
        : FocusResolver.effectiveFocusWeekNumber(
            origin: origin,
            shift: shift,
            date: now,
          );
    final essays = await _library.essaysForWeek(focusWeek);
    // Seed disk cache for the visible week (assets or API) without blocking UI.
    unawaited(
      _library.prewarmEssayBodies(essays.map((e) => e.id)),
    );
    return PorticoContent(essays: essays, focusWeekNumber: focusWeek);
  }
}
