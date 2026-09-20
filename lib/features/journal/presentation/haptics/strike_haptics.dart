import 'package:flutter/services.dart';

/// Haptics for Franklin strike gestures.
abstract final class StrikeHaptics {
  /// Heavy “hammer” hit when marking a fault (+1).
  static Future<void> markFault() async {
    await HapticFeedback.heavyImpact();
  }

  /// Lighter tick when removing a strike (−1).
  static Future<void> undoFault() async {
    await HapticFeedback.selectionClick();
  }
}
