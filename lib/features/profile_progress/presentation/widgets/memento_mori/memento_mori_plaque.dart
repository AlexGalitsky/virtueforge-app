import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/profile_progress/domain/services/memento_mori_math.dart';
import 'package:virtue_forge/features/profile_progress/presentation/pages/memento_mori_page.dart';
import 'package:virtue_forge/features/settings/domain/models/app_settings.dart';
import 'package:virtue_forge/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:virtue_forge/features/settings/presentation/pages/birth_date_page.dart';

/// Compact Temple card that opens [MementoMoriPage] or birth-date setup.
class MementoMoriPlaque extends StatelessWidget {
  const MementoMoriPlaque({
    super.key,
    required this.loadPracticeOrigin,
  });

  final Future<DateTime?> Function() loadPracticeOrigin;

  Future<void> _open(BuildContext context, DateTime? birthDate) async {
    if (birthDate == null) {
      await Navigator.of(context).push<void>(
        MaterialPageRoute(builder: (_) => const BirthDatePage()),
      );
      return;
    }

    final origin =
        await loadPracticeOrigin() ?? WeekDateUtils.startOfWeek(DateTime.now());
    final forgeWeeks = MementoMoriMath.forgeCycleWeeks(
      birthDate: birthDate,
      practiceOrigin: origin,
    );

    if (!context.mounted) return;
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => MementoMoriPage(
          birthDate: birthDate,
          forgeCycleWeeks: forgeWeeks,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;

    return BlocBuilder<SettingsCubit, AppSettings>(
      buildWhen: (previous, current) => previous.birthDate != current.birthDate,
      builder: (context, settings) {
        final birthDate = settings.birthDate;
        final hasBirthDate = birthDate != null;

        return Material(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: () => _open(context, birthDate),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colors.outline.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    hasBirthDate
                        ? Icons.hourglass_bottom_outlined
                        : Icons.hourglass_empty_outlined,
                    color: colors.primary,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasBirthDate
                              ? l10n.mementoMoriTitle
                              : l10n.mementoMoriSetupTitle,
                          style: text.tileTitle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          hasBirthDate
                              ? l10n.mementoMoriPlaqueSubtitle
                              : l10n.mementoMoriSetupSubtitle,
                          style: text.body.copyWith(
                            color: colors.onSurface.withValues(alpha: 0.6),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: colors.onSurface.withValues(alpha: 0.35),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
