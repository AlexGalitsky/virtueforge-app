import 'package:virtue_forge/core/utils/stream_combine.dart';
import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/cycle_repository.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/focus_shift_repository.dart';
import 'package:virtue_forge/features/cycles/domain/services/focus_resolver.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/repositories/catalog_repository.dart';

class CurrentFocusSnapshot {
  const CurrentFocusSnapshot({
    required this.focusWeekNumber,
    required this.virtue,
    required this.isManualShift,
  });

  final int focusWeekNumber;
  final FranklinVirtue? virtue;
  final bool isManualShift;
}

/// Current effective focus for UI (Order subtitle, wheel initial index).
class WatchCurrentFocusUseCase {
  WatchCurrentFocusUseCase({
    required CycleRepository cycleRepository,
    required FocusShiftRepository focusShiftRepository,
    required CatalogRepository catalogRepository,
  })  : _cycles = cycleRepository,
        _focusShift = focusShiftRepository,
        _catalog = catalogRepository;

  final CycleRepository _cycles;
  final FocusShiftRepository _focusShift;
  final CatalogRepository _catalog;

  Stream<CurrentFocusSnapshot> call() async* {
    final origin =
        await _cycles.practiceOrigin() ?? WeekDateUtils.startOfWeek(DateTime.now());

    yield* combineLatest2(
      _catalog.watchVirtues(),
      _focusShift.watch(),
    ).map((tuple) {
      final (virtues, shift) = tuple;
      final focus = FocusResolver.effectiveFocusWeekNumber(
        origin: origin,
        shift: shift,
        date: DateTime.now(),
      );
      FranklinVirtue? virtue;
      for (final v in virtues) {
        if (v.defaultWeekNumber == focus) {
          virtue = v;
          break;
        }
      }
      return CurrentFocusSnapshot(
        focusWeekNumber: focus,
        virtue: virtue,
        isManualShift: shift != null,
      );
    });
  }
}
