import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtue_forge/core/di/injection_container.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/mentor/domain/models/mentor_audience.dart';
import 'package:virtue_forge/features/mentor/domain/repositories/mentor_repositories.dart';
import 'package:virtue_forge/features/mentor/presentation/widgets/mentor_markdown_body.dart';

class AudienceHistoryPage extends StatefulWidget {
  const AudienceHistoryPage({
    super.key,
    required this.audiences,
  });

  final AudienceRepository audiences;

  static Future<void> open(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AudienceHistoryPage(audiences: sl<AudienceRepository>()),
      ),
    );
  }

  @override
  State<AudienceHistoryPage> createState() => _AudienceHistoryPageState();
}

class _AudienceHistoryPageState extends State<AudienceHistoryPage> {
  late Future<List<MentorAudience>> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.audiences.recent();
  }

  Future<void> _reload() async {
    setState(() {
      _future = widget.audiences.recent();
    });
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final l10n = context.l10n;
    final colors = context.colorScheme;
    final locale = Localizations.localeOf(context).toString();
    final dateFmt = DateFormat.yMMMd(locale).add_Hm();

    return StoicPageScaffold(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(l10n.mentorHistoryTitle, style: text.pageTitle),
        ),
        body: FutureBuilder<List<MentorAudience>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            final items = snapshot.data ?? const <MentorAudience>[];
            if (items.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l10n.mentorHistoryEmpty, style: text.body),
              );
            }
            return RefreshIndicator(
              onRefresh: _reload,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final a = items[index];
                  final preview = a.userReflection.trim().isEmpty
                      ? a.aiResponse.trim()
                      : a.userReflection.trim();
                  return Material(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        await AudienceDetailPage.open(context, a);
                        if (mounted) await _reload();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colors.outline.withValues(alpha: 0.35),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dateFmt.format(a.createdAt.toLocal()),
                              style: text.captionAccent,
                            ),
                            const SizedBox(height: 4),
                            Text(a.virtueLabel, style: text.tileTitle),
                            if (preview.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(
                                preview,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: text.body.copyWith(
                                  color: colors.onSurface.withValues(alpha: 0.75),
                                ),
                              ),
                            ],
                            if (a.interrupted) ...[
                              const SizedBox(height: 6),
                              Text(
                                l10n.mentorHistoryInterrupted,
                                style: text.captionAccent,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class AudienceDetailPage extends StatelessWidget {
  const AudienceDetailPage({super.key, required this.audience});

  final MentorAudience audience;

  static Future<void> open(BuildContext context, MentorAudience audience) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AudienceDetailPage(audience: audience),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final l10n = context.l10n;
    final colors = context.colorScheme;
    final locale = Localizations.localeOf(context).toString();
    final dateFmt = DateFormat.yMMMd(locale).add_Hm();
    final turns = _parseTurns(audience.aiResponse);

    return StoicPageScaffold(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(l10n.mentorHistoryDetailTitle, style: text.pageTitle),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Text(
              dateFmt.format(audience.createdAt.toLocal()),
              style: text.captionAccent,
            ),
            const SizedBox(height: 6),
            Text(
              '${l10n.mentorFocusLabel}: ${audience.virtueLabel}',
              style: text.eyebrowAccent,
            ),
            if (audience.misdeedSummary.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(audience.misdeedSummary, style: text.body),
            ],
            if (audience.note.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                audience.note,
                style: text.body.copyWith(
                  fontStyle: FontStyle.italic,
                  color: colors.onSurface.withValues(alpha: 0.75),
                ),
              ),
            ],
            const SizedBox(height: 20),
            if (turns.isEmpty)
              MentorMarkdownBody(data: audience.aiResponse)
            else
              for (final turn in turns) ...[
                Text(
                  turn.fromUser ? l10n.mentorTurnYou : l10n.mentorTurnMentor,
                  style: text.captionAccent,
                ),
                const SizedBox(height: 4),
                if (turn.fromUser)
                  SelectableText(
                    turn.text,
                    style: text.body.copyWith(height: 1.55),
                  )
                else
                  MentorMarkdownBody(data: turn.text),
                const SizedBox(height: 16),
              ],
          ],
        ),
      ),
    );
  }

  static List<({bool fromUser, String text})> _parseTurns(String raw) {
    final lines = raw.split('\n');
    final turns = <({bool fromUser, String text})>[];
    bool? currentFromUser;
    final buf = StringBuffer();

    void flush() {
      final t = buf.toString().trim();
      if (currentFromUser != null && t.isNotEmpty) {
        turns.add((fromUser: currentFromUser, text: t));
      }
      buf.clear();
    }

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed == '— ученик —' || trimmed == '— you —') {
        flush();
        currentFromUser = true;
        continue;
      }
      if (trimmed == '— наставник —' || trimmed == '— mentor —') {
        flush();
        currentFromUser = false;
        continue;
      }
      if (currentFromUser == null) continue;
      if (buf.isNotEmpty) buf.writeln();
      buf.write(line);
    }
    flush();
    return turns;
  }
}
