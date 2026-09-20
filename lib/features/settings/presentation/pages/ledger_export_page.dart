import 'package:flutter/material.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';

/// Placeholder for the yearly PDF «Ledger of the Soul» export.
class LedgerExportPage extends StatelessWidget {
  const LedgerExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final colors = context.colorScheme;
    final l10n = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final parchment = isDark
        ? Color.lerp(colors.surface, colors.primary, 0.06)!
        : Color.lerp(colors.surface, const Color(0xFFD4C4A8), 0.35)!;

    return StoicPageScaffold(
      child: Scaffold(
        backgroundColor: parchment,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: colors.onSurface,
          title: Text(l10n.ledgerExportAppBar, style: text.captionAccent),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
          children: [
            Icon(
              Icons.menu_book_outlined,
              size: 40,
              color: colors.primary.withValues(alpha: 0.85),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.ledgerExportTitle,
              style: text.sheetTitle.copyWith(height: 1.25),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.ledgerExportLead,
              style: text.body.copyWith(
                height: 1.55,
                color: colors.onSurface.withValues(alpha: 0.82),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              l10n.ledgerExportBody,
              style: text.body.copyWith(
                height: 1.55,
                color: colors.onSurface.withValues(alpha: 0.78),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: colors.primary.withValues(alpha: 0.28),
                  ),
                  bottom: BorderSide(
                    color: colors.primary.withValues(alpha: 0.28),
                  ),
                ),
              ),
              child: Text(
                l10n.ledgerExportClosing,
                textAlign: TextAlign.center,
                style: text.quote.copyWith(
                  fontSize: 16,
                  height: 1.45,
                  color: colors.onSurface.withValues(alpha: 0.9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
