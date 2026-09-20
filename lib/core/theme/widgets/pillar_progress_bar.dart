import 'package:flutter/material.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';

/// Шкала XP колонны: высота 6–8dp, скруглённые края.
class PillarProgressBar extends StatelessWidget {
  /// Значение от 0.0 до 1.0.
  final double value;
  final double height;

  const PillarProgressBar({
    super.key,
    required this.value,
    this.height = 7,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.colorScheme.primary;
    final track = context.colorScheme.outline.withValues(alpha: 0.35);
    final clamped = value.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: SizedBox(
        height: height,
        child: LinearProgressIndicator(
          value: clamped,
          minHeight: height,
          backgroundColor: track,
          color: primary,
          borderRadius: BorderRadius.circular(height),
        ),
      ),
    );
  }
}
