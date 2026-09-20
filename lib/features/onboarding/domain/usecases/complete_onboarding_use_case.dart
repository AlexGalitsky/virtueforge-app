import 'package:virtue_forge/features/cycles/domain/usecases/start_first_cycle_use_case.dart';
import 'package:virtue_forge/features/onboarding/data/onboarding_repository.dart';

class CompleteOnboardingUseCase {
  CompleteOnboardingUseCase({
    required StartFirstCycleUseCase startFirstCycle,
    required OnboardingRepository onboardingRepository,
  })  : _startFirstCycle = startFirstCycle,
        _onboarding = onboardingRepository;

  final StartFirstCycleUseCase _startFirstCycle;
  final OnboardingRepository _onboarding;

  Future<void> call() async {
    await _startFirstCycle();
    await _onboarding.completeOnboarding();
  }
}
