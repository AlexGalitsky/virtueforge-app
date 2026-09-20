import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/profile_progress/data/pillar_coach_repository.dart';
import 'package:virtue_forge/features/profile_progress/data/temple_dust_repository.dart';
import 'package:virtue_forge/features/profile_progress/presentation/bloc/temple_bloc.dart';
import 'package:virtue_forge/features/profile_progress/presentation/pages/pillar_detail_page.dart';
import 'package:virtue_forge/features/profile_progress/presentation/widgets/memento_mori/memento_mori_plaque.dart';
import 'package:virtue_forge/features/profile_progress/presentation/widgets/pillar_coach_pulse.dart';
import 'package:virtue_forge/features/profile_progress/presentation/widgets/stoic_pillar_widget.dart';
import 'package:virtue_forge/generated/l10n/app_localizations.dart';

class TemplePage extends StatelessWidget {
  const TemplePage({
    super.key,
    required this.loadPracticeOrigin,
    required this.coach,
    required this.dust,
  });

  final Future<DateTime?> Function() loadPracticeOrigin;
  final PillarCoachRepository coach;
  final TempleDustRepository dust;

  @override
  Widget build(BuildContext context) => _TempleView(
        loadPracticeOrigin: loadPracticeOrigin,
        coach: coach,
        dust: dust,
      );
}

class _TempleView extends StatefulWidget {
  const _TempleView({
    required this.loadPracticeOrigin,
    required this.coach,
    required this.dust,
  });

  final Future<DateTime?> Function() loadPracticeOrigin;
  final PillarCoachRepository coach;
  final TempleDustRepository dust;

  @override
  State<_TempleView> createState() => _TempleViewState();
}

class _TempleViewState extends State<_TempleView> {
  PillarCoachRepository get _coach => widget.coach;
  TempleDustRepository get _dust => widget.dust;
  var _showCoach = false;
  TempleDustNotice? _dustNotice;

  @override
  void initState() {
    super.initState();
    _coach.addListener(_onCoachChanged);
    _dust.addListener(_onDustChanged);
    _refreshCoach();
    _refreshDust();
  }

  @override
  void dispose() {
    _coach.removeListener(_onCoachChanged);
    _dust.removeListener(_onDustChanged);
    super.dispose();
  }

  void _onCoachChanged() => _refreshCoach();

  void _onDustChanged() => _refreshDust();

  Future<void> _refreshCoach() async {
    final show = await _coach.shouldShow();
    if (mounted && show != _showCoach) {
      setState(() => _showCoach = show);
    }
  }

  void _refreshDust() {
    final notice = _dust.pendingNotice;
    if (mounted && notice != _dustNotice) {
      setState(() => _dustNotice = notice);
    }
  }

  Future<void> _dismissCoach() async {
    await _coach.dismiss();
  }

  Future<void> _dismissDust() async {
    await _dust.dismissNotice();
  }

  Future<void> _openPillar({
    required int categoryId,
    required String motto,
  }) async {
    if (_showCoach) await _dismissCoach();
    if (!mounted) return;
    await PillarDetailPage.open(
      context,
      categoryId: categoryId,
      motto: motto,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;

    return StoicPageScaffold(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(l10n.templeTitle, style: text.pageTitle),
        ),
        body: BlocBuilder<TempleBloc, TempleState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              failure: (message) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    message,
                    style: text.body,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              loaded: (pillars, cycleInYear, cyclesPerYear) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: context.stoicColors.focusHighlight ??
                              colors.outline,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(l10n.characterStatus, style: text.eyebrow),
                          const SizedBox(height: 8),
                          Text(l10n.steadfastProgress, style: text.sheetTitle),
                          const SizedBox(height: 4),
                          Text(
                            l10n.currentCycle(cycleInYear, cyclesPerYear),
                            style: text.captionAccent,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    MementoMoriPlaque(
                      loadPracticeOrigin: widget.loadPracticeOrigin,
                    ),
                    if (_dustNotice != null) ...[
                      const SizedBox(height: 16),
                      _TempleDustBanner(
                        notice: _dustNotice!,
                        onDismiss: _dismissDust,
                      ),
                    ],
                    if (_showCoach) ...[
                      const SizedBox(height: 16),
                      _PillarCoachBanner(onDismiss: _dismissCoach),
                    ],
                    const SizedBox(height: 24),
                    Text(l10n.stoicPillarsSection, style: text.eyebrowAccent),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: pillars.length,
                      itemBuilder: (context, index) {
                        final pillar = pillars[index];
                        final motto =
                            _mottoForCategory(l10n, pillar.nameKey);
                        final card = StoicPillarWidget(
                          title: l10n.resolveCatalogKey(pillar.nameKey),
                          level: pillar.level,
                          currentXp: pillar.currentLevelXp,
                          nextLevelXp: pillar.nextLevelXp,
                          weekIntegrity: pillar.weekIntegrity,
                          motto: motto,
                          onTap: () => _openPillar(
                            categoryId: pillar.id,
                            motto: motto,
                          ),
                        );
                        return PillarCoachPulse(
                          enabled: _showCoach && index == 0,
                          child: card,
                        );
                      },
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

  String _mottoForCategory(AppLocalizations l10n, String nameKey) {
    switch (nameKey) {
      case 'stoicTemperance':
        return l10n.pillarMottoTemperance;
      case 'stoicWisdom':
        return l10n.pillarMottoWisdom;
      case 'stoicCourage':
        return l10n.pillarMottoCourage;
      case 'stoicJustice':
        return l10n.pillarMottoJustice;
      default:
        return '';
    }
  }
}

class _TempleDustBanner extends StatelessWidget {
  const _TempleDustBanner({
    required this.notice,
    required this.onDismiss,
  });

  final TempleDustNotice notice;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;

    return Material(
      color: colors.error.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 4, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.blur_on, color: colors.error, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.templeDustTitle,
                    style: text.tileTitle.copyWith(height: 1.3),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.templeDustBody(
                      notice.days,
                      notice.xpLostPerPillar,
                    ),
                    style: text.caption.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.7),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: l10n.pillarCoachDismiss,
              onPressed: onDismiss,
              icon: Icon(
                Icons.close,
                size: 18,
                color: colors.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PillarCoachBanner extends StatelessWidget {
  const _PillarCoachBanner({required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;

    return Material(
      color: colors.primary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 4, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.touch_app_outlined, color: colors.primary, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                l10n.pillarCoachBanner,
                style: text.body.copyWith(height: 1.35),
              ),
            ),
            IconButton(
              tooltip: l10n.pillarCoachDismiss,
              onPressed: onDismiss,
              icon: Icon(
                Icons.close,
                size: 18,
                color: colors.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
