import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/navigation/app_router.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/onboarding/data/tutorial_repository.dart';
import 'package:virtue_forge/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';
import 'package:virtue_forge/features/onboarding/presentation/widgets/tutorial_offer_dialog.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    super.key,
    required this.completeOnboarding,
    required this.tutorialRepository,
  });

  final CompleteOnboardingUseCase completeOnboarding;
  final TutorialRepository tutorialRepository;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await widget.completeOnboarding();
    if (!mounted) return;

    final startTutorial = await showTutorialOfferDialog(context);
    if (!mounted) return;

    if (startTutorial == true) {
      context.go('/tutorial');
      return;
    }

    await widget.tutorialRepository.completeTutorial();
    if (!mounted) return;
    final laterHint = context.l10n.tutorialOfferLaterHint;
    context.go('/journal');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navContext = goRouter.routerDelegate.navigatorKey.currentContext;
      if (navContext == null) return;
      ScaffoldMessenger.of(navContext).showSnackBar(
        SnackBar(
          content: Text(laterHint),
          duration: const Duration(seconds: 5),
        ),
      );
    });
  }

  /// Возвращает виджет иллюстрации в зависимости от шага онбординга
  Widget _buildStepIllustration(int index, ColorScheme colors) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: KeyedSubtree(
        key: ValueKey<int>(index),
        child: _getIllustrationForIndex(index, colors),
      ),
    );
  }

  Widget _getIllustrationForIndex(int index, ColorScheme colors) {
    switch (index) {
      case 0:
        // Слайд 1: Компас стоицизма (4 вектора)
        return Icon(Icons.explore_outlined, size: 88, color: colors.primary);
      case 1:
        // Слайд 2: Карта Франклина (Интерактивный аудит)
        return Icon(Icons.grid_on_rounded, size: 88, color: colors.primary);
      case 2:
        // Слайд 3: Храм и Колонны (Инверсивный прогресс)
        return Icon(Icons.account_balance_outlined, size: 88, color: colors.primary);
      default:
        return Icon(Icons.shield_outlined, size: 88, color: colors.primary);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;
    
    final slides = [
      (title: l10n.onboardingSlide1Title, body: l10n.onboardingSlide1Body),
      (title: l10n.onboardingSlide2Title, body: l10n.onboardingSlide2Body),
      (title: l10n.onboardingSlide3Title, body: l10n.onboardingSlide3Body),
    ];
    final isLast = _currentPage == slides.length - 1;

    return StoicPageScaffold(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                // Кнопка пропуска для первых слайдов в стиле минимализма
                Align(
                  alignment: Alignment.topRight,
                  child: !isLast
                      ? TextButton(
                          onPressed: _finish,
                          child: Text(
                            l10n.skip, 
                            style: TextStyle(color: colors.onSurface.withValues(alpha: 0.5)),
                          ),
                        )
                      : const SizedBox(height: 48),
                ),
                const Spacer(),
                // Динамическая иллюстрация концепта вместо статичной иконки
                _buildStepIllustration(_currentPage, colors),
                const Spacer(),
                SizedBox(
                  height: 180,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    itemCount: slides.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              slides[index].title,
                              textAlign: TextAlign.center,
                              style: text.slideTitle,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              slides[index].body,
                              textAlign: TextAlign.center,
                              style: text.body.copyWith(
                                color: colors.onSurface.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
                StepIndicator(
                  length: slides.length,
                  currentIndex: _currentPage,
                ),
                const SizedBox(height: 32),
                StoicPrimaryButton(
                  label: isLast ? l10n.onboardingForge : l10n.onboardingNext,
                  onPressed: () {
                    if (!isLast) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOutCubic,
                      );
                    } else {
                      _finish();
                    }
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
