import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtue_forge/core/di/injection_container.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/mentor/data/mentor_preferences.dart';
import 'package:virtue_forge/features/mentor/domain/services/local_mentor_engine.dart';
import 'package:virtue_forge/features/mentor/presentation/cubit/audience_cubit.dart';
import 'package:virtue_forge/features/mentor/presentation/pages/audience_history_page.dart';
import 'package:virtue_forge/features/mentor/presentation/pages/mentor_models_page.dart';
import 'package:virtue_forge/features/mentor/presentation/widgets/mentor_markdown_body.dart';
import 'package:virtue_forge/generated/l10n/app_localizations.dart';

class AudiencePage extends StatelessWidget {
  const AudiencePage({
    super.key,
    required this.virtueWeekNumber,
    required this.virtueLabel,
    this.misdeedSummary = '',
    this.note = '',
    this.totalMisdeeds = 0,
  });

  final int virtueWeekNumber;
  final String virtueLabel;
  final String misdeedSummary;
  final String note;
  final int totalMisdeeds;

  static Future<void> open(
    BuildContext context, {
    required int virtueWeekNumber,
    required String virtueLabel,
    String misdeedSummary = '',
    String note = '',
    int totalMisdeeds = 0,
  }) {
    final localeCode = Localizations.localeOf(context).languageCode;
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => AudienceCubit(
            modelStore: sl(),
            audiences: sl(),
            engine: sl<LocalMentorEngine>(),
            virtueWeekNumber: virtueWeekNumber,
            virtueLabel: virtueLabel,
            misdeedSummary: misdeedSummary,
            note: note,
            totalMisdeeds: totalMisdeeds,
            localeCode: localeCode,
          ),
          child: AudiencePage(
            virtueWeekNumber: virtueWeekNumber,
            virtueLabel: virtueLabel,
            misdeedSummary: misdeedSummary,
            note: note,
            totalMisdeeds: totalMisdeeds,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final l10n = context.l10n;
    final colors = context.colorScheme;

    return StoicPageScaffold(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(l10n.mentorAudienceTitle, style: text.pageTitle),
          actions: [
            IconButton(
              tooltip: l10n.mentorHistoryTitle,
              onPressed: () => AudienceHistoryPage.open(context),
              icon: const Icon(Icons.history),
            ),
            IconButton(
              tooltip: l10n.mentorModelsTitle,
              onPressed: () async {
                await MentorModelsPage.open(context);
                if (context.mounted) {
                  await context.read<AudienceCubit>().refreshModelStatus();
                }
              },
              icon: const Icon(Icons.memory_outlined),
            ),
          ],
        ),
        body: BlocConsumer<AudienceCubit, AudienceUiState>(
          listenWhen: (p, c) => p.error != c.error && c.error != null,
          listener: (context, state) {
            final msg = _errorMessage(l10n, state);
            if (msg != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
            }
          },
          builder: (context, state) {
            if (!state.disclaimerAccepted) {
              return _DisclaimerView(
                onAccept: () => context.read<AudienceCubit>().acceptDisclaimer(),
              );
            }

            final busy = state.phase == AudiencePhase.loadingModel ||
                state.phase == AudiencePhase.generating;

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              children: [
                Text(
                  '${l10n.mentorFocusLabel}: $virtueLabel',
                  style: text.eyebrowAccent,
                ),
                if (misdeedSummary.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(misdeedSummary, style: text.body),
                ],
                if (note.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    note,
                    style: text.body.copyWith(
                      fontStyle: FontStyle.italic,
                      color: colors.onSurface.withValues(alpha: 0.75),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  l10n.mentorRemainingToday(state.remaining),
                  style: text.captionAccent,
                ),
                if (!state.modelReady) ...[
                  const SizedBox(height: 16),
                  Text(l10n.mentorNeedModel, style: text.body),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () async {
                      await MentorModelsPage.open(context);
                      if (context.mounted) {
                        await context.read<AudienceCubit>().refreshModelStatus();
                      }
                    },
                    child: Text(l10n.mentorOpenModels),
                  ),
                ],
                if (state.phase == AudiencePhase.idle) ...[
                  const SizedBox(height: 16),
                  TextField(
                    maxLength: AudienceUiState.maxReflectionLength,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: l10n.mentorReflectionLabel,
                      alignLabelWithHint: true,
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: context.read<AudienceCubit>().setReflection,
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: state.modelReady && state.remaining > 0
                        ? () => context.read<AudienceCubit>().startAudience()
                        : null,
                    child: Text(l10n.mentorEnterAudience),
                  ),
                ],
                if (state.phase == AudiencePhase.loadingModel) ...[
                  const SizedBox(height: 24),
                  const LinearProgressIndicator(),
                  const SizedBox(height: 12),
                  Text(l10n.mentorLoadingModel, style: text.body),
                  const SizedBox(height: 4),
                  Text(l10n.mentorLoadingModelHint, style: text.captionAccent),
                ],
                if (state.phase == AudiencePhase.generating) ...[
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () =>
                        context.read<AudienceCubit>().stopAudience(),
                    icon: const Icon(Icons.stop),
                    label: Text(l10n.mentorStopAudience),
                  ),
                  if (state.turns.isEmpty ||
                      (state.turns.isNotEmpty &&
                          !state.turns.last.fromUser &&
                          state.turns.last.text.isEmpty)) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colors.primary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            l10n.mentorThinking,
                            style: text.captionAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
                if (state.turns.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(l10n.mentorResponseLabel, style: text.eyebrowAccent),
                  const SizedBox(height: 10),
                  for (final turn in state.turns)
                    if (turn.text.isNotEmpty || busy) ...[
                      Text(
                        turn.fromUser
                            ? l10n.mentorTurnYou
                            : l10n.mentorTurnMentor,
                        style: text.captionAccent,
                      ),
                      const SizedBox(height: 4),
                      if (turn.fromUser)
                        SelectableText(
                          turn.text,
                          style: text.body.copyWith(height: 1.65, fontSize: 16),
                        )
                      else if (turn.text.isEmpty)
                        Text('…', style: text.body)
                      else
                        MentorMarkdownBody(data: turn.text),
                      const SizedBox(height: 14),
                    ],
                ],
                if (state.canFollowUp) ...[
                  Text(
                    l10n.mentorFollowUpsLeft(state.followUpsRemaining),
                    style: text.captionAccent,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    maxLength: AudienceUiState.maxFollowUpLength,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: l10n.mentorFollowUpLabel,
                      alignLabelWithHint: true,
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: context.read<AudienceCubit>().setFollowUp,
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: state.followUp.trim().isEmpty
                        ? null
                        : () => context.read<AudienceCubit>().sendFollowUp(),
                    child: Text(l10n.mentorSendFollowUp),
                  ),
                ],
                if (state.phase == AudiencePhase.done) ...[
                  const SizedBox(height: 16),
                  Text(
                    state.interrupted
                        ? l10n.mentorSavedInterrupted
                        : l10n.mentorSavedDone,
                    style: text.captionAccent,
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  String? _errorMessage(AppLocalizations l10n, AudienceUiState state) {
    switch (state.error) {
      case AudienceError.dailyLimit:
        return l10n.mentorDailyLimit(MentorPreferences.dailyLimit);
      case AudienceError.modelMissing:
        return l10n.mentorNeedModel;
      case AudienceError.engine:
        return state.errorDetail ?? l10n.mentorEngineFailed;
      case null:
        return null;
    }
  }
}

class _DisclaimerView extends StatelessWidget {
  const _DisclaimerView({required this.onAccept});

  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.mentorDisclaimerTitle, style: text.sheetTitle),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                l10n.mentorDisclaimerBody,
                style: text.body.copyWith(height: 1.55),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: onAccept,
            child: Text(l10n.mentorDisclaimerAccept),
          ),
        ],
      ),
    );
  }
}
