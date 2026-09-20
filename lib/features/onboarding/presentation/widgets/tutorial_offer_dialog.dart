import 'package:flutter/material.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';

/// Offer initiation after onboarding. Returns `true` to begin tutorial.
Future<bool?> showTutorialOfferDialog(BuildContext context) {
  final l10n = context.l10n;
  final text = context.stoicText;
  final colors = context.colorScheme;

  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colors.primary.withValues(alpha: 0.22),
          ),
        ),
        title: Text(
          l10n.tutorialOfferTitle,
          style: text.sheetTitle.copyWith(fontSize: 20),
        ),
        content: Text(
          l10n.tutorialOfferBody,
          style: text.body.copyWith(
            height: 1.45,
            color: colors.onSurface.withValues(alpha: 0.8),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StoicPrimaryButton(
                label: l10n.tutorialOfferAccept,
                onPressed: () => Navigator.of(dialogContext).pop(true),
              ),
              const SizedBox(height: 10),
              StoicOutlinedButton(
                label: l10n.tutorialOfferLater,
                icon: null,
                onPressed: () => Navigator.of(dialogContext).pop(false),
              ),
            ],
          ),
        ],
      );
    },
  );
}
