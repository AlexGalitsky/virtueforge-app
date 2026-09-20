import 'package:virtue_forge/features/settings/domain/models/app_settings.dart';
import 'package:virtue_forge/features/settings/domain/repositories/reminder_notifications.dart';
import 'package:virtue_forge/features/settings/domain/repositories/settings_repository.dart';

class PersistSettingsUseCase {
  PersistSettingsUseCase(this._repository);

  final SettingsRepository _repository;

  Future<void> call(AppSettings settings) => _repository.save(settings);
}

class SyncReminderUseCase {
  SyncReminderUseCase(this._notifications);

  final ReminderNotifications _notifications;

  Future<void> call({
    required AppSettings settings,
    required String title,
    required String body,
  }) {
    return _notifications.sync(
      enabled: settings.reminderEnabled,
      hour: settings.reminderHour,
      minute: settings.reminderMinute,
      title: title,
      body: body,
    );
  }
}

class SetReminderEnabledUseCase {
  SetReminderEnabledUseCase({
    required SettingsRepository repository,
    required ReminderNotifications notifications,
  })  : _repository = repository,
        _notifications = notifications;

  final SettingsRepository _repository;
  final ReminderNotifications _notifications;

  /// Returns false if permission denied (reminder forced off).
  Future<({AppSettings settings, bool granted})> call({
    required AppSettings current,
    required bool enabled,
    required String title,
    required String body,
  }) async {
    if (enabled) {
      final granted = await _notifications.requestPermissions();
      if (!granted) {
        await _notifications.cancel();
        final next = current.copyWith(reminderEnabled: false);
        await _repository.save(next);
        return (settings: next, granted: false);
      }
    }

    final next = current.copyWith(reminderEnabled: enabled);
    await _repository.save(next);
    await _notifications.sync(
      enabled: enabled,
      hour: next.reminderHour,
      minute: next.reminderMinute,
      title: title,
      body: body,
    );
    return (settings: next, granted: true);
  }
}

class SetReminderTimeUseCase {
  SetReminderTimeUseCase({
    required SettingsRepository repository,
    required ReminderNotifications notifications,
  })  : _repository = repository,
        _notifications = notifications;

  final SettingsRepository _repository;
  final ReminderNotifications _notifications;

  Future<AppSettings> call({
    required AppSettings current,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    final next = current.copyWith(reminderHour: hour, reminderMinute: minute);
    await _repository.save(next);
    await _notifications.sync(
      enabled: next.reminderEnabled,
      hour: next.reminderHour,
      minute: next.reminderMinute,
      title: title,
      body: body,
    );
    return next;
  }
}
