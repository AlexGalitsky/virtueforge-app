import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/focus_shift_repository.dart';
import 'package:virtue_forge/features/cycles/domain/services/focus_resolver.dart';
import 'package:virtue_forge/features/journal/domain/repositories/catalog_repository.dart';
import 'package:virtue_forge/features/journal/domain/repositories/journal_repository.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/calculate_week_xp_use_case.dart';

class SetFocusVirtueResult {
  const SetFocusVirtueResult({
    required this.focusWeekNumber,
    required this.recalculatedWeekXp,
  });

  final int focusWeekNumber;
  final WeekXpResult? recalculatedWeekXp;
}

/// Persists a focus sequence shift from the current Monday and recalculates
/// that week's XP under the new focus.
class SetFocusVirtueUseCase {
  SetFocusVirtueUseCase({
    required FocusShiftRepository focusShiftRepository,
    required JournalRepository journalRepository,
    required CatalogRepository catalogRepository,
    required CalculateWeekXpUseCase calculateWeekXp,
  })  : _focusShift = focusShiftRepository,
        _journal = journalRepository,
        _catalog = catalogRepository,
        _calculateWeekXp = calculateWeekXp;

  final FocusShiftRepository _focusShift;
  final JournalRepository _journal;
  final CatalogRepository _catalog;
  final CalculateWeekXpUseCase _calculateWeekXp;

  Future<SetFocusVirtueResult> call({
    required int weekNumber,
    DateTime? now,
  }) async {
    if (weekNumber < 1 || weekNumber > FocusResolver.weeksPerCycle) {
      throw ArgumentError.value(weekNumber, 'weekNumber', 'must be 1–13');
    }

    final moment = now ?? DateTime.now();
    final weekStart = WeekDateUtils.startOfWeek(moment);
    final shift = FocusShift(
      anchorWeekStart: weekStart,
      anchorWeekNumber: weekNumber,
    );
    await _focusShift.save(shift);

    final weekEnd = weekStart.add(const Duration(days: 7));
    final logs = await _journal.getLogsInRange(weekStart, weekEnd);
    final virtues = await _catalog.watchVirtues().first;
    final recalculated = _calculateWeekXp(
      focusWeekNumber: weekNumber,
      weekLogs: logs,
      virtues: virtues,
    );

    return SetFocusVirtueResult(
      focusWeekNumber: weekNumber,
      recalculatedWeekXp: recalculated,
    );
  }
}
