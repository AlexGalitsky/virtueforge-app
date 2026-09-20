import 'package:flutter_test/flutter_test.dart';
import 'package:virtue_forge/features/journal/domain/entities/daily_log_entry.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/profile_progress/domain/services/progress_calculator.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/calculate_week_xp_use_case.dart';

void main() {
  final calculator = ProgressCalculator();
  final useCase = CalculateWeekXpUseCase(calculator);

  final virtues = [
    const FranklinVirtue(
      id: 1,
      stoicCategoryId: 1,
      name: 'virtueAbstinence',
      description: 'd1',
      defaultWeekNumber: 1,
    ),
    const FranklinVirtue(
      id: 2,
      stoicCategoryId: 1,
      name: 'virtueSilence',
      description: 'd2',
      defaultWeekNumber: 2,
    ),
    const FranklinVirtue(
      id: 6,
      stoicCategoryId: 3,
      name: 'virtueIndustry',
      description: 'd6',
      defaultWeekNumber: 6,
    ),
  ];

  final weekStart = DateTime(2026, 1, 5); // Monday

  test('focus strikes use heavier penalty than non-focus same category', () {
    final logs = [
      DailyLogEntry(
        id: 1,
        date: DateTime(2026, 1, 5),
        virtueId: 1,
        strikesCount: 2,
      ),
      DailyLogEntry(
        id: 2,
        date: DateTime(2026, 1, 5),
        virtueId: 2,
        strikesCount: 2,
      ),
    ];

    final asFocus1 = useCase(
      focusWeekNumber: 1,
      weekLogs: logs,
      virtues: virtues,
      weekStart: weekStart,
      asOf: DateTime(2026, 1, 5),
    )!;

    // 1 clean day counted (Mon has strikes → 0 clean with asOf=Mon)
    // Actually Mon has strikes, asOf=Mon → 0 clean days
    // 150 - 2*10 - 2*3 = 150 - 20 - 6 = 124
    expect(asFocus1.weekXp, 124);
    expect(asFocus1.focusCategoryId, 1);
    expect(asFocus1.cleanDays, 0);
  });

  test('clean days boost week XP', () {
    final logs = [
      DailyLogEntry(
        id: 1,
        date: DateTime(2026, 1, 5),
        virtueId: 1,
        strikesCount: 2,
      ),
    ];

    final result = useCase(
      focusWeekNumber: 1,
      weekLogs: logs,
      virtues: virtues,
      weekStart: weekStart,
      asOf: DateTime(2026, 1, 11), // full week visible
    )!;

    // Mon has strikes; Tue–Sun clean = 6 → +60
    // 150 + 60 - 20 = 190
    expect(result.cleanDays, 6);
    expect(result.weekXp, 190);
  });

  test('changing focus to another category recalculates category xp', () {
    final logs = [
      DailyLogEntry(
        id: 1,
        date: DateTime(2026, 1, 5),
        virtueId: 6,
        strikesCount: 1,
      ),
    ];

    final industryFocus = useCase(
      focusWeekNumber: 6,
      weekLogs: logs,
      virtues: virtues,
      weekStart: weekStart,
      asOf: DateTime(2026, 1, 5),
    )!;
    final temperanceFocus = useCase(
      focusWeekNumber: 1,
      weekLogs: logs,
      virtues: virtues,
      weekStart: weekStart,
      asOf: DateTime(2026, 1, 5),
    )!;

    expect(industryFocus.focusCategoryId, 3);
    // 150 + 0 clean - 10 = 140
    expect(industryFocus.weekXp, 140);
    expect(temperanceFocus.focusCategoryId, 1);
    // Industry ignored for temperance; Mon not clean (has strikes) → 150
    expect(temperanceFocus.weekXp, 150);
  });
}
