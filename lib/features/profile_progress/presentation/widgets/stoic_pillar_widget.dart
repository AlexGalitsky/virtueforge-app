import 'package:flutter/material.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';

/// Temple pillar card: lifetime XP grows classically; visual integrity is
/// inverse (this week's remaining XP / base).
class StoicPillarWidget extends StatefulWidget {
  final String title;
  final int level;
  final int currentXp;
  final int nextLevelXp;
  final double weekIntegrity;
  final String motto;
  final VoidCallback? onTap;

  const StoicPillarWidget({
    super.key,
    required this.title,
    required this.level,
    required this.currentXp,
    required this.nextLevelXp,
    required this.weekIntegrity,
    required this.motto,
    this.onTap,
  });

  @override
  State<StoicPillarWidget> createState() => _StoicPillarWidgetState();
}

class _StoicPillarWidgetState extends State<StoicPillarWidget> {
  Offset _parallaxOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final lifetimeFill = widget.nextLevelXp <= 0
        ? 0.0
        : (widget.currentXp / widget.nextLevelXp).clamp(0.0, 1.0);
    final integrity = widget.weekIntegrity.clamp(0.0, 1.0);

    // Ideas.md: ≥80% monolith, <20% shattered, else cracks.
    late final double baseOpacity;
    late final double cracksOpacity;
    late final double shatteredOpacity;
    late final Color statusColor;
    late final String integrityLabel;

    if (integrity >= 0.8) {
      baseOpacity = 1.0;
      cracksOpacity = 0.0;
      shatteredOpacity = 0.0;
      statusColor = colors.onSurface.withValues(alpha: 0.8);
      integrityLabel = l10n.pillarIntegrityMonolith;
    } else if (integrity >= 0.2) {
      baseOpacity = 0.35;
      cracksOpacity = 1.0;
      shatteredOpacity = 0.0;
      statusColor = colors.onSurface.withValues(alpha: 0.6);
      integrityLabel = l10n.pillarIntegrityCracked;
    } else {
      baseOpacity = 0.0;
      cracksOpacity = 0.0;
      shatteredOpacity = 1.0;
      statusColor = colors.primary;
      integrityLabel = l10n.pillarIntegrityShattered;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final widgetSize = Size(constraints.maxWidth, constraints.maxHeight);

        return GestureDetector(
          onTap: widget.onTap,
          child: Listener(
            onPointerDown: (event) =>
                _updateParallax(event.localPosition, widgetSize),
            onPointerMove: (event) =>
                _updateParallax(event.localPosition, widgetSize),
            onPointerUp: (_) => setState(() => _parallaxOffset = Offset.zero),
            onPointerCancel: (_) =>
                setState(() => _parallaxOffset = Offset.zero),
            child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colors.surface,
                  Color.lerp(
                    colors.surface,
                    isDark
                        ? Colors.black
                        : colors.primary.withValues(alpha: 0.16),
                    isDark ? 0.45 : 0.22,
                  )!,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: integrity < 0.2
                    ? colors.primary.withValues(alpha: 0.25)
                    : colors.outline.withValues(alpha: 0.12),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: (isDark ? Colors.black : colors.shadow)
                      .withValues(alpha: isDark ? 0.3 : 0.12),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.title.toUpperCase(),
                  style: text.tileTitle.copyWith(
                    fontSize: 13,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  widget.motto.toUpperCase(),
                  style: TextStyle(
                    fontSize: 8,
                    color: colors.onSurface.withValues(alpha: 0.4),
                    letterSpacing: 1.0,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.pillarLevelLabel(widget.level),
                      style: text.captionAccent.copyWith(
                        fontSize: 9,
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      l10n.pillarXpLabel(widget.currentXp, widget.nextLevelXp),
                      style: TextStyle(
                        fontSize: 9,
                        color: colors.onSurface.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Lifetime bar — classical fill (Temple).
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: lifetimeFill,
                    backgroundColor: colors.onSurface.withValues(alpha: 0.08),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colors.primary.withValues(alpha: 0.8),
                    ),
                    minHeight: 3,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: RepaintBoundary(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (integrity >= 0.8)
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: baseOpacity * 0.15,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: colors.primary,
                                      blurRadius: 40,
                                      spreadRadius: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOutCubic,
                            opacity: baseOpacity,
                            child: Transform.translate(
                              offset: _parallaxOffset * 0.4,
                              child: Image.asset(
                                'assets/images/temple/pillar_base.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOutCubic,
                            opacity: cracksOpacity,
                            child: Transform.translate(
                              offset: _parallaxOffset * 0.7,
                              child: Image.asset(
                                'assets/images/temple/pillar_cracks.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOutCubic,
                            opacity: shatteredOpacity,
                            child: Transform.translate(
                              offset: _parallaxOffset * 1.0,
                              child: Image.asset(
                                'assets/images/temple/pillar_shattered.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.12),
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    integrityLabel.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        );
      },
    );
  }

  void _updateParallax(Offset localPosition, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    setState(() {
      _parallaxOffset = Offset(
        (localPosition.dx - centerX) / centerX * 4.5,
        (localPosition.dy - centerY) / centerY * 4.5,
      );
    });
  }
}
