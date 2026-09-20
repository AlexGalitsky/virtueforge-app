import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/stoic_primary_button.dart';
import 'package:virtue_forge/features/settings/domain/models/app_settings.dart';
import 'package:virtue_forge/features/settings/presentation/cubit/settings_cubit.dart';

class MementoStep extends StatefulWidget {
  const MementoStep({super.key, required this.onOpenGrid});

  final VoidCallback onOpenGrid;

  @override
  State<MementoStep> createState() => _MementoStepState();
}

class _MementoStepState extends State<MementoStep> with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _fadeInController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState() ;

    // 1. Анимация пульсации точки (бесконечная)
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // 2. Задержка перед плавным появлением стоического текста
    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _fadeInController.forward();
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _fadeInController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final colors = context.colorScheme;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Spacer(),
            
            // Пульсирующая точка (Сингулярность / Вы здесь)
            FadeTransition(
              opacity: _pulseAnimation,
              child: Icon(
                Icons.circle, 
                size: 20, 
                color: colors.primary, // Белый или акцентный стоический свет
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Плавное проявление контента
            FadeTransition(
              opacity: _fadeInController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.tutorialMementoTitle, // «Вы здесь. Прямо сейчас.»
                    textAlign: TextAlign.center,
                    style: text.slideTitle,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.tutorialMementoBody,
                    textAlign: TextAlign.center,
                    style: text.body.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 48),
                  BlocBuilder<SettingsCubit, AppSettings>(
                    buildWhen: (a, b) => a.birthDate != b.birthDate,
                    builder: (context, settings) {
                      return StoicPrimaryButton(
                        label: settings.birthDate == null
                            ? l10n.tutorialSetBirthDate
                            : l10n.tutorialOpenLifeGrid,
                        onPressed: widget.onOpenGrid,
                      );
                    },
                  ),
                ],
              ),
            ),
            
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
