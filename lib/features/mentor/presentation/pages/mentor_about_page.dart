import 'package:flutter/material.dart';
import 'package:virtue_forge/core/di/injection_container.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/mentor/domain/repositories/mentor_repositories.dart';
import 'package:virtue_forge/features/mentor/presentation/pages/audience_history_page.dart';
import 'package:virtue_forge/features/mentor/presentation/pages/mentor_models_page.dart';

class MentorAboutPage extends StatelessWidget {
  const MentorAboutPage({
    super.key,
    required this.audiences,
  });

  final AudienceRepository audiences;

  static Future<void> open(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MentorAboutPage(audiences: sl<AudienceRepository>()),
      ),
    );
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
          title: Text(l10n.mentorAboutTitle, style: text.pageTitle),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Text(l10n.mentorAboutBody, style: text.body.copyWith(height: 1.55)),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () => MentorModelsPage.open(context),
              child: Text(l10n.mentorOpenModels),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => AudienceHistoryPage.open(context),
              child: Text(l10n.mentorHistoryTitle),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () async {
                await audiences.clearAll();
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.mentorClearAudiencesDone)),
                );
              },
              child: Text(l10n.mentorClearAudiences),
            ),
          ],
        ),
      ),
    );
  }
}
