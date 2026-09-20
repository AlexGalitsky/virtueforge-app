import 'package:flutter/material.dart';
import 'package:virtue_forge/core/theme/stoic_theme.dart';

/// Семантические текстовые стили VirtueForge.
///
/// Источник токенов — [TextTheme] в [StoicTheme].
/// Использование: `context.stoicText.cardTitle`
class StoicTextStyles {
  final TextTheme _text;
  final ColorScheme _colors;

  const StoicTextStyles(this._text, this._colors);

  /// Крупный заголовок экрана / AppBar (Serif).
  TextStyle get pageTitle => _text.headlineMedium!;

  /// Заголовок слайда онбординга (Serif, 24).
  TextStyle get slideTitle => _text.headlineMedium!;

  /// Заголовок шторки / статус-блока (Serif, 20–22).
  TextStyle get sheetTitle => _text.titleLarge!;

  /// Заголовок карточки / эссе (Serif, 17).
  TextStyle get cardTitle => _text.titleMedium!;

  /// Компактный заголовок карточки / колонны (Serif, 15).
  TextStyle get cardTitleSmall => _text.titleSmall!;

  /// Цитата стоиков (Serif italic).
  TextStyle get quote => _text.displaySmall!;

  /// Основной читаемый текст.
  TextStyle get body => _text.bodyMedium!;

  /// Приглушённая подпись / описание.
  TextStyle get caption => _text.bodySmall!;

  /// Подпись акцентным цветом (цикл, статус).
  TextStyle get captionAccent => caption.copyWith(color: _colors.primary);

  /// Uppercase-метка (автор, категория добродетели).
  TextStyle get eyebrow => _text.labelSmall!;

  /// То же, акцентным (терракотовым) цветом — секции экранов.
  TextStyle get eyebrowAccent => eyebrow.copyWith(color: _colors.primary);

  /// Подпись поля рефлексии.
  TextStyle get fieldLabel => _text.labelMedium!.copyWith(
        color: _colors.primary,
        fontWeight: FontWeight.w500,
      );

  /// Текст внутри поля ввода.
  TextStyle get fieldInput => _text.bodyMedium!.copyWith(
        color: _colors.onSurface,
      );

  /// Hint в поле ввода.
  TextStyle get fieldHint => _text.bodySmall!.copyWith(
        color: _colors.outline.withValues(alpha: 0.7),
      );

  /// Текст на primary-кнопках.
  TextStyle get button => _text.labelLarge!;

  /// Текст на outlined-кнопках.
  TextStyle get buttonOutlined => _text.labelLarge!.copyWith(
        color: _colors.onSurface,
        fontSize: 15,
      );

  /// Текстовая ссылка («Читать полностью»).
  TextStyle get link => _text.labelMedium!.copyWith(
        color: _colors.primary,
        fontWeight: FontWeight.w600,
      );

  /// Заголовок строки настроек (Sans).
  TextStyle get tileTitle => _text.labelMedium!.copyWith(
        color: _colors.onSurface,
        fontSize: 15,
        fontFamily: StoicTheme.fontSans,
      );

  /// Бейдж уровня колонны (Lv N).
  TextStyle get levelBadge => _text.labelMedium!.copyWith(
        color: _colors.primary,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      );

  /// Название добродетели в сетке Франклина.
  TextStyle get gridVirtue => _text.bodySmall!.copyWith(
        color: _colors.onSurfaceVariant,
        fontSize: 13,
      );

  /// Фокусная добродетель недели в сетке.
  TextStyle get gridVirtueFocus => gridVirtue.copyWith(
        color: _colors.primary,
        fontWeight: FontWeight.bold,
      );

  /// Подпись дня недели в шапке сетки.
  TextStyle get gridDay => _text.labelSmall!.copyWith(
        letterSpacing: 0,
        fontSize: 12,
      );

  /// Цифра внутри StrikeCell.
  TextStyle strikeCount(double fontSize) => _text.labelSmall!.copyWith(
        color: _colors.onSurface,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        letterSpacing: 0,
      );
}
