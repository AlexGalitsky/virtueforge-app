import 'package:flutter/material.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/stoic_primary_button.dart';

class FinaleStep extends StatelessWidget {
  const FinaleStep({super.key, required this.onEnter});

  final VoidCallback onEnter;

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

              // Имитация Портика: Подсвеченная первая цитата дня
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colors.surface.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colors.primary.withValues(alpha: 0.25),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.03),
                      blurRadius: 30,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.format_quote_rounded,
                      size: 32,
                      color: colors.primary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "«Сколько у тебя осталось времени, зависит не от тебя; но то, как ты его проживешь, зависит только от тебя».",
                      textAlign: TextAlign.center,
                      style: text.body.copyWith(
                        fontStyle: FontStyle.italic,
                        color: colors.onSurface.withValues(alpha: 0.9),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "СЕНЕКА",
                      style: text.caption.copyWith(
                        color: colors.primary,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // Заголовок запуска цикла
              Text(
                l10n.tutorialFinaleTitle, // «Ваш первый 13-недельный цикл запущен»
                textAlign: TextAlign.center,
                style: text.slideTitle,
              ),
              const SizedBox(height: 16),

              // Основной текст-манифест
              Text(
                l10n.tutorialFinaleBody,
                textAlign: TextAlign.center,
                style: text.body.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.7),
                  height: 1.5,
                ),
              ),

              const Spacer(flex: 3),

              // Информационная плашка о вечерней рефлексии
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: colors.outline.withValues(alpha: 0.1),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.notifications_active_outlined,
                      size: 16,
                      color: colors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Вечерняя рефлексия: сегодня в 20:00",
                      style: text.caption.copyWith(
                        color: colors.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Финальная кнопка
              SizedBox(
                width: double.infinity,
                child: StoicPrimaryButton(
                  label: l10n.tutorialEnterJournal.toUpperCase(), // «ВОЙТИ В ПОРТИК»
                  onPressed: onEnter,
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
