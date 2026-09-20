import 'package:flutter_test/flutter_test.dart';
import 'package:virtue_forge/features/cycles/domain/services/focus_resolver.dart';

void main() {
  final origin = DateTime(2026, 1, 5); // Monday

  test('classic sequence without shift', () {
    expect(
      FocusResolver.effectiveFocusWeekNumber(
        origin: origin,
        shift: null,
        date: DateTime(2026, 1, 5),
      ),
      1,
    );
    expect(
      FocusResolver.effectiveFocusWeekNumber(
        origin: origin,
        shift: null,
        date: DateTime(2026, 1, 12),
      ),
      2,
    );
  });

  test('weeks before anchor keep classic focus', () {
    final shift = FocusShift(
      anchorWeekStart: DateTime(2026, 1, 19),
      anchorWeekNumber: 6,
    );
    expect(
      FocusResolver.effectiveFocusWeekNumber(
        origin: origin,
        shift: shift,
        date: DateTime(2026, 1, 12),
      ),
      2,
    );
  });

  test('from anchor onward uses shifted sequence', () {
    final shift = FocusShift(
      anchorWeekStart: DateTime(2026, 1, 19),
      anchorWeekNumber: 6,
    );
    expect(
      FocusResolver.effectiveFocusWeekNumber(
        origin: origin,
        shift: shift,
        date: DateTime(2026, 1, 19),
      ),
      6,
    );
    expect(
      FocusResolver.effectiveFocusWeekNumber(
        origin: origin,
        shift: shift,
        date: DateTime(2026, 1, 26),
      ),
      7,
    );
    expect(
      FocusResolver.effectiveFocusWeekNumber(
        origin: origin,
        shift: shift,
        date: DateTime(2026, 3, 16),
      ),
      1, // 6 + 8 weeks = wraps to 1
    );
  });
}
