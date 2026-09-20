import 'package:flutter/material.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_text_styles.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';

class ArchetypeStep extends StatelessWidget {
  const ArchetypeStep({
    super.key, 
    required this.selectedId,
    required this.bonusAlreadyGranted,
    required this.onSelect,
  });

  final int? selectedId;
  final bool bonusAlreadyGranted;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final colors = context.colorScheme;
    final l10n = context.l10n;

    final options = <(int, String, String)>[
      (2, l10n.stoicWisdom, l10n.tutorialArchetypeWisdom),
      (3, l10n.stoicCourage, l10n.tutorialArchetypeCourage),
      (4, l10n.stoicJustice, l10n.tutorialArchetypeJustice),
      (1, l10n.stoicTemperance, l10n.tutorialArchetypeTemperance),
    ];

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                l10n.tutorialArchetypeTitle,
                textAlign: TextAlign.center,
                style: text.slideTitle,
              ),
              const SizedBox(height: 12),
              Text(
                bonusAlreadyGranted
                    ? l10n.tutorialArchetypeReplayBody
                    : l10n.tutorialArchetypeBody,
                textAlign: TextAlign.center,
                style: text.body.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.6),
                ),
              ),
              
              const Spacer(flex: 2),

              // Визуализация Храма: 4 вертикальные колонны в ряд
              SizedBox(
                height: 280,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0; i < options.length; i++) ...[
                      if (i > 0) const SizedBox(width: 12),
                      Expanded(
                        child: _TempleColumn(
                          id: options[i].$1,
                          title: options[i].$2,
                          isSelected: selectedId == options[i].$1,
                          colors: colors,
                          textStyle: text,
                          onTap: () => onSelect(options[i].$1),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // Текстовая расшифровка выбранной в данный момент добродетели
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: selectedId != null
                    ? Column(
                        key: ValueKey<int>(selectedId!),
                        children: [
                          Text(
                            options.firstWhere((e) => e.$1 == selectedId).$3,
                            textAlign: TextAlign.center,
                            style: text.body.copyWith(color: colors.onSurface),
                          ),
                          if (!bonusAlreadyGranted) ...[
                            const SizedBox(height: 8),
                            Text(
                              "+50 XP ${l10n.stoicWisdom}",
                              style: text.caption.copyWith(
                                color: colors.primary,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ],
                      )
                    : Text(
                        l10n.tutorialArchetypeReplayBody,
                        style: text.caption.copyWith(
                          color: colors.onSurface.withValues(alpha: 0.4),
                        ),
                      ),
              ),
              
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}

// Приватный виджет суровой стоической колонны
class _TempleColumn extends StatelessWidget {
  const _TempleColumn({
    required this.id,
    required this.title,
    required this.isSelected,
    required this.colors,
    required this.textStyle,
    required this.onTap,
  });

  final int id;
  final String title;
  final bool isSelected;
  final ColorScheme colors;
  final StoicTextStyles textStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          // Если выбрана — плавно заливается глубоким тоном
          color: isSelected 
              ? colors.primary.withValues(alpha: 0.12) 
              : Colors.transparent,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          border: Border.all(
            color: isSelected ? colors.primary : colors.outline.withValues(alpha: 0.15),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            // Антаблемент (верхушка колонны)
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: isSelected ? colors.primary : colors.outline.withValues(alpha: 0.3),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
              ),
            ),
            
            const Spacer(),
            
            // Вертикальный текст (название добродетели пишется сверху вниз)
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                title.toUpperCase(),
                style: textStyle.tileTitle.copyWith(
                  fontSize: 14,
                  letterSpacing: 2.0,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w300,
                  color: isSelected ? colors.primary : colors.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ),
            
            const Spacer(),
            
            // База колонны / Индикатор уровня (заполняется при активации бонуса)
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: isSelected ? 24 : 8,
              width: double.infinity,
              color: isSelected ? colors.primary : colors.outline.withValues(alpha: 0.2),
              child: isSelected 
                ? const Center(
                    child: Text(
                      '+50', 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : null,
            ),
          ],
        ),
      ),
    );
  }
}
