import 'package:flutter_test/flutter_test.dart';
import 'package:virtue_forge/features/profile_progress/domain/services/progress_calculator.dart';

void main() {
  test('smoke: ProgressCalculator is wired', () {
    final xp = ProgressCalculator().calculateWeeklyXp(
      WeekStrikesData(focusVirtueStrikes: 0, nonFocusVirtuesStrikes: 0),
    );
    expect(xp, 150);
  });
}
