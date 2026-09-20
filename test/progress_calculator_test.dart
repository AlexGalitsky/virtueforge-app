import 'package:flutter_test/flutter_test.dart';
import 'package:virtue_forge/features/profile_progress/domain/services/progress_calculator.dart';

void main() {
  late ProgressCalculator calculator;

  setUp(() {
    calculator = ProgressCalculator();
  });

  group('xpRequiredForLevel', () {
    test('levels 1–10 use 100×N', () {
      expect(ProgressCalculator.xpRequiredForLevel(1), 100);
      expect(ProgressCalculator.xpRequiredForLevel(5), 500);
      expect(ProgressCalculator.xpRequiredForLevel(10), 1000);
    });

    test('levels 11–20 use 1000+(N-10)×50', () {
      expect(ProgressCalculator.xpRequiredForLevel(11), 1050);
      expect(ProgressCalculator.xpRequiredForLevel(15), 1250);
      expect(ProgressCalculator.xpRequiredForLevel(20), 1500);
    });

    test('level 21+ capped at 1500', () {
      expect(ProgressCalculator.xpRequiredForLevel(21), 1500);
      expect(ProgressCalculator.xpRequiredForLevel(99), 1500);
    });
  });

  group('calculateWeeklyXp', () {
    test('base 150 with no strikes or clean days', () {
      final xp = calculator.calculateWeeklyXp(
        WeekStrikesData(focusVirtueStrikes: 0, nonFocusVirtuesStrikes: 0),
      );
      expect(xp, 150);
    });

    test('adds clean-day bonus and applies new penalties', () {
      final xp = calculator.calculateWeeklyXp(
        WeekStrikesData(
          focusVirtueStrikes: 2,
          nonFocusVirtuesStrikes: 2,
          cleanDays: 4,
        ),
      );
      // 150 + 40 - 20 - 6 = 164
      expect(xp, 164);
    });

    test('may go negative on a catastrophic week', () {
      final xp = calculator.calculateWeeklyXp(
        WeekStrikesData(
          focusVirtueStrikes: 20,
          nonFocusVirtuesStrikes: 20,
          cleanDays: 0,
        ),
      );
      // 150 - 200 - 60 = -110
      expect(xp, -110);
    });
  });

  group('calculatePillarState', () {
    test('level 1 with partial progress', () {
      final state = calculator.calculatePillarState(40);
      expect(state.level, 1);
      expect(state.currentLevelXp, 40);
      expect(state.nextLevelXp, 100);
      expect(state.progress, closeTo(0.4, 0.001));
    });

    test('crosses into level 2 after 100 XP', () {
      final state = calculator.calculatePillarState(100);
      expect(state.level, 2);
      expect(state.currentLevelXp, 0);
      expect(state.nextLevelXp, 200);
      expect(state.progress, 0);
    });

    test('progressive scale level 3', () {
      final state = calculator.calculatePillarState(350);
      expect(state.level, 3);
      expect(state.currentLevelXp, 50);
      expect(state.nextLevelXp, 300);
      expect(state.progress, closeTo(50 / 300, 0.001));
    });

    test('level 11 threshold uses slowed curve', () {
      // Sum 100+200+...+1000 = 5500 to reach level 11
      var sum = 0;
      for (var n = 1; n <= 10; n++) {
        sum += ProgressCalculator.xpRequiredForLevel(n);
      }
      expect(sum, 5500);
      final atGate = calculator.calculatePillarState(sum);
      expect(atGate.level, 11);
      expect(atGate.nextLevelXp, 1050);
    });
  });

  group('applyLevelFloor', () {
    test('does not demote below floor', () {
      final computed = calculator.calculatePillarState(40); // level 1
      final floored = calculator.applyLevelFloor(computed, floorLevel: 5);
      expect(floored.level, 5);
      expect(floored.currentLevelXp, 0);
      expect(floored.nextLevelXp, 500);
      expect(floored.progress, 0);
    });
  });
}
