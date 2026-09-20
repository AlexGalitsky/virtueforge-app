import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtue_forge/features/profile_progress/data/temple_dust_repository.dart';

void main() {
  late TempleDustRepositoryImpl dust;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    dust = TempleDustRepositoryImpl(prefs);
  });

  test('no dust before first activity stamp', () {
    expect(dust.dustDaysIfSettlingAt(DateTime(2026, 7, 28)), 0);
  });

  test('within 48h grace → 0 dust days', () async {
    final start = DateTime(2026, 7, 1, 12);
    await dust.recordActivity(start);
    expect(
      dust.dustDaysIfSettlingAt(start.add(const Duration(hours: 47))),
      0,
    );
  });

  test('just past 48h → 1 dust day', () async {
    final start = DateTime(2026, 7, 1, 12);
    await dust.recordActivity(start);
    expect(
      dust.dustDaysIfSettlingAt(start.add(const Duration(hours: 49))),
      1,
    );
  });

  test('past 48h + 24h → 2 dust days', () async {
    final start = DateTime(2026, 7, 1, 12);
    await dust.recordActivity(start);
    expect(
      dust.dustDaysIfSettlingAt(start.add(const Duration(hours: 48 + 24))),
      2,
    );
  });
}
