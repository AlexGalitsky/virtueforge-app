import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtue_forge/features/mentor/domain/models/mentor_model_spec.dart';

class MentorPreferences {
  MentorPreferences(this._prefs);

  static const _selectedKey = 'mentor_selected_model_id';
  static const _pathPrefix = 'mentor_model_path:';
  static const _disclaimerKey = 'mentor_disclaimer_accepted';
  static const _dailyCountKey = 'mentor_daily_count';
  static const _dailyDateKey = 'mentor_daily_date';
  static const _weakDeviceKey = 'mentor_treat_as_weak_device';
  static const _weakDeviceAutoKey = 'mentor_weak_device_auto';
  static const _wifiOnlyKey = 'mentor_wifi_only_downloads';
  static const _licensePrefix = 'mentor_license_accepted:';

  /// Soft cap so local inference does not drain battery / heat the phone all day.
  /// Follow-up turns inside one audience do not count.
  static const dailyLimit = 10;

  final SharedPreferences _prefs;

  String get selectedModelId =>
      _prefs.getString(_selectedKey) ?? MentorModelCatalog.defaultModelId;

  Future<void> setSelectedModelId(String id) =>
      _prefs.setString(_selectedKey, id);

  String? pathFor(String modelId) => _prefs.getString('$_pathPrefix$modelId');

  Future<void> setPath(String modelId, String? path) async {
    final key = '$_pathPrefix$modelId';
    if (path == null || path.isEmpty) {
      await _prefs.remove(key);
    } else {
      await _prefs.setString(key, path);
    }
  }

  bool get disclaimerAccepted => _prefs.getBool(_disclaimerKey) ?? false;

  Future<void> setDisclaimerAccepted(bool value) =>
      _prefs.setBool(_disclaimerKey, value);

  /// User override. `null` = follow auto RAM detection.
  bool? get treatAsWeakDeviceOverride {
    if (!_prefs.containsKey(_weakDeviceKey)) return null;
    return _prefs.getBool(_weakDeviceKey);
  }

  Future<void> setTreatAsWeakDevice(bool value) =>
      _prefs.setBool(_weakDeviceKey, value);

  bool get weakDeviceAuto => _prefs.getBool(_weakDeviceAutoKey) ?? false;

  Future<void> setWeakDeviceAuto(bool value) =>
      _prefs.setBool(_weakDeviceAutoKey, value);

  /// Prefer Wi‑Fi / ethernet for multi‑GB GGUF downloads (default on).
  bool get wifiOnlyDownloads => _prefs.getBool(_wifiOnlyKey) ?? true;

  Future<void> setWifiOnlyDownloads(bool value) =>
      _prefs.setBool(_wifiOnlyKey, value);

  bool isLicenseAccepted(String licenseId) =>
      _prefs.getBool('$_licensePrefix$licenseId') ?? false;

  Future<void> setLicenseAccepted(String licenseId, bool value) =>
      _prefs.setBool('$_licensePrefix$licenseId', value);

  int audiencesUsedToday() {
    final today = _todayKey();
    final stored = _prefs.getString(_dailyDateKey);
    if (stored != today) return 0;
    return _prefs.getInt(_dailyCountKey) ?? 0;
  }

  int remainingToday() => (dailyLimit - audiencesUsedToday()).clamp(0, dailyLimit);

  Future<void> recordAudienceCompleted() async {
    final today = _todayKey();
    final stored = _prefs.getString(_dailyDateKey);
    if (stored != today) {
      await _prefs.setString(_dailyDateKey, today);
      await _prefs.setInt(_dailyCountKey, 1);
      return;
    }
    await _prefs.setInt(_dailyCountKey, audiencesUsedToday() + 1);
  }

  String _todayKey() {
    final n = DateTime.now();
    return '${n.year.toString().padLeft(4, '0')}-'
        '${n.month.toString().padLeft(2, '0')}-'
        '${n.day.toString().padLeft(2, '0')}';
  }
}
