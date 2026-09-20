import 'dart:ui' show PlatformDispatcher;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtue_forge/features/settings/domain/models/app_settings.dart';
import 'package:virtue_forge/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._prefs);

  static const _localeKey = 'settings_locale';
  static const _themeKey = 'settings_theme_mode';
  static const _reminderEnabledKey = 'settings_reminder_enabled';
  static const _reminderHourKey = 'settings_reminder_hour';
  static const _reminderMinuteKey = 'settings_reminder_minute';
  static const _birthDateKey = 'settings_birth_date';
  static const _showGestureTipsKey = 'settings_show_gesture_tips';

  /// Locales shipped in `app_*.arb` / AppLocalizations.supportedLocales.
  static const _supportedLocaleCodes = {'en', 'ru'};

  final SharedPreferences _prefs;

  @override
  AppSettings load() {
    return AppSettings(
      localeCode: _prefs.getString(_localeKey) ?? _deviceLocaleCode(),
      themePreference: _decodeTheme(_prefs.getString(_themeKey)),
      reminderEnabled: _prefs.getBool(_reminderEnabledKey) ?? false,
      reminderHour: _prefs.getInt(_reminderHourKey) ?? 21,
      reminderMinute: _prefs.getInt(_reminderMinuteKey) ?? 0,
      birthDate: _decodeBirthDate(_prefs.getString(_birthDateKey)),
      showGestureTips: _prefs.getBool(_showGestureTipsKey) ?? true,
    );
  }

  @override
  Future<void> save(AppSettings settings) async {
    await _prefs.setString(_localeKey, settings.localeCode);
    await _prefs.setString(_themeKey, _encodeTheme(settings.themePreference));
    await _prefs.setBool(_reminderEnabledKey, settings.reminderEnabled);
    await _prefs.setInt(_reminderHourKey, settings.reminderHour);
    await _prefs.setInt(_reminderMinuteKey, settings.reminderMinute);
    await _prefs.setBool(_showGestureTipsKey, settings.showGestureTips);
    final birth = settings.birthDate;
    if (birth == null) {
      await _prefs.remove(_birthDateKey);
    } else {
      await _prefs.setString(_birthDateKey, _encodeBirthDate(birth));
    }
  }

  /// Phone language when the user has not chosen a language in Order yet.
  static String _deviceLocaleCode() {
    final code = PlatformDispatcher.instance.locale.languageCode.toLowerCase();
    if (_supportedLocaleCodes.contains(code)) return code;
    return 'en';
  }

  static ThemePreference _decodeTheme(String? value) {
    switch (value) {
      case 'light':
        return ThemePreference.light;
      case 'dark':
        return ThemePreference.dark;
      case 'system':
      default:
        return ThemePreference.system;
    }
  }

  static String _encodeTheme(ThemePreference preference) {
    switch (preference) {
      case ThemePreference.light:
        return 'light';
      case ThemePreference.dark:
        return 'dark';
      case ThemePreference.system:
        return 'system';
    }
  }

  /// Stores calendar date only (`yyyy-MM-dd`).
  static String _encodeBirthDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  static DateTime? _decodeBirthDate(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    final parts = raw.split('-');
    if (parts.length != 3) return null;
    final y = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    final d = int.tryParse(parts[2]);
    if (y == null || m == null || d == null) return null;
    return DateTime(y, m, d);
  }
}
