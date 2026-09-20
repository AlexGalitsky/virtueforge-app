import 'package:flutter/material.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/pillar_progress_bar.dart';

/// Карточка стоической колонны в Храме Добродетелей.
class PillarCard extends StatelessWidget {
  final String title;
  final String description;
  final int level;
  final double progress;
  final IconData icon;
  final bool cracked;
  final VoidCallback? onTap;

  const PillarCard({
    super.key,
    required this.title,
    required this.description,
    required this.level,
    required this.progress,
    this.icon = Icons.account_balance,
    this.cracked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final muted = colors.outline;
    final text = context.stoicText;

    return AspectRatio(
      aspectRatio: 1,
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: cracked
                    ? colors.primary.withValues(alpha: 0.55)
                    : muted.withValues(alpha: 0.4),
                width: cracked ? 1.5 : 0.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: cracked ? muted : colors.primary,
                      size: 22,
                    ),
                    const Spacer(),
                    Text(
                      context.l10n.levelBadge(level),
                      style: text.levelBadge,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.cardTitleSmall,
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: text.caption,
                  ),
                ),
                PillarProgressBar(value: progress),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
