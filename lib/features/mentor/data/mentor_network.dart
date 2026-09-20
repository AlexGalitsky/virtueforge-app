import 'package:connectivity_plus/connectivity_plus.dart';

enum MentorNetworkKind {
  /// Wi‑Fi, ethernet, or similar unmetered-ish links.
  unmetered,
  /// Cellular / mobile data.
  mobile,
  offline,
  unknown,
}

/// Classifies the current link for Mentor downloads.
Future<MentorNetworkKind> resolveMentorNetwork() async {
  try {
    final results = await Connectivity().checkConnectivity();
    if (results.isEmpty ||
        (results.length == 1 && results.first == ConnectivityResult.none)) {
      return MentorNetworkKind.offline;
    }

    final hasUnmetered = results.any(
      (r) =>
          r == ConnectivityResult.wifi ||
          r == ConnectivityResult.ethernet ||
          r == ConnectivityResult.vpn,
    );
    final hasMobile = results.contains(ConnectivityResult.mobile);

    if (hasUnmetered) return MentorNetworkKind.unmetered;
    if (hasMobile) return MentorNetworkKind.mobile;
    if (results.contains(ConnectivityResult.other)) {
      return MentorNetworkKind.unknown;
    }
    return MentorNetworkKind.offline;
  } catch (_) {
    return MentorNetworkKind.unknown;
  }
}

bool mentorNetworkAllowsDownload({
  required MentorNetworkKind kind,
  required bool wifiOnly,
  required bool allowCellularOverride,
}) {
  if (kind == MentorNetworkKind.offline) return false;
  if (!wifiOnly) return true;
  if (kind == MentorNetworkKind.unmetered) return true;
  if (kind == MentorNetworkKind.mobile || kind == MentorNetworkKind.unknown) {
    return allowCellularOverride;
  }
  return false;
}
