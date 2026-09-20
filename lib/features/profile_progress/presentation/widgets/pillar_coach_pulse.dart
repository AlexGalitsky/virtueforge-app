import 'package:flutter/material.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';

/// Soft pulse ring around a temple pillar while the coach mark is active.
class PillarCoachPulse extends StatefulWidget {
  const PillarCoachPulse({
    super.key,
    required this.enabled,
    required this.child,
  });

  final bool enabled;
  final Widget child;

  @override
  State<PillarCoachPulse> createState() => _PillarCoachPulseState();
}

class _PillarCoachPulseState extends State<PillarCoachPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    if (widget.enabled) _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant PillarCoachPulse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.enabled && _controller.isAnimating) {
      _controller
        ..stop()
        ..value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    final primary = context.colorScheme.primary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = Curves.easeInOut.transform(_controller.value);
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: primary.withValues(alpha: 0.15 + 0.35 * t),
                blurRadius: 8 + 10 * t,
                spreadRadius: 1 + 2 * t,
              ),
            ],
            border: Border.all(
              color: primary.withValues(alpha: 0.35 + 0.45 * t),
              width: 1.5,
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
