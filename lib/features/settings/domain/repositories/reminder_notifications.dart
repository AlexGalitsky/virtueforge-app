/// Port for local reminder scheduling (implemented in data).
abstract class ReminderNotifications {
  Future<bool> requestPermissions();

  Future<void> sync({
    required bool enabled,
    required int hour,
    required int minute,
    required String title,
    required String body,
  });

  Future<void> cancel();
}
