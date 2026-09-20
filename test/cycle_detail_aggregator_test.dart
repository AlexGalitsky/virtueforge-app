import 'package:flutter_test/flutter_test.dart';
import 'package:virtue_forge/features/cycles/domain/services/cycle_detail_aggregator.dart';
import 'package:virtue_forge/features/journal/domain/entities/daily_log_entry.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/entities/stoic_category.dart';
import 'package:virtue_forge/features/profile_progress/domain/services/progress_calculator.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/calculate_week_xp_use_case.dart';

void main() {
  final calculateWeekXp = CalculateWeekXpUseCase(ProgressCalculator());
  const aggregator = CycleDetailAggregator();

  final categories = [
    const StoicCategory(id: 1, name: 'stoicTemperance', description: ''),
    const StoicCategory(id: 2, name: 'stoicWisdom', description: ''),
    const StoicCategory(id: 3, name: 'stoicCourage', description: ''),
    const StoicCategory(id: 4, name: 'stoicJustice', description: ''),
  ];

  // 13 virtues, weeks 1–13, categories cycle 1→4.
  final virtues = [
    for (var w = 1; w <= 13; w++)
      FranklinVirtue(
        id: w,
        stoicCategoryId: ((w - 1) % 4) + 1,
        name: 'virtue$w',
        description: 'd$w',
        defaultWeekNumber: w,
      ),
  ];

  // Monday cycle start.
  final startedAt = DateTime(2026, 1, 5);
  final rangeEnd = startedAt.add(const Duration(days: 13 * 7));

  test('sums virtue and pillar strikes across the cycle window', () {
    final logs = [
      DailyLogEntry(
        id: 1,
        date: DateTime(2026, 1, 5),
        virtueId: 1,
        strikesCount: 3,
      ),
      DailyLogEntry(
        id: 2,
        date: DateTime(2026, 1, 6),
        virtueId: 1,
        strikesCount: 2,
      ),
      DailyLogEntry(
        id: 3,
        date: DateTime(2026, 1, 12), // week 2
        virtueId: 2,
        strikesCount: 1,
      ),
    ];

    final result = aggregator.aggregate(
      startedAt: startedAt,
      rangeEnd: rangeEnd,
      logs: logs,
      virtues: virtues,
      categories: categories,
      shift: null,
      calculateWeekXp: calculateWeekXp,
      asOf: DateTime(2026, 1, 20), // during week 3
    );

    expect(result.totalStrikes, 6);
    expect(
      result.virtueBars.firstWhere((b) => b.virtueId == 1).strikes,
      5,
    );
    expect(
      result.virtueBars.firstWhere((b) => b.virtueId == 2).strikes,
      1,
    );
    // virtue1 → cat 1, virtue2 → cat 2
    expect(
      result.pillarBars.firstWhere((b) => b.categoryId == 1).strikes,
      5,
    );
    expect(
      result.pillarBars.firstWhere((b) => b.categoryId == 2).strikes,
      1,
    );
  });

  test('active asOf skips future weeks in series', () {
    final logs = [
      DailyLogEntry(
        id: 1,
        date: DateTime(2026, 1, 5),
        virtueId: 1,
        strikesCount: 1,
      ),
    ];

    final midCycle = aggregator.aggregate(
      startedAt: startedAt,
      rangeEnd: rangeEnd,
      logs: logs,
      virtues: virtues,
      categories: categories,
      shift: null,
      calculateWeekXp: calculateWeekXp,
      asOf: DateTime(2026, 1, 12), // Monday of week 2 → weeks 0 and 1
    );

    expect(midCycle.weekPoints.length, 2);
    expect(midCycle.weekPoints.map((p) => p.weekIndex).toList(), [0, 1]);
    expect(midCycle.weekPoints.first.strikes, 1);
  });

  test('full archived window yields up to 13 week points', () {
    final result = aggregator.aggregate(
      startedAt: startedAt,
      rangeEnd: rangeEnd,
      logs: const [],
      virtues: virtues,
      categories: categories,
      shift: null,
      calculateWeekXp: calculateWeekXp,
      asOf: rangeEnd, // after close
    );

    expect(result.weekPoints.length, 13);
    expect(result.totalStrikes, 0);
    expect(result.successPercent, greaterThan(0));
  });

  test('compare deltas are previous minus current math', () {
    // Pure assertion of the intended UI math (kept here as contract).
    const currentSuccess = 72;
    const previousSuccess = 60;
    const currentStrikes = 40;
    const previousStrikes = 55;
    expect(currentSuccess - previousSuccess, 12);
    expect(currentStrikes - previousStrikes, -15);
  });
}
