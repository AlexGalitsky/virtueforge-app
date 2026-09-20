import 'package:flutter_test/flutter_test.dart';
import 'package:virtue_forge/features/mentor/data/mentor_network.dart';

void main() {
  group('mentorNetworkAllowsDownload', () {
    test('wifi-only blocks mobile without override', () {
      expect(
        mentorNetworkAllowsDownload(
          kind: MentorNetworkKind.mobile,
          wifiOnly: true,
          allowCellularOverride: false,
        ),
        isFalse,
      );
    });

    test('wifi-only allows mobile with override', () {
      expect(
        mentorNetworkAllowsDownload(
          kind: MentorNetworkKind.mobile,
          wifiOnly: true,
          allowCellularOverride: true,
        ),
        isTrue,
      );
    });

    test('unmetered always ok when wifi-only', () {
      expect(
        mentorNetworkAllowsDownload(
          kind: MentorNetworkKind.unmetered,
          wifiOnly: true,
          allowCellularOverride: false,
        ),
        isTrue,
      );
    });

    test('offline never ok', () {
      expect(
        mentorNetworkAllowsDownload(
          kind: MentorNetworkKind.offline,
          wifiOnly: false,
          allowCellularOverride: true,
        ),
        isFalse,
      );
    });
  });
}
