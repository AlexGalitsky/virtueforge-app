import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/features/journal/presentation/widgets/strike/strike_painter.dart';
import 'package:virtue_forge/features/journal/presentation/widgets/strike/strike_particle.dart';

class StrikeCell extends StatefulWidget {
  final int strikes;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final double size;
  /// 1 = fully interactive today; lower for past/future columns.
  final double opacity;

  const StrikeCell({
    super.key,
    required this.strikes,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.size = 24,
    this.opacity = 1,
  });

  @override
  State<StrikeCell> createState() => _StrikeCellState();
}

class _StrikeCellState extends State<StrikeCell> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<StrikeParticle> _particles = [];
  Duration _lastElapsed = Duration.zero;

  // Локальные состояния для эффекта растворения (Dissolve)
  double _dissolveOpacity = 1.0;
  double _dissolveScale = 1.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Выносим расчет физики частиц ИЗ метода build в слушатель контроллера
    _controller.addListener(() {
      if (!_controller.isAnimating) return;

      final currentElapsed = _controller.lastElapsedDuration ?? Duration.zero;
      
      if (currentElapsed != Duration.zero && _lastElapsed != Duration.zero) {
        final dt = (currentElapsed - _lastElapsed).inMicroseconds / Duration.microsecondsPerSecond;
        
        setState(() {
          for (int i = 0; i < _particles.length; i++) {
            _particles[i].update(dt);
          }
          _particles.removeWhere((p) => !p.isAlive());
        });
      }
      
      _lastElapsed = currentElapsed;
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _particles.clear(); // Полностью выметаем все застрявшие частицы
          _lastElapsed = Duration.zero;
          if (widget.strikes == 0) {
            _resetDissolveState();
          }
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant StrikeCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.strikes > oldWidget.strikes) {
      // Эффект удара молота (добавление проступка)
      _resetDissolveState();
      _triggerHammerStrike();
    } else if (widget.strikes < oldWidget.strikes) {
      // Эффект остывания пепла (удаление проступка)
      _triggerAshDissolve(wasResetToZero: widget.strikes == 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resetDissolveState() {
    _dissolveOpacity = 1.0;
    _dissolveScale = 1.0;
  }

  void _triggerHammerStrike() {
    _lastElapsed = Duration.zero;
    final centerOffset = Offset(widget.size / 2, widget.size / 2);
    
    setState(() {
      _particles.clear(); 
      _particles.addAll(List.generate(12, (_) => StrikeParticle(center: centerOffset, isAsh: false)));
    });

    _controller.forward(from: 0.0);
  }

  void _triggerAshDissolve({required bool wasResetToZero}) {
    _lastElapsed = Duration.zero;
    final centerOffset = Offset(widget.size / 2, widget.size / 2);

    setState(() {
      _particles.clear(); 
      _particles.addAll(List.generate(8, (_) => StrikeParticle(center: centerOffset, isAsh: true)));
      
      if (wasResetToZero) {
        _dissolveOpacity = 0.0;
        _dissolveScale = 1.4; 
      }
    });

    _controller.forward(from: 0.0);
  }

  double _computeShakeOffset(double progress) {
    if (_particles.isNotEmpty && !_particles.first.isAsh) {
      if (progress == 0.0 || progress == 1.0) return 0.0;
      return 3.5 * math.exp(-6.0 * progress) * math.cos(28.0 * progress);
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final hasStrikes = widget.strikes > 0;
    final primary = context.colorScheme.primary;
    final strikeDot = context.stoicColors.strikeDot ?? Colors.black;
    final emptyBorder = context.colorScheme.outline.withValues(alpha: 0.55);

    return Opacity(
      opacity: widget.opacity,
      child: GestureDetector(
        onTap: widget.onTap,
        onLongPress: hasStrikes ? widget.onLongPress : null,
        onDoubleTap: widget.onDoubleTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final shake = _computeShakeOffset(_controller.value);

                return Transform.translate(
                  offset: Offset(shake, 0),
                  child: CustomPaint(
                    painter: StrikePainter(
                      particles: List.from(_particles),
                      strikeProgress: _controller.value,
                      baseColor: primary,
                    ),
                    child: child,
                  ),
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350), 
                curve: Curves.easeOutCubic,
                width: widget.size,
                height: widget.size,
                transform: Matrix4.identity()
                  ..translate(widget.size / 2, widget.size / 2)
                  ..scale(hasStrikes ? 1.0 : _dissolveScale)
                  ..translate(-widget.size / 2, -widget.size / 2),
                decoration: BoxDecoration(
                  color: hasStrikes 
                      ? strikeDot.withOpacity(_dissolveOpacity) 
                      : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: hasStrikes 
                        ? primary.withOpacity(_dissolveOpacity) 
                        : emptyBorder,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 150),
                    transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                    child: hasStrikes
                        ? Opacity(
                            opacity: _dissolveOpacity,
                            child: Text(
                              key: ValueKey(widget.strikes),
                              '${widget.strikes}',
                              style: context.stoicText.strikeCount(widget.size * 0.45),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
