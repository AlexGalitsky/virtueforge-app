/// Theme preference without Flutter types (maps to ThemeMode in presentation).
enum ThemePreference { system, light, dark }

class AppSettings {
  const AppSettings({
    required this.localeCode,
    required this.themePreference,
    required this.reminderEnabled,
    required this.reminderHour,
    required this.reminderMinute,
    this.birthDate,
    this.showGestureTips = true,
  });

  factory AppSettings.defaults() => const AppSettings(
        localeCode: 'en',
        themePreference: ThemePreference.system,
        reminderEnabled: false,
        reminderHour: 21,
        reminderMinute: 0,
        showGestureTips: true,
      );

  final String localeCode;
  final ThemePreference themePreference;
  final bool reminderEnabled;
  final int reminderHour;
  final int reminderMinute;

  /// Calendar day of birth for Memento Mori. Null until the user sets it.
  final DateTime? birthDate;

  /// Rotating gesture tips under the Franklin grid.
  final bool showGestureTips;

  String get reminderTimeLabel {
    final h = reminderHour.toString().padLeft(2, '0');
    final m = reminderMinute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  AppSettings copyWith({
    String? localeCode,
    ThemePreference? themePreference,
    bool? reminderEnabled,
    int? reminderHour,
    int? reminderMinute,
    DateTime? birthDate,
    bool clearBirthDate = false,
    bool? showGestureTips,
  }) {
    return AppSettings(
      localeCode: localeCode ?? this.localeCode,
      themePreference: themePreference ?? this.themePreference,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
      birthDate: clearBirthDate ? null : (birthDate ?? this.birthDate),
      showGestureTips: showGestureTips ?? this.showGestureTips,
    );
  }
}
