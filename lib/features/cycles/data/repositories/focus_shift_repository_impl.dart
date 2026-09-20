import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/focus_shift_repository.dart';
import 'package:virtue_forge/features/cycles/domain/services/focus_resolver.dart';

class FocusShiftRepositoryImpl implements FocusShiftRepository {
  FocusShiftRepositoryImpl(this._prefs);

  static const _anchorMillisKey = 'focus_shift_anchor_millis';
  static const _anchorWeekKey = 'focus_shift_anchor_week';

  final SharedPreferences _prefs;
  final _controller = StreamController<FocusShift?>.broadcast();

  @override
  FocusShift? load() {
    final millis = _prefs.getInt(_anchorMillisKey);
    final week = _prefs.getInt(_anchorWeekKey);
    if (millis == null || week == null) return null;
    if (week < 1 || week > FocusResolver.weeksPerCycle) return null;
    return FocusShift(
      anchorWeekStart: WeekDateUtils.normalizeDate(
        DateTime.fromMillisecondsSinceEpoch(millis),
      ),
      anchorWeekNumber: week,
    );
  }

  @override
  Stream<FocusShift?> watch() async* {
    // Broadcast alone can drop the first event; always seed current value.
    yield load();
    yield* _controller.stream;
  }

  @override
  Future<void> save(FocusShift shift) async {
    final monday = WeekDateUtils.normalizeDate(shift.anchorWeekStart);
    await _prefs.setInt(_anchorMillisKey, monday.millisecondsSinceEpoch);
    await _prefs.setInt(_anchorWeekKey, shift.anchorWeekNumber);
    if (!_controller.isClosed) {
      _controller.add(shift);
    }
  }

  @override
  Future<void> clear() async {
    await _prefs.remove(_anchorMillisKey);
    await _prefs.remove(_anchorWeekKey);
    if (!_controller.isClosed) {
      _controller.add(null);
    }
  }
}
