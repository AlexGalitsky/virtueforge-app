import 'package:flutter/material.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/profile_progress/domain/services/memento_mori_math.dart';
import 'package:virtue_forge/features/profile_progress/presentation/widgets/memento_mori/memento_mori_painter.dart';

/// Full-screen life calendar (Memento Mori).
class MementoMoriPage extends StatefulWidget {
  const MementoMoriPage({
    super.key,
    required this.birthDate,
    required this.forgeCycleWeeks,
  });

  final DateTime birthDate;
  final Set<int> forgeCycleWeeks;

  @override
  State<MementoMoriPage> createState() => _MementoMoriPageState();
}

class _MementoMoriPageState extends State<MementoMoriPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  Offset? _touchPosition;
  late int _livedWeeks;
  late int _currentWeekIndex;
  late int _remainingWeeks;

  @override
  void initState() {
    super.initState();
    _calculateLifeMetrics();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MementoMoriPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.birthDate != widget.birthDate) {
      _calculateLifeMetrics();
    }
  }

  void _calculateLifeMetrics() {
    final difference = DateTime.now().difference(widget.birthDate);
    _livedWeeks =
        (difference.inDays / 7).floor().clamp(0, MementoMoriMath.totalLifeWeeks);
    _currentWeekIndex = _livedWeeks;
    _remainingWeeks =
        (MementoMoriMath.totalLifeWeeks - _livedWeeks)
            .clamp(0, MementoMoriMath.totalLifeWeeks);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;

    final pastColor = colors.onSurface.withValues(alpha: 0.35);
    final forgeColor = colors.primary;
    final futureColor = colors.outline;

    return StoicPageScaffold(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(l10n.mementoMoriTitle, style: text.pageTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.mementoMoriWeeksSummary(_livedWeeks, _remainingWeeks),
                style: text.body.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.65),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: colors.outline.withValues(alpha: 0.25),
                    ),
                  ),
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() => _touchPosition = details.localPosition);
                    },
                    onPanEnd: (_) => setState(() => _touchPosition = null),
                    onTapDown: (details) {
                      setState(() => _touchPosition = details.localPosition);
                    },
                    child: RepaintBoundary(
                      child: AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, _) {
                          return CustomPaint(
                            size: Size.infinite,
                            painter: MementoMoriPainter(
                              livedWeeks: _livedWeeks,
                              forgeCycleWeeks: widget.forgeCycleWeeks,
                              currentWeekIndex: _currentWeekIndex,
                              pulseValue: _pulseController.value,
                              touchPosition: _touchPosition,
                              pastColor: pastColor,
                              forgeColor: forgeColor,
                              futureColor: futureColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.mementoMoriExploreHint,
                style: text.caption.copyWith(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
