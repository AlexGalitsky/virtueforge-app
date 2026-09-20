import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/cycles/presentation/cubit/focus_selection_cubit.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/journal/presentation/widgets/stoic_virtue_wheel.dart';

/// Latin labels for the focus wheel (presentation-only ornament).
const _latinByWeek = <int, String>{
  1: 'Temperantia',
  2: 'Silentium',
  3: 'Ordo',
  4: 'Resolutio',
  5: 'Frugalitas',
  6: 'Industria',
  7: 'Sinceritas',
  8: 'Justitia',
  9: 'Moderatio',
  10: 'Mundities',
  11: 'Tranquillitas',
  12: 'Castitas',
  13: 'Humilitas',
};

class VirtuesSelectionPage extends StatelessWidget {
  const VirtuesSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FocusSelectionCubit, FocusSelectionState>(
      listenWhen: (p, c) => c.error != null && c.error != p.error,
      listener: (context, state) {
        if (state.error == null) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error!)),
        );
      },
      builder: (context, state) {
        final l10n = context.l10n;
        final text = context.stoicText;
        final colors = context.colorScheme;

        return Scaffold(
          backgroundColor: colors.surface,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: colors.onSurface,
            elevation: 0,
          ),
          body: SafeArea(
            child: state.loading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        l10n.focusSelectTitle,
                        style: text.eyebrowAccent.copyWith(
                          color: colors.onSurface.withValues(alpha: 0.6),
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.focusSelectSubtitle,
                        style: text.sheetTitle,
                      ),
                      const Spacer(),
                      if (state.virtues.isNotEmpty)
                        StoicVirtueWheel(
                          key: ValueKey(state.virtues.length),
                          initialIndex: (state.selectedWeekNumber - 1)
                              .clamp(0, state.virtues.length - 1),
                          virtues: _wheelItems(context, state.virtues),
                          onVirtueChanged: (index) {
                            final week =
                                state.virtues[index].defaultWeekNumber;
                            context
                                .read<FocusSelectionCubit>()
                                .selectWeekNumber(week);
                          },
                        ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          l10n.focusSelectHint(state.selectedWeekNumber),
                          textAlign: TextAlign.center,
                          style: text.caption.copyWith(
                            color: colors.onSurface.withValues(alpha: 0.6),
                            height: 1.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: StoicPrimaryButton(
                          label: l10n.focusSelectConfirm,
                          isLoading: state.saving,
                          onPressed: state.saving
                              ? null
                              : () async {
                                  final ok = await context
                                      .read<FocusSelectionCubit>()
                                      .confirm();
                                  if (ok && context.mounted) {
                                    Navigator.of(context).pop(true);
                                  }
                                },
                        ),
                      ),
                      const SizedBox(height: 28),
                    ],
                  ),
          ),
        );
      },
    );
  }

  List<(String, String)> _wheelItems(
    BuildContext context,
    List<FranklinVirtue> virtues,
  ) {
    final l10n = context.l10n;
    return virtues
        .map(
          (v) => (
            l10n.resolveCatalogKey(v.name),
            _latinByWeek[v.defaultWeekNumber] ?? '',
          ),
        )
        .toList();
  }
}
