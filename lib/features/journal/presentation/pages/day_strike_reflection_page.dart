import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/journal/domain/entities/strike_note_entry.dart';
import 'package:virtue_forge/features/journal/presentation/bloc/day_strike_detail_bloc.dart';
import 'package:virtue_forge/features/journal/presentation/forms/strike_note_form.dart';
import 'package:virtue_forge/features/journal/presentation/haptics/strike_haptics.dart';

/// Полноэкранное окно медитации над проступками дня×добродетели.
class DayStrikeReflectionPage extends StatelessWidget {
  const DayStrikeReflectionPage({super.key});

  static Future<void> open(
    BuildContext context, {
    required DayStrikeDetailBloc Function() createBloc,
    required int virtueId,
    required DateTime date,
  }) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => BlocProvider(
          create: (_) => createBloc()
            ..add(
              DayStrikeDetailEvent.started(
                virtueId: virtueId,
                date: date,
              ),
            ),
          child: const DayStrikeReflectionPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final l10n = context.l10n;

    return BlocListener<DayStrikeDetailBloc, DayStrikeDetailState>(
      listenWhen: (previous, current) {
        final prevErr =
            previous is DayStrikeDetailLoaded ? previous.actionError : null;
        final currErr =
            current is DayStrikeDetailLoaded ? current.actionError : null;
        return currErr != null && currErr != prevErr;
      },
      listener: (context, state) {
        if (state is! DayStrikeDetailLoaded || state.actionError == null) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.actionError!)),
        );
        context
            .read<DayStrikeDetailBloc>()
            .add(const DayStrikeDetailEvent.actionErrorCleared());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.dayStrikeReflectionTitle, style: text.pageTitle),
        ),
        body: SafeArea(
          child: BlocBuilder<DayStrikeDetailBloc, DayStrikeDetailState>(
            builder: (context, state) {
              return state.when(
                initial: () =>
                    const Center(child: CircularProgressIndicator()),
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                failure: (message) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(message, textAlign: TextAlign.center),
                  ),
                ),
                loaded: (
                  virtue,
                  date,
                  strikesCount,
                  notes,
                  canEdit,
                  actionError,
                ) {
                  final virtueName = l10n.resolveCatalogKey(virtue.name);
                  final dateLabel = DateFormat.yMMMEd(
                    Localizations.localeOf(context).toString(),
                  ).format(date);
                  final byOrdinal = <int, StrikeNoteEntry>{
                    for (final n in notes) n.ordinal: n,
                  };

                  return ListView(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                    children: [
                      Text(virtueName, style: text.sheetTitle),
                      const SizedBox(height: 4),
                      Text(
                        dateLabel,
                        style: text.body.copyWith(
                          color: context.colorScheme.onSurface
                              .withValues(alpha: 0.65),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.dayStrikeReflectionSubtitle,
                        style: text.body.copyWith(
                          color: context.colorScheme.onSurface
                              .withValues(alpha: 0.75),
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (canEdit) ...[
                        Row(
                          children: [
                            Text(
                              l10n.dayStrikeCountLabel(strikesCount),
                              style: text.tileTitle,
                            ),
                            const Spacer(),
                            IconButton(
                              tooltip: l10n.dayStrikeRemove,
                              onPressed: strikesCount > 0
                                  ? () {
                                      StrikeHaptics.undoFault();
                                      context
                                          .read<DayStrikeDetailBloc>()
                                          .add(
                                            const DayStrikeDetailEvent
                                                .strikeUpdated(amount: -1),
                                          );
                                    }
                                  : null,
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            IconButton(
                              tooltip: l10n.dayStrikeAdd,
                              onPressed: () {
                                StrikeHaptics.markFault();
                                context
                                    .read<DayStrikeDetailBloc>()
                                    .add(
                                      const DayStrikeDetailEvent.strikeUpdated(
                                        amount: 1,
                                      ),
                                    );
                              },
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ] else
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            l10n.dayStrikeCountLabel(strikesCount),
                            style: text.tileTitle,
                          ),
                        ),
                      if (strikesCount == 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Text(
                            canEdit
                                ? l10n.dayStrikeEmptyEditable
                                : l10n.dayStrikeEmptyReadonly,
                            style: text.body.copyWith(
                              color: context.colorScheme.onSurface
                                  .withValues(alpha: 0.6),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      else
                        ...List.generate(strikesCount, (index) {
                          final ordinal = index + 1;
                          final note = byOrdinal[ordinal];
                          return _StrikeNoteCard(
                            ordinal: ordinal,
                            body: note?.body,
                            canEdit: canEdit,
                          );
                        }),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _StrikeNoteCard extends StatelessWidget {
  const _StrikeNoteCard({
    required this.ordinal,
    required this.body,
    required this.canEdit,
  });

  final int ordinal;
  final String? body;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final colors = context.colorScheme;
    final l10n = context.l10n;
    final hasNote = body != null && body!.trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: colors.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: canEdit
              ? () => _openEditor(context, initial: body ?? '')
              : null,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.outline),
                  ),
                  child: Text('$ordinal', style: text.gridDay),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.dayStrikeItemTitle(ordinal),
                        style: text.tileTitle.copyWith(fontSize: 15),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        hasNote ? body! : l10n.dayStrikeNotePlaceholder,
                        style: text.body.copyWith(
                          color: colors.onSurface.withValues(
                            alpha: hasNote ? 0.9 : 0.5,
                          ),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                if (canEdit && hasNote)
                  IconButton(
                    tooltip: l10n.dayStrikeNoteDelete,
                    onPressed: () {
                      context.read<DayStrikeDetailBloc>().add(
                            DayStrikeDetailEvent.noteDeleted(ordinal: ordinal),
                          );
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: colors.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openEditor(BuildContext context, {required String initial}) {
    final bloc = context.read<DayStrikeDetailBloc>();
    final l10n = context.l10n;

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: ReactiveFormBuilder(
            form: () => StrikeNoteForm.build(initial: initial),
            builder: (context, form, child) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.dayStrikeItemTitle(ordinal),
                      style: context.stoicText.sheetTitle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.strikeNotePrompt,
                      style: context.stoicText.body.copyWith(
                        color: context.colorScheme.onSurface
                            .withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ReactiveTextField<String>(
                      formControl: StrikeNoteForm.noteControl(form),
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: l10n.strikeNoteHint,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    StoicPrimaryButton(
                      label: l10n.strikeNoteSave,
                      onPressed: () {
                        final note = StrikeNoteForm.toNote(form);
                        bloc.add(
                          DayStrikeDetailEvent.noteSaved(
                            ordinal: ordinal,
                            body: note ?? '',
                          ),
                        );
                        Navigator.of(sheetContext).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
