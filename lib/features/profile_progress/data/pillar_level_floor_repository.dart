import 'package:shared_preferences/shared_preferences.dart';

/// Persists per-pillar level floors so columns never demote.
abstract class PillarLevelFloorRepository {
  Future<Map<int, int>> loadFloors();

  Future<void> saveFloor({required int categoryId, required int level});

  /// One-time archetype bonus from tutorial (+50 XP to one pillar).
  Future<int?> loadArchetypeBonusCategoryId();

  Future<void> saveArchetypeBonusCategoryId(int categoryId);

  Future<bool> hasGrantedArchetypeBonus();
}

class PillarLevelFloorRepositoryImpl implements PillarLevelFloorRepository {
  PillarLevelFloorRepositoryImpl(this._prefs);

  static const _floorPrefix = 'pillar_level_floor_';
  static const _bonusCategoryKey = 'tutorial_archetype_bonus_category';
  static const _bonusGrantedKey = 'tutorial_archetype_bonus_granted';
  static const int archetypeBonusXp = 50;

  final SharedPreferences _prefs;

  @override
  Future<Map<int, int>> loadFloors() async {
    final result = <int, int>{};
    for (final key in _prefs.getKeys()) {
      if (!key.startsWith(_floorPrefix)) continue;
      final id = int.tryParse(key.substring(_floorPrefix.length));
      if (id == null) continue;
      result[id] = _prefs.getInt(key) ?? 1;
    }
    return result;
  }

  @override
  Future<void> saveFloor({
    required int categoryId,
    required int level,
  }) {
    return _prefs.setInt('$_floorPrefix$categoryId', level);
  }

  @override
  Future<int?> loadArchetypeBonusCategoryId() async {
    if (!(_prefs.getBool(_bonusGrantedKey) ?? false)) return null;
    return _prefs.getInt(_bonusCategoryKey);
  }

  @override
  Future<void> saveArchetypeBonusCategoryId(int categoryId) async {
    await _prefs.setInt(_bonusCategoryKey, categoryId);
    await _prefs.setBool(_bonusGrantedKey, true);
  }

  @override
  Future<bool> hasGrantedArchetypeBonus() async =>
      _prefs.getBool(_bonusGrantedKey) ?? false;
}
