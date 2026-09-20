import 'package:flutter/material.dart';
import 'package:virtue_forge/features/settings/domain/models/app_settings.dart';

extension ThemePreferenceX on ThemePreference {
  ThemeMode toThemeMode() {
    switch (this) {
      case ThemePreference.light:
        return ThemeMode.light;
      case ThemePreference.dark:
        return ThemeMode.dark;
      case ThemePreference.system:
        return ThemeMode.system;
    }
  }

  static ThemePreference fromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return ThemePreference.light;
      case ThemeMode.dark:
        return ThemePreference.dark;
      case ThemeMode.system:
        return ThemePreference.system;
    }
  }
}

extension AppSettingsUiX on AppSettings {
  Locale get locale => Locale(localeCode);

  TimeOfDay get reminderTime =>
      TimeOfDay(hour: reminderHour, minute: reminderMinute);
}
