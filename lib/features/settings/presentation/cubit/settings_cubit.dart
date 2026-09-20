import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtue_forge/features/settings/domain/models/app_settings.dart';
import 'package:virtue_forge/features/settings/domain/repositories/settings_repository.dart';
import 'package:virtue_forge/features/settings/domain/usecases/settings_use_cases.dart';

class SettingsCubit extends Cubit<AppSettings> {
  SettingsCubit({
    required SettingsRepository repository,
    required PersistSettingsUseCase persistSettings,
    required SyncReminderUseCase syncReminder,
    required SetReminderEnabledUseCase setReminderEnabled,
    required SetReminderTimeUseCase setReminderTime,
  })  : _persistSettings = persistSettings,
        _syncReminder = syncReminder,
        _setReminderEnabled = setReminderEnabled,
        _setReminderTime = setReminderTime,
        super(repository.load());

  final PersistSettingsUseCase _persistSettings;
  final SyncReminderUseCase _syncReminder;
  final SetReminderEnabledUseCase _setReminderEnabled;
  final SetReminderTimeUseCase _setReminderTime;

  Future<void> syncReminder({
    required String title,
    required String body,
  }) {
    return _syncReminder(settings: state, title: title, body: body);
  }

  Future<void> setLocale(String localeCode) async {
    final next = state.copyWith(localeCode: localeCode);
    emit(next);
    await _persistSettings(next);
  }

  Future<void> setThemePreference(ThemePreference preference) async {
    final next = state.copyWith(themePreference: preference);
    emit(next);
    await _persistSettings(next);
  }

  Future<bool> setReminderEnabled({
    required bool enabled,
    required String title,
    required String body,
  }) async {
    final result = await _setReminderEnabled(
      current: state,
      enabled: enabled,
      title: title,
      body: body,
    );
    emit(result.settings);
    return result.granted;
  }

  Future<void> setReminderTime({
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    final next = await _setReminderTime(
      current: state,
      hour: hour,
      minute: minute,
      title: title,
      body: body,
    );
    emit(next);
  }

  Future<void> setBirthDate(DateTime date) async {
    final normalized = DateTime(date.year, date.month, date.day);
    final next = state.copyWith(birthDate: normalized);
    emit(next);
    await _persistSettings(next);
  }

  Future<void> setShowGestureTips(bool enabled) async {
    final next = state.copyWith(showGestureTips: enabled);
    emit(next);
    await _persistSettings(next);
  }
}
