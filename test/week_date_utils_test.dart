import 'package:flutter_test/flutter_test.dart';
import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/cycles/domain/services/cycle_calculator.dart';

void main() {
  group('WeekDateUtils', () {
    test('normalizeDate strips time', () {
      final d = DateTime(2026, 7, 25, 15, 30);
      expect(WeekDateUtils.normalizeDate(d), DateTime(2026, 7, 25));
    });

    test('startOfWeek returns Monday', () {
      final start = WeekDateUtils.startOfWeek(DateTime(2026, 7, 25));
      expect(start.weekday, DateTime.monday);
      expect(start, DateTime(2026, 7, 20));
    });

    test('dayIndexInWeek maps Mon=0 .. Sun=6', () {
      final weekStart = DateTime(2026, 7, 20);
      expect(WeekDateUtils.dayIndexInWeek(DateTime(2026, 7, 20), weekStart), 0);
      expect(WeekDateUtils.dayIndexInWeek(DateTime(2026, 7, 26), weekStart), 6);
      expect(WeekDateUtils.dayIndexInWeek(DateTime(2026, 7, 19), weekStart), -1);
    });
  });

  group('CycleCalculator', () {
    final origin = DateTime(2026, 7, 20); // Monday

    test('focusVirtueWeekNumber starts at 1', () {
      expect(CycleCalculator.focusVirtueWeekNumber(origin, origin), 1);
    });

    test('focusVirtueWeekNumber advances weekly', () {
      expect(
        CycleCalculator.focusVirtueWeekNumber(
          origin,
          origin.add(const Duration(days: 7)),
        ),
        2,
      );
      expect(
        CycleCalculator.focusVirtueWeekNumber(
          origin,
          origin.add(const Duration(days: 12 * 7)),
        ),
        13,
      );
    });

    test('focus wraps into next cycle', () {
      expect(
        CycleCalculator.focusVirtueWeekNumber(
          origin,
          origin.add(const Duration(days: 13 * 7)),
        ),
        1,
      );
    });

    test('isCycleComplete after 13 weeks', () {
      expect(CycleCalculator.isCycleComplete(origin, origin), false);
      expect(
        CycleCalculator.isCycleComplete(
          origin,
          origin.add(const Duration(days: 13 * 7 - 1)),
        ),
        false,
      );
      expect(
        CycleCalculator.isCycleComplete(
          origin,
          origin.add(const Duration(days: 13 * 7)),
        ),
        true,
      );
    });

    test('cycleInYear and roman', () {
      expect(CycleCalculator.cycleInYear(1), 1);
      expect(CycleCalculator.cycleInYear(4), 4);
      expect(CycleCalculator.cycleInYear(5), 1);
      expect(CycleCalculator.romanNumeral(1), 'I');
      expect(CycleCalculator.romanNumeral(4), 'IV');
    });
  });
}
