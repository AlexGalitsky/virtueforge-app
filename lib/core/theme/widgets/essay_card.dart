import 'package:flutter/material.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';

/// Карточка эссе в Портике с ссылкой «Читать полностью».
class EssayCard extends StatelessWidget {
  final String title;
  final String excerpt;
  final String virtueLabel;
  final String? readMoreLabel;
  final VoidCallback? onReadMore;
  final bool hasAnalysis;
  final bool canContinue;

  const EssayCard({
    super.key,
    required this.title,
    required this.excerpt,
    required this.virtueLabel,
    this.readMoreLabel,
    this.onReadMore,
    this.hasAnalysis = false,
    this.canContinue = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;
    final linkLabel = readMoreLabel ??
        (canContinue ? l10n.continueReading : l10n.readFully);

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onReadMore,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colors.outline.withValues(alpha: 0.4),
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      virtueLabel.toUpperCase(),
                      style: text.eyebrowAccent,
                    ),
                  ),
                  if (hasAnalysis)
                    Text(
                      l10n.essayReaderHasComment,
                      style: text.captionAccent.copyWith(
                        color: colors.primary.withValues(alpha: 0.85),
                        fontSize: 11,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(title, style: text.cardTitle),
              const SizedBox(height: 8),
              Text(
                excerpt,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: text.body,
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: onReadMore,
                style: TextButton.styleFrom(
                  foregroundColor: colors.primary,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(linkLabel, style: text.link),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
