import 'package:shared_preferences/shared_preferences.dart';

abstract class TutorialRepository {
  Future<bool> hasCompletedTutorial();

  Future<void> completeTutorial();

  /// Allows replaying from Order without clearing archetype bonus.
  Future<void> resetTutorialForReplay();
}

class TutorialRepositoryImpl implements TutorialRepository {
  TutorialRepositoryImpl(this._prefs);

  static const _key = 'has_completed_tutorial';

  final SharedPreferences _prefs;

  @override
  Future<bool> hasCompletedTutorial() async {
    if (_prefs.containsKey(_key)) {
      return _prefs.getBool(_key) ?? false;
    }
    // Legacy installs: onboarding already done before tutorial shipped.
    final onboarded = _prefs.getBool('has_completed_onboarding') ?? false;
    if (onboarded) {
      await _prefs.setBool(_key, true);
      return true;
    }
    return false;
  }

  @override
  Future<void> completeTutorial() => _prefs.setBool(_key, true);

  @override
  Future<void> resetTutorialForReplay() => _prefs.setBool(_key, false);
}
