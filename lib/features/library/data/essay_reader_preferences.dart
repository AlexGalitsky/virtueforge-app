import 'package:shared_preferences/shared_preferences.dart';

/// Local prefs for Portico reader comfort (font, progress, verse mode).
class EssayReaderPreferences {
  EssayReaderPreferences(this._prefs);

  static const _fontScaleKey = 'essay_reader_font_scale';
  static const _verseModeKey = 'essay_reader_verse_mode';
  static const _progressPrefix = 'essay_reader_progress:';

  static const minFontScale = 0.85;
  static const maxFontScale = 1.45;
  static const defaultFontScale = 1.0;

  final SharedPreferences _prefs;

  double get fontScale =>
      (_prefs.getDouble(_fontScaleKey) ?? defaultFontScale)
          .clamp(minFontScale, maxFontScale);

  Future<void> setFontScale(double value) => _prefs.setDouble(
        _fontScaleKey,
        value.clamp(minFontScale, maxFontScale),
      );

  bool get verseMode => _prefs.getBool(_verseModeKey) ?? false;

  Future<void> setVerseMode(bool value) =>
      _prefs.setBool(_verseModeKey, value);

  double? progressFor(String essayId) =>
      _prefs.getDouble('$_progressPrefix$essayId');

  Future<void> saveProgress(String essayId, double progress) =>
      _prefs.setDouble(
        '$_progressPrefix$essayId',
        progress.clamp(0.0, 1.0),
      );
}
