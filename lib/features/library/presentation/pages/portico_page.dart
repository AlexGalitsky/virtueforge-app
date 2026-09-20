import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/library/data/essay_reader_preferences.dart';
import 'package:virtue_forge/features/library/domain/models/essay.dart';
import 'package:virtue_forge/features/library/presentation/bloc/portico_bloc.dart';
import 'package:virtue_forge/features/library/presentation/pages/essay_reader_page.dart';
import 'package:virtue_forge/features/mentor/presentation/pages/audience_page.dart';

class PorticoPage extends StatelessWidget {
  const PorticoPage({
    super.key,
    required this.readerPrefs,
  });

  final EssayReaderPreferences readerPrefs;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PorticoBloc, PorticoState>(
      listenWhen: (previous, current) {
        final prevErr =
            previous is PorticoLoaded ? previous.actionError : null;
        final currErr = current is PorticoLoaded ? current.actionError : null;
        return currErr != null && currErr != prevErr;
      },
      listener: (context, state) {
        if (state is! PorticoLoaded || state.actionError == null) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.actionError!)),
        );
        context
            .read<PorticoBloc>()
            .add(const PorticoEvent.actionErrorCleared());
      },
      child: _PorticoView(readerPrefs: readerPrefs),
    );
  }
}

class _PorticoView extends StatelessWidget {
  const _PorticoView({required this.readerPrefs});

  final EssayReaderPreferences readerPrefs;

  void _openEssay(
    BuildContext context, {
    required Essay essay,
    required List<Essay> weekEssays,
    required int focusWeekNumber,
  }) {
    EssayReaderPage.open(
      context,
      essay: essay,
      weekEssays: weekEssays,
      focusWeekNumber: focusWeekNumber,
    );
  }

  bool _canContinue(Essay essay) {
    final progress = readerPrefs.progressFor(essay.id);
    return progress != null && progress >= 0.05 && progress < 0.95;
  }

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final l10n = context.l10n;

    return StoicPageScaffold(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(l10n.porticoTitle, style: text.pageTitle),
          actions: [
            IconButton(
              tooltip: l10n.randomThought,
              icon: Icon(
                Icons.auto_awesome,
                color: context.colorScheme.primary,
              ),
              onPressed: () => context.read<PorticoBloc>().add(
                    const PorticoEvent.randomThoughtRequested(),
                  ),
            ),
          ],
        ),
        body: BlocBuilder<PorticoBloc, PorticoState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              failure: (message) =>
                  Center(child: Text(message, style: text.body)),
              loaded: (essays, focusWeekNumber, randomThought, actionError) {
                final virtueName = l10n.franklinVirtueName(focusWeekNumber);
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    StoicSettingsTile(
                      icon: Icons.forum_outlined,
                      title: l10n.mentorAudienceCta,
                      subtitle: l10n.mentorAudienceCtaSub,
                      onTap: () => AudiencePage.open(
                        context,
                        virtueWeekNumber: focusWeekNumber,
                        virtueLabel: virtueName,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (randomThought != null) ...[
                      Text(l10n.randomThought, style: text.eyebrowAccent),
                      const SizedBox(height: 12),
                      EssayCard(
                        virtueLabel: l10n
                            .franklinVirtueName(randomThought.virtueWeekNumber),
                        title: randomThought.title,
                        excerpt:
                            '${l10n.resolveCatalogKey(randomThought.authorKey)}. ${randomThought.snippet}',
                        hasAnalysis: randomThought.hasAnalysis,
                        canContinue: _canContinue(randomThought),
                        onReadMore: () => _openEssay(
                          context,
                          essay: randomThought,
                          weekEssays: essays,
                          focusWeekNumber: focusWeekNumber,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                    Text(l10n.forThisWeek, style: text.eyebrowAccent),
                    const SizedBox(height: 4),
                    Text(
                      l10n.franklinVirtueName(focusWeekNumber),
                      style: text.captionAccent,
                    ),
                    const SizedBox(height: 12),
                    if (essays.isEmpty)
                      Text(l10n.porticoEmptyWeek, style: text.body)
                    else
                      ...essays.map(
                        (essay) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: EssayCard(
                            virtueLabel: l10n
                                .franklinVirtueName(essay.virtueWeekNumber),
                            title: essay.title,
                            excerpt:
                                '${l10n.resolveCatalogKey(essay.authorKey)}. ${essay.snippet}',
                            hasAnalysis: essay.hasAnalysis,
                            canContinue: _canContinue(essay),
                            onReadMore: () => _openEssay(
                              context,
                              essay: essay,
                              weekEssays: essays,
                              focusWeekNumber: focusWeekNumber,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
