import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

/// Heuristic for on-device LLM: devices with little RAM struggle with 3B Q4.
abstract final class MentorDeviceTier {
  /// Below this physical RAM (MB) → recommend light model / weak-device mode.
  static const weakRamThresholdMb = 6144; // 6 GB

  /// Returns physical RAM in megabytes, or null if unknown.
  static Future<int?> physicalRamMb() async {
    final plugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final info = await plugin.androidInfo;
        if (info.physicalRamSize > 0) return info.physicalRamSize;
      } else if (Platform.isIOS) {
        final info = await plugin.iosInfo;
        if (info.physicalRamSize > 0) return info.physicalRamSize;
      } else if (Platform.isMacOS) {
        final info = await plugin.macOsInfo;
        if (info.memorySize > 0) return info.memorySize;
      } else if (Platform.isWindows) {
        final info = await plugin.windowsInfo;
        // systemMemoryInMegabytes when available
        final mem = info.systemMemoryInMegabytes;
        if (mem > 0) return mem;
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  static Future<bool> detectWeakDevice() async {
    final mb = await physicalRamMb();
    if (mb == null) return false;
    return mb < weakRamThresholdMb;
  }
}
