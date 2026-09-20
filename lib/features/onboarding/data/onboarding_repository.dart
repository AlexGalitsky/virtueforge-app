import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingRepository {
  Future<bool> hasCompletedOnboarding();

  Future<void> completeOnboarding();
}

class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this._prefs);

  static const _key = 'has_completed_onboarding';

  final SharedPreferences _prefs;

  @override
  Future<bool> hasCompletedOnboarding() async =>
      _prefs.getBool(_key) ?? false;

  @override
  Future<void> completeOnboarding() => _prefs.setBool(_key, true);
}
