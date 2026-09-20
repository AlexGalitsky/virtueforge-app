import 'package:flutter/material.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';

/// Горизонтальные точки-полоски для онбординга.
class StepIndicator extends StatelessWidget {
  final int length;
  final int currentIndex;
  final double activeWidth;
  final double inactiveWidth;
  final double height;

  const StepIndicator({
    super.key,
    required this.length,
    required this.currentIndex,
    this.activeWidth = 24,
    this.inactiveWidth = 8,
    this.height = 4,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.colorScheme.primary;
    final muted = context.colorScheme.outline.withValues(alpha: 0.45);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? activeWidth : inactiveWidth,
          height: height,
          decoration: BoxDecoration(
            color: isActive ? primary : muted,
            borderRadius: BorderRadius.circular(height),
          ),
        );
      }),
    );
  }
}
