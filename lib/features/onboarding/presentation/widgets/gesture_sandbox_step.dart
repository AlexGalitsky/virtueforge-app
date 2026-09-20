import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/features/journal/presentation/widgets/strike/strike_cell.dart';

class GestureSandboxStep extends StatelessWidget {
  const GestureSandboxStep({
    super.key,
    required this.strikes,
    required this.gestureStep,
    required this.onTapCell,
    required this.onLongPressCell,
    required this.onSwipeDone,
  });

  final int strikes;
  final int gestureStep;
  final VoidCallback onTapCell;
  final VoidCallback onLongPressCell;
  final VoidCallback onSwipeDone;

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final colors = context.colorScheme;
    final l10n = context.l10n;

    final hint = switch (gestureStep) {
      0 => l10n.tutorialGestureTap,
      1 => l10n.tutorialGestureHold,
      2 => l10n.tutorialGestureSwipe,
      _ => l10n.tutorialGestureDone,
    };

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                "${l10n.tutorialGestureTitle} (3/3)",
                textAlign: TextAlign.center,
                style: text.slideTitle.copyWith(letterSpacing: 1.0),
              ),
              const SizedBox(height: 16),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    hint,
                    textAlign: TextAlign.center,
                    style: text.body.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.8),
                      height: 1.4,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Dismissible(
                key: ValueKey('sandbox-$gestureStep-$strikes'),
                direction: gestureStep == 2
                    ? DismissDirection.endToStart
                    : DismissDirection.none,
                confirmDismiss: (_) async {
                  await HapticFeedback.mediumImpact();
                  onSwipeDone();
                  return false;
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 24),
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: colors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        l10n.tutorialSandboxNotes,
                        style: text.tileTitle.copyWith(color: colors.primary),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.edit_note, color: colors.primary),
                    ],
                  ),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: strikes > 0
                          ? colors.primary.withValues(alpha: 0.4)
                          : colors.outline.withValues(alpha: 0.15),
                      width: strikes > 0 ? 1.5 : 1.0,
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: gestureStep == 0
                        ? () async {
                            await HapticFeedback.heavyImpact();
                            onTapCell();
                          }
                        : null,
                    onLongPress: gestureStep == 1
                        ? () async {
                            await HapticFeedback.lightImpact();
                            onLongPressCell();
                          }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.brightness_low,
                            size: 20,
                            color: colors.onSurface.withValues(alpha: 0.4),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            l10n.tutorialSandboxFocus,
                            style: text.tileTitle,
                          ),
                          const Spacer(),
                          StrikeCell(
                            strikes: strikes,
                            size: 30,
                            opacity: 1.0,
                            onTap: null,
                            onLongPress: null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                "VirtueForge • Franklin Grid Sandbox",
                style: text.caption.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.3),
                  letterSpacing: 1.0,
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
