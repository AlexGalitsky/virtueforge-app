import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
final stoicExt = Theme.of(context).extension<StoicThemeExtension>()!;
final focusColor = stoicExt.focusHighlight;
final dotColor = stoicExt.strikeDot;
* */
@immutable
class StoicThemeExtension extends ThemeExtension<StoicThemeExtension> {
  final Color? focusHighlight;
  final Color? strikeDot;

  const StoicThemeExtension({
    required this.focusHighlight,
    required this.strikeDot,
  });

  Color get strikeColor => strikeDot ?? Colors.redAccent.shade700;

  @override
  StoicThemeExtension copyWith({Color? focusHighlight, Color? strikeDot}) {
    return StoicThemeExtension(
      focusHighlight: focusHighlight ?? this.focusHighlight,
      strikeDot: strikeDot ?? this.strikeDot,
    );
  }

  @override
  StoicThemeExtension lerp(
    ThemeExtension<StoicThemeExtension>? other,
    double t,
  ) {
    if (other is! StoicThemeExtension) return this;
    return StoicThemeExtension(
      focusHighlight: Color.lerp(focusHighlight, other.focusHighlight, t),
      strikeDot: Color.lerp(strikeDot, other.strikeDot, t),
    );
  }
}

class StoicTheme {
  // Константы шрифтов
  static const String fontSerif = 'PlayfairDisplay';
  static const String fontSans = 'Inter';

  // Палитра Light
  static const Color lightScaffold = Color(0xFFF5F4F0);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightBottomNav = Color(0xFFEDECE6);
  static const Color lightPrimary = Color(0xFFC96449);
  static const Color lightTextPrimary = Color(0xFF121212);
  static const Color lightTextSecondary = Color(0xFF4A4A4A);
  static const Color lightTextMuted = Color(0xFF9E9E9E);

  // Палитра Dark
  static const Color darkScaffold = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkBottomNav = Color(0xFF161616);
  static const Color darkPrimary = Color(0xFFE07A5F);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFE0E0E0);
  static const Color darkTextMuted = Color(0xFF757575);

  static ThemeData get lightTheme => _buildTheme(
    brightness: Brightness.light,
    scaffold: lightScaffold,
    surface: lightSurface,
    bottomNav: lightBottomNav,
    primary: lightPrimary,
    textPrimary: lightTextPrimary,
    textSecondary: lightTextSecondary,
    textMuted: lightTextMuted,
    ext: const StoicThemeExtension(
      focusHighlight: Color(0xFFF0EAE1),
      strikeDot: Color(0xFFD4D4D4),
    ),
  );

  static ThemeData get darkTheme => _buildTheme(
    brightness: Brightness.dark,
    scaffold: darkScaffold,
    surface: darkSurface,
    bottomNav: darkBottomNav,
    primary: darkPrimary,
    textPrimary: darkTextPrimary,
    textSecondary: darkTextSecondary,
    textMuted: darkTextMuted,
    ext: const StoicThemeExtension(
      focusHighlight: Color(0xFF2C2520),
      strikeDot: Color(0xFF0A0A0A),
    ),
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color scaffold,
    required Color surface,
    required Color bottomNav,
    required Color primary,
    required Color textPrimary,
    required Color textSecondary,
    required Color textMuted,
    required StoicThemeExtension ext,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: scaffold,
      fontFamily: fontSans,

      extensions: <ThemeExtension<dynamic>>[ext],

      // Полная и корректная ColorScheme со всеми обязательными параметрами
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primary,
        onPrimary: brightness == Brightness.dark ? textPrimary : surface,
        secondary: textSecondary,
        // Добавлено: для второстепенных элементов
        onSecondary: surface,
        // Добавлено: контраст для secondary
        surface: surface,
        onSurface: textPrimary,
        onSurfaceVariant: textSecondary,
        outline: textMuted,
        error: const Color(0xFFBA1A1A),
        // Стандартный Material темный/светлый красный
        onError: Colors.white,
      ),

      // Типографика: Serif — заголовки/цитаты, Sans — UI.
      // Семантический доступ: context.stoicText.cardTitle и т.д.
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: textPrimary,
          fontFamily: fontSerif,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
        headlineMedium: TextStyle(
          color: textPrimary,
          fontFamily: fontSerif,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        titleLarge: TextStyle(
          color: textPrimary,
          fontFamily: fontSerif,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        titleMedium: TextStyle(
          color: textPrimary,
          fontFamily: fontSerif,
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
        titleSmall: TextStyle(
          color: textPrimary,
          fontFamily: fontSerif,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        displaySmall: TextStyle(
          color: textSecondary,
          fontFamily: fontSerif,
          fontStyle: FontStyle.italic,
          fontSize: 15,
          height: 1.4,
        ),
        bodyLarge: TextStyle(
          color: textSecondary,
          fontFamily: fontSans,
          fontSize: 16,
          height: 1.4,
        ),
        bodyMedium: TextStyle(
          color: textSecondary,
          fontFamily: fontSans,
          fontSize: 14,
          height: 1.45,
        ),
        bodySmall: TextStyle(
          color: textMuted,
          fontFamily: fontSans,
          fontSize: 13,
          height: 1.3,
        ),
        labelLarge: TextStyle(
          color: textPrimary,
          fontFamily: fontSans,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        labelMedium: TextStyle(
          color: textSecondary,
          fontFamily: fontSans,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        labelSmall: TextStyle(
          color: textMuted,
          fontFamily: fontSans,
          fontWeight: FontWeight.bold,
          fontSize: 11,
          letterSpacing: 1.2,
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: bottomNav,
        selectedItemColor: primary,
        unselectedItemColor: textMuted,
        selectedLabelStyle: const TextStyle(
          fontFamily: fontSans,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: fontSans,
          fontSize: 12,
        ),
        type: BottomNavigationBarType.fixed,
      ),

      inputDecorationTheme: InputDecorationTheme(
        fillColor: surface,
        filled: true,
        hintStyle: TextStyle(color: textMuted, fontFamily: fontSans),
        labelStyle: TextStyle(color: textSecondary, fontFamily: fontSans),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textMuted, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: textMuted, width: 0.5),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: brightness == Brightness.dark
              ? textPrimary
              : surface,
          elevation: 0,
          textStyle: const TextStyle(
            fontFamily: fontSans,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static SystemUiOverlayStyle get lightSystemOverlay {
    return const SystemUiOverlayStyle(
      // Статус-бар (сверху)
      statusBarColor: Colors.transparent,
      // Прозрачный для Android
      statusBarIconBrightness: Brightness.dark,
      // Темные иконки (время, батарея) на светлом фоне
      statusBarBrightness: Brightness.light,
      // Для iOS (light режим)

      // Навигационная панель (снизу, для Android)
      systemNavigationBarColor: lightBottomNav,
      // Сливается с нижней панелью навигации
      systemNavigationBarIconBrightness: Brightness.dark,
      // Темные кнопки навигации
      systemNavigationBarDividerColor: Colors.transparent,
    );
  }

  static SystemUiOverlayStyle get darkSystemOverlay {
    return const SystemUiOverlayStyle(
      // Статус-бар (сверху)
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      // Светлые иконки на темном фоне
      statusBarBrightness: Brightness.dark,
      // Для iOS (dark режим)

      // Навигационная панель (снизу, для Android)
      systemNavigationBarColor: darkBottomNav,
      // Сливается с нижней панелью навигации
      systemNavigationBarIconBrightness: Brightness.light,
      // Светлые кнопки навигации
      systemNavigationBarDividerColor: Colors.transparent,
    );
  }
}
