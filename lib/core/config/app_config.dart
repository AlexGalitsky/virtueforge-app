/// Runtime config for remote Portico content.
///
/// Override at run/build time:
/// `flutter run --dart-define=API_BASE_URL=http://127.0.0.1:3000`
abstract final class AppConfig {
  /// Nest content API root (no trailing slash).
  ///
  /// Default targets the Android emulator loopback to the host machine.
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://virtueforge.goodwin.website',
  );
}
