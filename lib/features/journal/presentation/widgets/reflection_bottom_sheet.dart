import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/journal/domain/usecases/load_today_strike_context_use_case.dart';
import 'package:virtue_forge/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:virtue_forge/features/journal/presentation/forms/reflection_form.dart';
import 'package:virtue_forge/features/profile_progress/data/pillar_coach_repository.dart';
import 'package:virtue_forge/features/profile_progress/data/temple_dust_repository.dart';

/// Шторка вечерней рефлексии на reactive_forms.
class ReflectionBottomSheet extends StatelessWidget {
  const ReflectionBottomSheet({
    super.key,
    required this.todayContext,
    required this.coach,
    required this.dust,
  });

  final TodayStrikeContext todayContext;
  final PillarCoachRepository coach;
  final TempleDustRepository dust;

  static Future<void> show(
    BuildContext context, {
    required Future<TodayStrikeContext> Function() loadTodayContext,
    required PillarCoachRepository coach,
    required TempleDustRepository dust,
  }) async {
    final today = await loadTodayContext();
    if (!context.mounted) return;

    final armed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => BlocProvider.value(
        value: context.read<JournalBloc>(),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: ReflectionBottomSheet(
            todayContext: today,
            coach: coach,
            dust: dust,
          ),
        ),
      ),
    );

    if (armed != true || !context.mounted) return;

    final l10n = context.l10n;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.pillarCoachSnackbar),
        duration: const Duration(seconds: 7),
        action: SnackBarAction(
          label: l10n.navTemple,
          onPressed: () => context.go('/temple'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;

    return ReactiveFormBuilder(
      form: () => ReflectionForm.build(),
      builder: (context, form, child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          child: SingleChildScrollView(
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
                Text(l10n.dichotomyControl, style: text.sheetTitle),
                const SizedBox(height: 16),
                _TodayStrikeContextBlock(contextData: todayContext),
                const SizedBox(height: 16),
                _FormContent(form: form),
                const SizedBox(height: 24),
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    return StoicPrimaryButton(
                      label: l10n.finishDay,
                      onPressed: form.valid
                          ? () async {
                              final notes = ReflectionForm.toNotes(form);
                              context.read<JournalBloc>().add(
                                    JournalEvent.reflectionSaved(
                                      noteUncontrolled: notes.noteUncontrolled,
                                      noteControlled: notes.noteControlled,
                                    ),
                                  );
                              final armed = await coach.armAfterFirstReflection();
                              await dust.recordActivity();
                              if (!context.mounted) return;
                              Navigator.of(context).pop(armed);
                            }
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TodayStrikeContextBlock extends StatelessWidget {
  const _TodayStrikeContextBlock({required this.contextData});

  final TodayStrikeContext contextData;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = context.stoicText;
    final colors = context.colorScheme;

    if (contextData.isEmpty) {
      return Text(
        l10n.reflectionTodayEmpty,
        style: text.body.copyWith(
          color: colors.onSurface.withValues(alpha: 0.55),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.reflectionTodayContextTitle, style: text.tileTitle),
        const SizedBox(height: 8),
        ...contextData.groups.map((group) {
          final virtueName = l10n.resolveCatalogKey(group.virtue.name);
          final noteLines = group.notes.map((n) {
            final body = n.body?.trim();
            final detail = (body == null || body.isEmpty)
                ? l10n.reflectionStrikeNoNote
                : body;
            return l10n.reflectionStrikeLine(n.ordinal, detail);
          }).join('\n');

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.reflectionVirtueStrikeHeader(
                      virtueName,
                      group.strikesCount,
                    ),
                    style: text.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    noteLines,
                    style: text.body.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.75),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _FormContent extends StatelessWidget {
  const _FormContent({required this.form});

  final FormGroup form;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StoicReactiveTextField(
          control: ReflectionForm.uncontrolledControl(form),
          label: l10n.reflectionUncontrolledLabel,
          hint: l10n.reflectionUncontrolledHint,
        ),
        const SizedBox(height: 16),
        StoicReactiveTextField(
          control: ReflectionForm.controlledControl(form),
          label: l10n.reflectionControlledLabel,
          hint: l10n.reflectionControlledHint,
        ),
      ],
    );
  }
}
