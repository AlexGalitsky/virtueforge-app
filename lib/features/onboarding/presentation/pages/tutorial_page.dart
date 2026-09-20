import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/cycle_repository.dart';
import 'package:virtue_forge/features/journal/presentation/haptics/strike_haptics.dart';
import 'package:virtue_forge/features/onboarding/data/tutorial_repository.dart';
import 'package:virtue_forge/features/onboarding/presentation/widgets/archetype_step.dart';
import 'package:virtue_forge/features/onboarding/presentation/widgets/contract_step.dart';
import 'package:virtue_forge/features/onboarding/presentation/widgets/finale_step.dart';
import 'package:virtue_forge/features/onboarding/presentation/widgets/gesture_sandbox_step.dart';
import 'package:virtue_forge/features/onboarding/presentation/widgets/memento_step.dart';
import 'package:virtue_forge/features/profile_progress/data/pillar_level_floor_repository.dart';
import 'package:virtue_forge/features/profile_progress/domain/services/memento_mori_math.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/sync_xp_ledger_use_case.dart';
import 'package:virtue_forge/features/profile_progress/presentation/pages/memento_mori_page.dart';
import 'package:virtue_forge/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:virtue_forge/features/settings/presentation/pages/birth_date_page.dart';

/// Post-onboarding initiation flow (replayable from Order).
class TutorialPage extends StatefulWidget {
  const TutorialPage({
    super.key,
    required this.tutorialRepository,
    required this.levelFloorRepository,
    required this.cycleRepository,
    required this.syncXpLedger,
  });

  final TutorialRepository tutorialRepository;
  final PillarLevelFloorRepository levelFloorRepository;
  final CycleRepository cycleRepository;
  final SyncXpLedgerUseCase syncXpLedger;

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  int _page = 0;
  int? _selectedCategoryId;
  bool _bonusAlreadyGranted = false;
  int _sandboxStrikes = 0;
  int _gestureStep = 0; // 0 tap, 1 long-press, 2 swipe done

  static const _steps = 5;

  @override
  void initState() {
    super.initState();
    widget.levelFloorRepository.hasGrantedArchetypeBonus().then((granted) {
      if (mounted) setState(() => _bonusAlreadyGranted = granted);
    });
  }

  Future<void> _finish() async {
    await widget.tutorialRepository.completeTutorial();
    if (!mounted) return;
    context.go('/journal');
  }

  void _next() {
    if (_page >= _steps - 1) {
      _finish();
      return;
    }
    setState(() {
      _page++;
    });
  }

  Future<void> _onSelectArchetype(int categoryId) async {
    setState(() => _selectedCategoryId = categoryId);
    if (!_bonusAlreadyGranted) {
      await widget.levelFloorRepository.saveArchetypeBonusCategoryId(categoryId);
      await widget.syncXpLedger();
      setState(() => _bonusAlreadyGranted = true);
    }
  }

  Future<void> _openMemento(BuildContext context) async {
    final birthDate = context.read<SettingsCubit>().state.birthDate;
    if (birthDate == null) {
      // После возврата из BirthDatePage даем UI обновиться, чтобы кнопка MementoStep
      // изменила надпись на "Открыть сетку"
      await Navigator.of(context).push<void>(
        MaterialPageRoute(builder: (_) => const BirthDatePage()),
      );
      if (mounted) setState(() {}); 
      return;
    }
    final origin = await widget.cycleRepository.practiceOrigin() ??
        WeekDateUtils.startOfWeek(DateTime.now());
    if (!context.mounted) return;
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => MementoMoriPage(
          birthDate: birthDate,
          forgeCycleWeeks: MementoMoriMath.forgeCycleWeeks(
            birthDate: birthDate,
            practiceOrigin: origin,
          ),
        ),
      ),
    );
  }

  /// Фабрика шагов онбординга. Каждому шагу принудительно задается ValueKey, 
  /// чтобы AnimatedSwitcher понимал, что виджет сменился, и запускал анимацию.
  Widget _buildStepWidget(int page) {
    switch (page) {
      case 0:
        return MementoStep(
          key: const ValueKey('step_memento'),
          onOpenGrid: () => _openMemento(context),
        );
      case 1:
        return ArchetypeStep(
          key: const ValueKey('step_archetype'),
          selectedId: _selectedCategoryId,
          bonusAlreadyGranted: _bonusAlreadyGranted,
          onSelect: _onSelectArchetype,
        );
      case 2:
        return ContractStep(
          key: const ValueKey('step_contract'),
          onAccept: () async {
            await StrikeHaptics.markFault();
            _next();
          },
        );
      case 3:
        return GestureSandboxStep(
          key: const ValueKey('step_sandbox'),
          strikes: _sandboxStrikes,
          gestureStep: _gestureStep,
          onTapCell: () {
            if (_gestureStep != 0) return;
            StrikeHaptics.markFault();
            setState(() {
              _sandboxStrikes = 1;
              _gestureStep = 1;
            });
          },
          onLongPressCell: () {
            if (_gestureStep != 1) return;
            StrikeHaptics.undoFault();
            setState(() {
              _sandboxStrikes = 0;
              _gestureStep = 2;
            });
          },
          onSwipeDone: () {
            if (_gestureStep != 2) return;
            setState(() => _gestureStep = 3);
          },
        );
      case 4:
        return FinaleStep(
          key: const ValueKey('step_finale'),
          onEnter: _finish,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;

    // Флаг блокировки нижней кнопки "Далее"
    final isNextDisabled = (_page == 1 && _selectedCategoryId == null) ||
                           (_page == 3 && _gestureStep < 3);

    return StoicPageScaffold(
      child: Scaffold(
        backgroundColor: colors.surface,
        body: SafeArea(
          child: Column(
            children: [
              // Кнопка пропуска обучения в правом верхнем углу
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _finish,
                  child: Text(
                    l10n.skip,
                    style: TextStyle(
                      color: colors.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ),
              
              // Область контента с кинематографичным растворением экранов
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 450),
                  switchInCurve: Curves.easeInCubic,
                  switchOutCurve: Curves.easeOutCubic,
                  // Кастомный LayoutBuilder убирает подергивания размеров при наложении шагов
                  layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        ...previousChildren,
                        if (currentChild case final child?) child,
                      ],
                    );
                  },
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: _buildStepWidget(_page),
                ),
              ),
              
              // Нижний блок управления: Прогресс-бар и контекстная Стоическая кнопка
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StepIndicator(length: _steps, currentIndex: _page),
                    const SizedBox(height: 20),
                    
                    // Кнопка "Далее" скрывается на Шаге 2 (Контракт) и Шаге 4 (Финал), 
                    // так как там используются их собственные уникальные CTA-кнопки.
                    if (_page != 2 && _page != 4)
                      SizedBox(
                        width: double.infinity,
                        child: StoicPrimaryButton(
                          label: l10n.onboardingNext,
                          onPressed: isNextDisabled ? null : _next,
                        ),
                      ),
                      
                    // Подсказка, если пользователь застрял на выборе Колонны
                    if (_page == 1 && _selectedCategoryId == null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          l10n.tutorialPickArchetypeHint,
                          style: text.caption.copyWith(
                            color: colors.onSurface.withValues(alpha: 0.5),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
