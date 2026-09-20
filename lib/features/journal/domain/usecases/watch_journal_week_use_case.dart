import 'package:virtue_forge/core/utils/stream_combine.dart';
import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/cycle_repository.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/focus_shift_repository.dart';
import 'package:virtue_forge/features/cycles/domain/services/focus_resolver.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/ensure_cycle_advanced_use_case.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/start_first_cycle_use_case.dart';
import 'package:virtue_forge/features/journal/domain/mappers/journal_mapper.dart';
import 'package:virtue_forge/features/journal/domain/models/ui_franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/repositories/catalog_repository.dart';
import 'package:virtue_forge/features/journal/domain/repositories/journal_repository.dart';

class JournalWeekSnapshot {
  const JournalWeekSnapshot({
    required this.virtues,
    required this.focusWeekNumber,
    required this.weekStart,
    required this.canGoPrev,
    required this.canGoNext,
  });

  final List<UIFranklinVirtue> virtues;
  final int focusWeekNumber;
  final DateTime weekStart;
  final bool canGoPrev;
  final bool canGoNext;
}

/// Ensures cycle readiness and streams a Franklin week grid.
///
/// [week] selects which ISO week to show (defaults to the current week).
/// Navigation is clamped between practice origin and this week.
class WatchJournalWeekUseCase {
  WatchJournalWeekUseCase({
    required EnsureCycleAdvancedUseCase ensureCycleAdvanced,
    required StartFirstCycleUseCase startFirstCycle,
    required CycleRepository cycleRepository,
    required FocusShiftRepository focusShiftRepository,
    required CatalogRepository catalogRepository,
    required JournalRepository journalRepository,
  })  : _ensureCycleAdvanced = ensureCycleAdvanced,
        _startFirstCycle = startFirstCycle,
        _cycles = cycleRepository,
        _focusShift = focusShiftRepository,
        _catalog = catalogRepository,
        _journal = journalRepository;

  final EnsureCycleAdvancedUseCase _ensureCycleAdvanced;
  final StartFirstCycleUseCase _startFirstCycle;
  final CycleRepository _cycles;
  final FocusShiftRepository _focusShift;
  final CatalogRepository _catalog;
  final JournalRepository _journal;

  Stream<JournalWeekSnapshot> call({DateTime? week}) async* {
    await _ensureCycleAdvanced();
    var active = await _cycles.getActiveCycle();
    if (active == null) {
      await _startFirstCycle();
      active = await _cycles.getActiveCycle();
    }

    final now = DateTime.now();
    final maxWeekStart = WeekDateUtils.startOfWeek(now);
    final originRaw =
        await _cycles.practiceOrigin() ?? active?.startedAt ?? maxWeekStart;
    final minWeekStart = WeekDateUtils.startOfWeek(originRaw);

    var weekStart = WeekDateUtils.startOfWeek(week ?? now);
    if (weekStart.isBefore(minWeekStart)) {
      weekStart = minWeekStart;
    } else if (weekStart.isAfter(maxWeekStart)) {
      weekStart = maxWeekStart;
    }

    yield* combineLatest2(
      _focusShift.watch(),
      combineLatest3(
        _catalog.watchVirtues(),
        _journal.watchWeekLogs(weekStart),
        _journal.watchNotesForWeek(weekStart),
      ),
    ).map((outer) {
      final (shift, inner) = outer;
      final (virtues, logs, notes) = inner;
      // Focus for the *viewed* week, not "today".
      final focusWeekNumber = FocusResolver.effectiveFocusWeekNumber(
        origin: originRaw,
        shift: shift,
        date: weekStart,
      );
      return JournalWeekSnapshot(
        virtues: JournalMapper.toUiVirtues(
          virtues: virtues,
          weekLogs: logs,
          weekNotes: notes,
          weekStart: weekStart,
          focusWeekNumber: focusWeekNumber,
        ),
        focusWeekNumber: focusWeekNumber,
        weekStart: weekStart,
        canGoPrev: weekStart.isAfter(minWeekStart),
        canGoNext: weekStart.isBefore(maxWeekStart),
      );
    });
  }
}
