import 'dart:async';

import 'package:flutter/material.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';

/// Ротирующиеся подсказки жестов под сеткой (ideas.md — способ В).
class GridGestureTips extends StatefulWidget {
  const GridGestureTips({super.key});

  @override
  State<GridGestureTips> createState() => _GridGestureTipsState();
}

class _GridGestureTipsState extends State<GridGestureTips> {
  static const _interval = Duration(seconds: 5);
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_interval, (_) {
      if (!mounted) return;
      setState(() => _index = (_index + 1) % 4);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colorScheme;
    final tips = [
      l10n.gridTipTodayOnly,
      l10n.gridTipLongPress,
      l10n.gridTipDoubleTap,
      l10n.gridTipSwipe,
    ];

    return Stack(
      alignment: Alignment.center,
      children: [
        // Невидимый шаблон, который резервирует высоту ровно в 2 строки
        IgnorePointer(
          child: Opacity(
            opacity: 0,
            child: Text(
              '\n',
              style: context.stoicText.body.copyWith(
                fontSize: 13,
                color: colors.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ),
        ),
        // Контент с фиксированной высотой и анимацией
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          // Обязательно выравниваем сам переключатель по центру
          layoutBuilder: (currentChild, previousChildren) {
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            );
          },
          child: Center(
            key: ValueKey(_index),
            child: Text(
              tips[_index],
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.stoicText.body.copyWith(
                fontSize: 13,
                color: colors.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
