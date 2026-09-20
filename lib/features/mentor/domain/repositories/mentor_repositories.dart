import 'package:virtue_forge/features/mentor/domain/models/mentor_audience.dart';
import 'package:virtue_forge/features/mentor/domain/models/mentor_model_spec.dart';

enum MentorDownloadStage {
  idle,
  resolving,
  checkingCache,
  downloading,
  verifying,
  ready,
  failed,
  cancelled,
  alreadyReady,
}

class MentorDownloadProgress {
  const MentorDownloadProgress({
    required this.message,
    this.stage = MentorDownloadStage.idle,
    this.fraction,
    this.receivedBytes,
    this.totalBytes,
    this.done = false,
    this.error,
    this.modelPath,
  });

  final String message;
  final MentorDownloadStage stage;
  final double? fraction;
  final int? receivedBytes;
  final int? totalBytes;
  final bool done;
  final String? error;
  final String? modelPath;
}

abstract class MentorModelStore {
  String get selectedModelId;

  Future<void> selectModel(String modelId);

  String? pathFor(String modelId);

  bool isInstalled(String modelId);

  MentorModelSpec get selectedSpec;

  /// Prefer light model when device flagged weak (user override or RAM auto).
  bool get isWeakDevice;

  /// True when weak mode came from RAM heuristic (no user override).
  bool get isWeakDeviceFromAuto;

  Future<void> setWeakDevice(bool value);

  /// Seed RAM-based weak flag once at startup (does not override user choice).
  Future<void> seedAutoDeviceTier();

  /// When true (default), HF downloads require Wi‑Fi/ethernet unless overridden.
  bool get wifiOnlyDownloads;

  Future<void> setWifiOnlyDownloads(bool value);

  bool isLicenseAccepted(String licenseId);

  Future<void> acceptLicense(String licenseId);

  Future<void> registerLocalPath(String modelId, String absolutePath);

  Future<void> clearPath(String modelId);

  /// [allowCellular] bypasses the Wi‑Fi-only preference for this download.
  Stream<MentorDownloadProgress> downloadFromHuggingFace(
    String modelId, {
    bool allowCellular = false,
  });

  bool get disclaimerAccepted;

  Future<void> acceptDisclaimer();

  int remainingAudiencesToday();

  Future<void> recordAudienceCompleted();
}

abstract class AudienceRepository {
  Future<void> save(MentorAudience audience);

  Future<void> updateResponse(
    String id,
    String aiResponse, {
    required bool interrupted,
  });

  Future<List<MentorAudience>> recent({int limit = 50});

  Future<void> clearAll();
}
