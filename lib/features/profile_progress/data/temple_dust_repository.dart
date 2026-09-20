import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Tracks practice activity and one-shot dust notices for the Temple.
abstract class TempleDustRepository extends Listenable {
  static const graceHours = 48;
  static const xpPerDayPerPillar = 2;

  DateTime? get lastActivityAt;

  /// Notice from the latest settlement (cleared on dismiss).
  TempleDustNotice? get pendingNotice;

  Future<void> recordActivity([DateTime? at]);

  /// How many dust days would accrue if settling at [now].
  int dustDaysIfSettlingAt(DateTime now);

  Future<void> setPendingNotice(TempleDustNotice? notice);

  Future<void> dismissNotice();
}

class TempleDustNotice {
  const TempleDustNotice({
    required this.days,
    required this.xpLostPerPillar,
  });

  final int days;
  final int xpLostPerPillar;
}

class TempleDustRepositoryImpl extends ChangeNotifier
    implements TempleDustRepository {
  TempleDustRepositoryImpl(this._prefs) {
    final raw = _prefs.getString(_lastActivityKey);
    if (raw != null) {
      _lastActivityAt = DateTime.tryParse(raw);
    }
    final days = _prefs.getInt(_noticeDaysKey);
    if (days != null && days > 0) {
      _pendingNotice = TempleDustNotice(
        days: days,
        xpLostPerPillar: days * TempleDustRepository.xpPerDayPerPillar,
      );
    }
  }

  static const _lastActivityKey = 'temple_dust_last_activity';
  static const _noticeDaysKey = 'temple_dust_notice_days';

  final SharedPreferences _prefs;
  DateTime? _lastActivityAt;
  TempleDustNotice? _pendingNotice;

  @override
  DateTime? get lastActivityAt => _lastActivityAt;

  @override
  TempleDustNotice? get pendingNotice => _pendingNotice;

  @override
  Future<void> recordActivity([DateTime? at]) async {
    final when = at ?? DateTime.now();
    _lastActivityAt = when;
    await _prefs.setString(_lastActivityKey, when.toIso8601String());
    notifyListeners();
  }

  @override
  int dustDaysIfSettlingAt(DateTime now) {
    final last = _lastActivityAt;
    if (last == null) return 0;
    final absent = now.difference(last);
    final grace = const Duration(hours: TempleDustRepository.graceHours);
    if (absent <= grace) return 0;
    final afterGrace = absent - grace;
    // First hour past grace → 1 day; each further 24h → +1.
    return (afterGrace.inHours ~/ 24) + 1;
  }

  @override
  Future<void> setPendingNotice(TempleDustNotice? notice) async {
    _pendingNotice = notice;
    if (notice == null) {
      await _prefs.remove(_noticeDaysKey);
    } else {
      await _prefs.setInt(_noticeDaysKey, notice.days);
    }
    notifyListeners();
  }

  @override
  Future<void> dismissNotice() => setPendingNotice(null);
}
