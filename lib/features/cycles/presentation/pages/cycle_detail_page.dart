import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:virtue_forge/core/di/injection_container.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/cycles/domain/models/cycle_detail_snapshot.dart';
import 'package:virtue_forge/features/cycles/domain/services/cycle_calculator.dart';
import 'package:virtue_forge/features/cycles/presentation/cubit/cycle_detail_cubit.dart';
import 'package:virtue_forge/generated/l10n/app_localizations.dart';

class CycleDetailPage extends StatelessWidget {
  const CycleDetailPage({
    super.key,
    required this.cycleId,
    required this.createCubit,
  });

  final int cycleId;
  final CycleDetailCubit Function() createCubit;

  static Future<void> open(BuildContext context, {required int cycleId}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CycleDetailPage(
          cycleId: cycleId,
          createCubit: () => sl<CycleDetailCubit>(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => createCubit()..load(cycleId),
      child: const _CycleDetailView(),
    );
  }
}

class _CycleDetailView extends StatelessWidget {
  const _CycleDetailView();

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final l10n = context.l10n;

    return StoicPageScaffold(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(l10n.cycleDetailTitle, style: text.pageTitle),
        ),
        body: BlocBuilder<CycleDetailCubit, CycleDetailState>(
          builder: (context, state) {
            return switch (state) {
              CycleDetailLoading() =>
                const Center(child: CircularProgressIndicator()),
              CycleDetailFailure(:final message) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(message, style: text.body),
                  ),
                ),
              CycleDetailLoaded(:final snapshot) =>
                _LoadedBody(snapshot: snapshot),
            };
          },
        ),
      ),
    );
  }
}

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({required this.snapshot});

  final CycleDetailSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = context.stoicText;
    final colors = context.colorScheme;
    final cycle = snapshot.cycle;
    final locale = Localizations.localeOf(context).toString();
    final dateFmt = DateFormat.yMMMd(locale);
    final endLabel = cycle.endedAt == null
        ? l10n.cycleDetailInProgress
        : dateFmt.format(cycle.endedAt!);
    final dateRange =
        '${dateFmt.format(cycle.startedAt)} — $endLabel';

    final maxVirtue = snapshot.virtueBars.fold<int>(
      0,
      (m, b) => b.strikes > m ? b.strikes : m,
    );
    final maxPillar = snapshot.pillarBars.fold<int>(
      0,
      (m, b) => b.strikes > m ? b.strikes : m,
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      children: [
        Text(
          l10n.cycleTitle(
            CycleCalculator.romanNumeral(cycle.cycleInYear),
            cycle.startedAt.year,
          ),
          style: text.sheetTitle,
        ),
        const SizedBox(height: 6),
        Text(dateRange, style: text.caption),
        if (cycle.isActive) ...[
          const SizedBox(height: 4),
          Text(
            l10n.cycleActiveSubtitle(
              cycle.weekInCycle ?? 1,
              CycleCalculator.weeksPerCycle,
            ),
            style: text.eyebrowAccent,
          ),
        ],
        const SizedBox(height: 20),
        Text(
          l10n.cycleDetailSuccessLabel(snapshot.successPercent),
          style: text.sheetTitle.copyWith(fontSize: 36),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.cycleDetailStrikesLabel(snapshot.totalStrikes),
          style: text.body,
        ),
        const SizedBox(height: 4),
        Text(
          l10n.cycleDetailWeakPillarLabel(
            _pillarName(l10n, snapshot.weakPillarId),
          ),
          style: text.body.copyWith(
            color: colors.onSurface.withValues(alpha: 0.75),
          ),
        ),
        if (snapshot.compare != null) ...[
          const SizedBox(height: 28),
          Text(l10n.cycleDetailCompareTitle, style: text.eyebrowAccent),
          const SizedBox(height: 12),
          _CompareBlock(compare: snapshot.compare!, currentWeak: snapshot.weakPillarId),
        ],
        const SizedBox(height: 28),
        Text(l10n.cycleDetailPillarsTitle, style: text.eyebrowAccent),
        const SizedBox(height: 12),
        for (final bar in snapshot.pillarBars)
          _StrikeBarRow(
            label: l10n.resolveCatalogKey(bar.nameKey),
            strikes: bar.strikes,
            maxStrikes: maxPillar == 0 ? 1 : maxPillar,
            caption: bar.weekCount == 0
                ? l10n.cycleDetailPillarNoWeeks
                : l10n.cycleDetailPillarAvgXp(bar.avgWeekXp),
          ),
        const SizedBox(height: 28),
        Text(l10n.cycleDetailVirtuesTitle, style: text.eyebrowAccent),
        const SizedBox(height: 12),
        for (final bar in snapshot.virtueBars)
          _StrikeBarRow(
            label: l10n.resolveCatalogKey(bar.nameKey),
            strikes: bar.strikes,
            maxStrikes: maxVirtue == 0 ? 1 : maxVirtue,
          ),
        const SizedBox(height: 28),
        Text(l10n.cycleDetailWeeksTitle, style: text.eyebrowAccent),
        const SizedBox(height: 8),
        Text(
          l10n.cycleDetailWeeksSubtitle,
          style: text.caption.copyWith(
            color: colors.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 16),
        if (snapshot.weekPoints.isEmpty)
          Text(
            l10n.cycleDetailWeeksEmpty,
            style: text.caption.copyWith(
              color: colors.onSurface.withValues(alpha: 0.55),
            ),
          )
        else ...[
          SizedBox(
            height: 120,
            child: CustomPaint(
              painter: _WeekStrikesPainter(
                points: snapshot.weekPoints,
                barColor: colors.error.withValues(alpha: 0.75),
                trackColor: colors.outline.withValues(alpha: 0.2),
                labelColor: colors.onSurface.withValues(alpha: 0.45),
              ),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.cycleDetailCleanDaysTotal(
              snapshot.weekPoints.fold<int>(0, (s, p) => s + p.cleanDays),
            ),
            style: text.body,
          ),
        ],
      ],
    );
  }

  String _pillarName(AppLocalizations l10n, int? pillarId) {
    switch (pillarId) {
      case 1:
        return l10n.resolveCatalogKey('stoicTemperance');
      case 2:
        return l10n.resolveCatalogKey('stoicWisdom');
      case 3:
        return l10n.resolveCatalogKey('stoicCourage');
      case 4:
        return l10n.resolveCatalogKey('stoicJustice');
      default:
        return '—';
    }
  }
}

class _CompareBlock extends StatelessWidget {
  const _CompareBlock({
    required this.compare,
    required this.currentWeak,
  });

  final CycleCompareSnapshot compare;
  final int? currentWeak;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = context.stoicText;
    final prev = compare.previous;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.cycleDetailCompareVs(
            CycleCalculator.romanNumeral(prev.cycleInYear),
            prev.startedAt.year,
          ),
          style: text.caption,
        ),
        const SizedBox(height: 12),
        _DeltaRow(
          label: l10n.cycleDetailCompareSuccess,
          delta: compare.successDelta,
          suffix: '%',
          invertColors: false,
        ),
        _DeltaRow(
          label: l10n.cycleDetailCompareStrikes,
          delta: compare.strikesDelta,
          suffix: '',
          invertColors: true,
        ),
        const SizedBox(height: 4),
        Text(
          l10n.cycleDetailCompareWeak(
            _pillarName(l10n, compare.previousWeakPillarId),
            _pillarName(l10n, currentWeak),
          ),
          style: text.body.copyWith(fontSize: 14),
        ),
      ],
    );
  }

  String _pillarName(AppLocalizations l10n, int? pillarId) {
    switch (pillarId) {
      case 1:
        return l10n.resolveCatalogKey('stoicTemperance');
      case 2:
        return l10n.resolveCatalogKey('stoicWisdom');
      case 3:
        return l10n.resolveCatalogKey('stoicCourage');
      case 4:
        return l10n.resolveCatalogKey('stoicJustice');
      default:
        return '—';
    }
  }
}

class _DeltaRow extends StatelessWidget {
  const _DeltaRow({
    required this.label,
    required this.delta,
    required this.suffix,
    required this.invertColors,
  });

  final String label;
  final int delta;
  final String suffix;
  final bool invertColors;

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final colors = context.colorScheme;
    final improved = invertColors ? delta < 0 : delta > 0;
    final worsened = invertColors ? delta > 0 : delta < 0;
    final color = improved
        ? const Color(0xFF8A9A5B)
        : worsened
            ? const Color(0xFFB85C38)
            : colors.onSurface.withValues(alpha: 0.55);
    final sign = delta > 0 ? '+' : '';

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(child: Text(label, style: text.tileTitle)),
          Text(
            '$sign$delta$suffix',
            style: text.tileTitle.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _StrikeBarRow extends StatelessWidget {
  const _StrikeBarRow({
    required this.label,
    required this.strikes,
    required this.maxStrikes,
    this.caption,
  });

  final String label;
  final int strikes;
  final int maxStrikes;
  final String? caption;

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
          if (caption != null) ...[
            const SizedBox(height: 2),
            Text(
              caption!,
              style: text.caption.copyWith(
                color: colors.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ],
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

class _WeekStrikesPainter extends CustomPainter {
  _WeekStrikesPainter({
    required this.points,
    required this.barColor,
    required this.trackColor,
    required this.labelColor,
  });

  final List<CycleWeekPoint> points;
  final Color barColor;
  final Color trackColor;
  final Color labelColor;

  @override
  void paint(Canvas canvas, Size size) {
    const slots = CycleCalculator.weeksPerCycle;
    final maxStrikes = points.fold<int>(
      1,
      (m, p) => p.strikes > m ? p.strikes : m,
    );
    final slotW = size.width / slots;
    final chartTop = 8.0;
    final chartBottom = size.height - 18;
    final chartH = chartBottom - chartTop;
    final byIndex = {for (final p in points) p.weekIndex: p};

    final trackPaint = Paint()..color = trackColor;
    final barPaint = Paint()..color = barColor;
    final textPainter = TextPainter(textDirection: ui.TextDirection.ltr);

    for (var i = 0; i < slots; i++) {
      final cx = slotW * i + slotW / 2;
      final barW = math.min(14.0, slotW * 0.55);
      final left = cx - barW / 2;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTRB(left, chartTop, left + barW, chartBottom),
          const Radius.circular(3),
        ),
        trackPaint,
      );

      final point = byIndex[i];
      if (point != null && point.strikes > 0) {
        final h = chartH * (point.strikes / maxStrikes);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTRB(left, chartBottom - h, left + barW, chartBottom),
            const Radius.circular(3),
          ),
          barPaint,
        );
      }

      textPainter.text = TextSpan(
        text: '${i + 1}',
        style: TextStyle(color: labelColor, fontSize: 10),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(cx - textPainter.width / 2, size.height - 14),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _WeekStrikesPainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.barColor != barColor ||
        oldDelegate.trackColor != trackColor;
  }
}
