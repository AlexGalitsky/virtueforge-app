import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtue_forge/core/theme/stoic_theme.dart';

class StoicPageScaffold extends StatelessWidget {
  final Widget child;

  const StoicPageScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Проверяем, какая тема сейчас активна в приложении
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark
          ? StoicTheme.darkSystemOverlay
          : StoicTheme.lightSystemOverlay,
      child: child,
    );
  }
}
