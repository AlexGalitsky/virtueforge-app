import 'package:flutter/material.dart';
import 'package:virtue_forge/core/theme/stoic_text_styles.dart';
import 'package:virtue_forge/core/theme/stoic_theme.dart';

/// Быстрый доступ к теме через context.
extension StoicThemeBuildContextX on BuildContext {
  /// Кастомные цвета проекта (focusHighlight, strikeDot).
  StoicThemeExtension get stoicColors =>
      Theme.of(this).extension<StoicThemeExtension>()!;

  /// Семантические текстовые стили (cardTitle, quote, eyebrow…).
  StoicTextStyles get stoicText =>
      StoicTextStyles(Theme.of(this).textTheme, Theme.of(this).colorScheme);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;
}
