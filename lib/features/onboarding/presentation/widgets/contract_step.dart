import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Необходим для HapticFeedback
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/stoic_primary_button.dart';

class ContractStep extends StatelessWidget {
  const ContractStep({super.key, required this.onAccept});

  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final colors = context.colorScheme;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              
              // Эмблема Ордена (Медальон вместо стандартных иконок)
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colors.primary.withValues(alpha: 0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.05),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.shield_outlined, // Щит как символ защиты своего разума
                    size: 44, 
                    color: colors.primary,
                  ),
                ),
              ),
              
              const SizedBox(height: 36),
              
              // Заголовок Инициации
              Text(
                l10n.tutorialContractTitle,
                textAlign: TextAlign.center,
                style: text.slideTitle.copyWith(
                  letterSpacing: 1.5,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Блок Манифеста (Контракта)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colors.surface.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colors.outline.withValues(alpha: 0.1),
                  ),
                ),
                child: Text(
                  l10n.tutorialContractBody,
                  textAlign: TextAlign.center,
                  style: text.body.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.8),
                    height: 1.6, // Увеличенный межстрочный интервал для читаемости
                  ),
                ),
              ),
              
              const Spacer(flex: 3),
              
              // Локальное облако / Конфиденциальность
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline, 
                    size: 14, 
                    color: colors.onSurface.withValues(alpha: 0.4),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    l10n.tutorialContractPrivacyNote,
                    style: text.caption.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.4),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Главная кнопка заключения контракта с Heavy Haptic
              SizedBox(
                width: double.infinity,
                child: StoicPrimaryButton(
                  label: l10n.tutorialContractCta.toUpperCase(),
                  onPressed: () async {
                    await HapticFeedback.heavyImpact();
                    
                    onAccept();
                  },
                ),
              ),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
