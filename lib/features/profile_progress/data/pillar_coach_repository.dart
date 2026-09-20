import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// One-shot coach mark: after the first evening reflection, invite the user
/// to open a Temple pillar for the XP audit.
abstract class PillarCoachRepository extends Listenable {
  /// Returns `true` if this call newly armed the coach (first reflection).
  Future<bool> armAfterFirstReflection();

  Future<bool> shouldShow();

  Future<void> dismiss();
}

class PillarCoachRepositoryImpl extends ChangeNotifier
    implements PillarCoachRepository {
  PillarCoachRepositoryImpl(this._prefs);

  static const _pendingKey = 'pillar_coach_pending';
  static const _seenKey = 'pillar_coach_seen';

  final SharedPreferences _prefs;

  @override
  Future<bool> armAfterFirstReflection() async {
    if (_prefs.getBool(_seenKey) ?? false) return false;
    if (_prefs.getBool(_pendingKey) ?? false) return false;
    await _prefs.setBool(_pendingKey, true);
    notifyListeners();
    return true;
  }

  @override
  Future<bool> shouldShow() async {
    if (_prefs.getBool(_seenKey) ?? false) return false;
    return _prefs.getBool(_pendingKey) ?? false;
  }

  @override
  Future<void> dismiss() async {
    await _prefs.setBool(_seenKey, true);
    await _prefs.setBool(_pendingKey, false);
    notifyListeners();
  }
}
