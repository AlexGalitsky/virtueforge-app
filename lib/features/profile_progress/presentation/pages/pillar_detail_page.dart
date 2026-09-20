import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:virtue_forge/core/di/injection_container.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/profile_progress/domain/models/xp_ledger_models.dart';
import 'package:virtue_forge/features/profile_progress/domain/services/progress_calculator.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/load_pillar_detail_use_case.dart';
import 'package:virtue_forge/features/profile_progress/presentation/cubit/pillar_detail_cubit.dart';
import 'package:virtue_forge/generated/l10n/app_localizations.dart';

class PillarDetailPage extends StatelessWidget {
  const PillarDetailPage({
    super.key,
    required this.categoryId,
    required this.motto,
    required this.loadPillarDetail,
  });

  final int categoryId;
  final String motto;
  final LoadPillarDetailUseCase loadPillarDetail;

  static Future<void> open(
    BuildContext context, {
    required int categoryId,
    required String motto,
  }) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => PillarDetailPage(
          categoryId: categoryId,
          motto: motto,
          loadPillarDetail: sl<LoadPillarDetailUseCase>(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PillarDetailCubit(loadPillarDetail)..load(categoryId),
      child: _PillarDetailView(motto: motto),
    );
  }
}

class _PillarDetailView extends StatelessWidget {
  const _PillarDetailView({required this.motto});

  final String motto;

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final l10n = context.l10n;

    return StoicPageScaffold(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(l10n.pillarDetailTitle, style: text.pageTitle),
        ),
        body: BlocBuilder<PillarDetailCubit, PillarDetailState>(
          builder: (context, state) {
            return switch (state) {
              PillarDetailLoading() =>
                const Center(child: CircularProgressIndicator()),
              PillarDetailFailure(:final message) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(message, style: text.body),
                  ),
                ),
              PillarDetailLoaded(:final snapshot) =>
                _LoadedBody(snapshot: snapshot, motto: motto),
            };
          },
        ),
      ),
    );
  }
}

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({required this.snapshot, required this.motto});

  final PillarDetailSnapshot snapshot;
  final String motto;

  @override
  Widget build(BuildContext context) {
    final pillar = snapshot.pillar;
    final l10n = context.l10n;
    final text = context.stoicText;
    final colors = context.colorScheme;
    final title = l10n.resolveCatalogKey(pillar.nameKey);
    final remaining = (pillar.nextLevelXp - pillar.currentLevelXp).clamp(0, 1 << 30);
    final integrity = pillar.weekIntegrity.clamp(0.0, 1.0);

    final statusLabel = integrity >= 0.8
        ? l10n.pillarIntegrityMonolith
        : integrity >= 0.2
            ? l10n.pillarIntegrityCracked
            : l10n.pillarIntegrityShattered;

    final statusDetail = integrity >= 0.8
        ? l10n.pillarDetailStatusCleanWeek
        : l10n.pillarDetailStatusWeekStrikes(snapshot.weekStrikeCount);

    final maxStrikes = snapshot.virtueBars.fold<int>(
      0,
      (m, b) => b.strikes > m ? b.strikes : m,
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      children: [
        Text(title, style: text.sheetTitle),
        const SizedBox(height: 6),
        Text(l10n.pillarLevelLabel(pillar.level), style: text.eyebrowAccent),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: pillar.lifetimeProgress.clamp(0.0, 1.0),
            minHeight: 10,
            backgroundColor: colors.outline.withValues(alpha: 0.2),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.pillarXpLabel(pillar.currentLevelXp, pillar.nextLevelXp),
          style: text.caption,
        ),
        const SizedBox(height: 4),
        Text(
          l10n.pillarDetailXpRemaining(remaining, pillar.level + 1),
          style: text.caption.copyWith(
            color: colors.onSurface.withValues(alpha: 0.65),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.pillarDetailIntegrityLine(statusLabel, statusDetail),
          style: text.body,
        ),
        if (motto.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            motto,
            style: text.body.copyWith(
              fontStyle: FontStyle.italic,
              color: colors.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
        const SizedBox(height: 28),
        Text(l10n.pillarDetailAuditTitle, style: text.eyebrowAccent),
        const SizedBox(height: 12),
        for (final bar in snapshot.virtueBars)
          _VirtueBarRow(
            label: l10n.resolveCatalogKey(bar.nameKey),
            strikes: bar.strikes,
            maxStrikes: maxStrikes == 0 ? 1 : maxStrikes,
          ),
        const SizedBox(height: 28),
        Text(l10n.pillarDetailLedgerTitle, style: text.eyebrowAccent),
        const SizedBox(height: 12),
        if (snapshot.events.isEmpty)
          Text(
            l10n.pillarDetailLedgerEmpty,
            style: text.caption.copyWith(
              color: colors.onSurface.withValues(alpha: 0.55),
            ),
          )
        else
          for (final event in snapshot.events)
            _LedgerRow(event: event),
        const SizedBox(height: 28),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.only(bottom: 8),
            title: Text(
              l10n.pillarDetailRulesTitle,
              style: text.eyebrowAccent,
            ),
            children: [
              _RulesCard(l10n: l10n),
            ],
          ),
        ),
      ],
    );
  }
}

class _VirtueBarRow extends StatelessWidget {
  const _VirtueBarRow({
    required this.label,
    required this.strikes,
    required this.maxStrikes,
  });

  final String label;
  final int strikes;
  final int maxStrikes;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;
    final fill = (strikes / maxStrikes).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(label, style: text.tileTitle)),
              Text(
                strikes == 0
                    ? l10n.pillarDetailStrikeIdeal
                    : l10n.pillarDetailStrikeCount(strikes),
                style: text.caption,
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fill,
              minHeight: 8,
              backgroundColor: colors.outline.withValues(alpha: 0.15),
              color: strikes == 0
                  ? colors.primary.withValues(alpha: 0.45)
                  : colors.error.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}

class _LedgerRow extends StatelessWidget {
  const _LedgerRow({required this.event});

  final XpLedgerEvent event;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;
    final positive = event.amount >= 0;
    final amountColor = positive
        ? const Color(0xFF8A9A5B)
        : const Color(0xFFB85C38);
    final date = DateFormat.MMMd(Localizations.localeOf(context).toString())
        .format(event.eventDate);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 72,
            child: Text(
              date,
              style: text.caption.copyWith(
                color: colors.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ),
          Expanded(
            child: Text(
              _labelFor(l10n, event),
              style: text.body.copyWith(fontSize: 14),
            ),
          ),
          Text(
            '${positive ? '+' : ''}${event.amount} XP',
            style: text.tileTitle.copyWith(color: amountColor, fontSize: 14),
          ),
        ],
      ),
    );
  }

  String _labelFor(AppLocalizations l10n, XpLedgerEvent event) {
    switch (event.kind) {
      case XpEventKind.weekBase:
        return l10n.xpEventWeekBase;
      case XpEventKind.cleanDay:
        return l10n.xpEventCleanDay;
      case XpEventKind.focusStrike:
        return l10n.xpEventFocusStrike;
      case XpEventKind.nonFocusStrike:
        return l10n.xpEventNonFocusStrike;
      case XpEventKind.archetypeBonus:
        return l10n.xpEventArchetypeBonus;
      case XpEventKind.dust:
        return l10n.xpEventDust;
      default:
        return event.kind;
    }
  }
}

class _RulesCard extends StatelessWidget {
  const _RulesCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final colors = context.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outline.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.pillarDetailRulesForge, style: text.tileTitle),
          const SizedBox(height: 8),
          Text(
            l10n.pillarDetailRulesForgeBody(
              ProgressCalculator.cleanDayBonus,
              ProgressCalculator.baseMaxWeeklyXp,
            ),
            style: text.body.copyWith(
              color: colors.onSurface.withValues(alpha: 0.75),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Text(l10n.pillarDetailRulesBreak, style: text.tileTitle),
          const SizedBox(height: 8),
          Text(
            l10n.pillarDetailRulesBreakBody(
              ProgressCalculator.focusStrikePenalty,
              ProgressCalculator.nonFocusStrikePenalty,
            ),
            style: text.body.copyWith(
              color: colors.onSurface.withValues(alpha: 0.75),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.pillarDetailRulesFloorNote,
            style: text.caption.copyWith(
              fontStyle: FontStyle.italic,
              color: colors.onSurface.withValues(alpha: 0.65),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
