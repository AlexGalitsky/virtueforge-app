import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';


class StoicVirtueWheel extends StatefulWidget {
  const StoicVirtueWheel({
    super.key,
    required this.virtues,
    required this.onVirtueChanged,
    this.initialIndex = 0,
  });

  final List<(String name, String latin)> virtues;
  final ValueChanged<int> onVirtueChanged;
  final int initialIndex;

  @override
  State<StoicVirtueWheel> createState() => _StoicVirtueWheelState();
}

class _StoicVirtueWheelState extends State<StoicVirtueWheel> {
  late final FixedExtentScrollController _scrollController;
  double _scrollOffset = 0.0;
  int _lastTargetIndex = 0;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialIndex.clamp(0, widget.virtues.length - 1);
    _scrollController = FixedExtentScrollController(initialItem: initial);
    _scrollOffset = initial.toDouble();
    _lastTargetIndex = initial;
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final double currentOffset = _scrollController.offset / 150.0; // 150.0 — высота элемента
    
    // Вычисляем к какому индексу ближе всего находится колесо прямо сейчас
    final int nearestIndex = currentOffset.round();

    // ОПТИМИЗАЦИЯ ТАКТИЛЬНОГО ОТКЛИКА:
    // Мы вызываем вибрацию ТОЛЬКО в тот момент, когда центр колеса пересекает границу нового элемента.
    // Если этого не сделать, телефон будет гудеть как сумасшедший при малейшем сдвиге.
    if (nearestIndex != _lastTargetIndex && nearestIndex >= 0 && nearestIndex < widget.virtues.length) {
      _lastTargetIndex = nearestIndex;
      // selectionClick — это идеальный, очень короткий и легкий «щелчок» (Haptic Tick)
      HapticFeedback.selectionClick(); 
    }

    setState(() {
      _scrollOffset = currentOffset;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450, // Высота барабана
      child: ListWheelScrollView.useDelegate(
        controller: _scrollController,
        itemExtent: 150, // Высота карточки
        physics: const FixedExtentScrollPhysics(), // Магнитный эффект (snapping)
        onSelectedItemChanged: widget.onVirtueChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: widget.virtues.length,
          builder: (context, index) {
            final double relativePosition = index - _scrollOffset;
            final double clampedPosition = relativePosition.clamp(-2.0, 2.0);
            final double angle = clampedPosition * (math.pi / 4.5); // Угол наклона цилиндра

            final Matrix4 transform = Matrix4.identity()
              ..setEntry(3, 2, 0.0018) // Глубина перспективы
              ..translateByDouble(
                0.0,
                0.0,
                -clampedPosition.abs() * 40,
                1.0,
              ) // Смещение назад по оси Z
              ..rotateX(angle);

            // Плавное затухание от центра к краям
            final double opacity = (1.0 - (clampedPosition.abs() * 0.4)).clamp(0.15, 1.0);

            final virtue = widget.virtues[index];

            return Transform(
              transform: transform,
              alignment: Alignment.center,
              child: Opacity(
                opacity: opacity,
                child: _VirtueCard(name: virtue.$1, latin: virtue.$2),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _VirtueCard extends StatelessWidget {
  const _VirtueCard({required this.name, required this.latin});
  final String name;
  final String latin;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: MediaQuery.of(context).size.width * 0.82,
      height: 130,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? Color.lerp(colors.surface, Colors.black, 0.28)
            : Color.lerp(colors.surface, colors.primary, 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colors.primary.withValues(alpha: isDark ? 0.35 : 0.2),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : colors.shadow)
                .withValues(alpha: isDark ? 0.6 : 0.14),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            latin.toUpperCase(),
            style: TextStyle(
              color: colors.primary.withValues(alpha: 0.65),
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name.toUpperCase(),
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
            ),
          ),
        ],
      ),
    );
  }
}
