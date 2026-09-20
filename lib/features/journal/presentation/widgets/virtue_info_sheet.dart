import 'package:flutter/material.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/features/journal/domain/models/ui_franklin_virtue.dart';

/// Краткая справка по добродетели (свайп → Info).
Future<void> showVirtueInfoSheet(
  BuildContext context, {
  required UIFranklinVirtue virtue,
}) {
  final l10n = context.l10n;
  final name = l10n.resolveCatalogKey(virtue.name);
  final description = l10n.resolveCatalogKey(virtue.description);

  return showModalBottomSheet<void>(
    context: context,
    backgroundColor:
        Theme.of(context).bottomNavigationBarTheme.backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      final text = sheetContext.stoicText;
      final colors = sheetContext.colorScheme;
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.outline.withValues(alpha: 0.4),
                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(name, style: text.sheetTitle),
            const SizedBox(height: 12),
            Text(
              description,
              style: text.body.copyWith(height: 1.45),
            ),
          ],
        ),
      );
    },
  );
}
