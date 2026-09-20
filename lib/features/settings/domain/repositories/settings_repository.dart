import 'package:virtue_forge/features/settings/domain/models/app_settings.dart';

abstract class SettingsRepository {
  AppSettings load();

  Future<void> save(AppSettings settings);
}
