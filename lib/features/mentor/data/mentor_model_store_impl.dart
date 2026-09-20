import 'dart:async';
import 'dart:io';

import 'package:llamadart/llamadart.dart';
import 'package:virtue_forge/features/mentor/data/gguf_integrity.dart';
import 'package:virtue_forge/features/mentor/data/mentor_device_tier.dart';
import 'package:virtue_forge/features/mentor/data/mentor_network.dart';
import 'package:virtue_forge/features/mentor/data/mentor_preferences.dart';
import 'package:virtue_forge/features/mentor/domain/models/mentor_model_spec.dart';
import 'package:virtue_forge/features/mentor/domain/repositories/mentor_repositories.dart';

class MentorModelStoreImpl implements MentorModelStore {
  MentorModelStoreImpl(this._prefs);

  final MentorPreferences _prefs;

  @override
  String get selectedModelId => _prefs.selectedModelId;

  @override
  Future<void> selectModel(String modelId) =>
      _prefs.setSelectedModelId(modelId);

  @override
  String? pathFor(String modelId) => _prefs.pathFor(modelId);

  @override
  bool isInstalled(String modelId) {
    final path = pathFor(modelId);
    if (path == null || path.isEmpty) return false;
    return File(path).existsSync();
  }

  @override
  MentorModelSpec get selectedSpec =>
      MentorModelCatalog.byId(selectedModelId);

  @override
  bool get isWeakDevice {
    final override = _prefs.treatAsWeakDeviceOverride;
    if (override != null) return override;
    return _prefs.weakDeviceAuto;
  }

  @override
  bool get isWeakDeviceFromAuto =>
      _prefs.treatAsWeakDeviceOverride == null && _prefs.weakDeviceAuto;

  @override
  Future<void> setWeakDevice(bool value) =>
      _prefs.setTreatAsWeakDevice(value);

  @override
  Future<void> seedAutoDeviceTier() async {
    final weak = await MentorDeviceTier.detectWeakDevice();
    await _prefs.setWeakDeviceAuto(weak);
  }

  @override
  bool get wifiOnlyDownloads => _prefs.wifiOnlyDownloads;

  @override
  Future<void> setWifiOnlyDownloads(bool value) =>
      _prefs.setWifiOnlyDownloads(value);

  @override
  bool isLicenseAccepted(String licenseId) =>
      _prefs.isLicenseAccepted(licenseId);

  @override
  Future<void> acceptLicense(String licenseId) =>
      _prefs.setLicenseAccepted(licenseId, true);

  @override
  Future<void> registerLocalPath(String modelId, String absolutePath) async {
    await _prefs.setPath(modelId, absolutePath);
    if (_prefs.selectedModelId.isEmpty) {
      await _prefs.setSelectedModelId(modelId);
    }
  }

  @override
  Future<void> clearPath(String modelId) => _prefs.setPath(modelId, null);

  @override
  Stream<MentorDownloadProgress> downloadFromHuggingFace(
    String modelId, {
    bool allowCellular = false,
  }) {
    final spec = MentorModelCatalog.byId(modelId);
    if (!spec.supportsHfDownload || spec.hfPreferredFile == null) {
      return Stream.value(
        MentorDownloadProgress(
          message: 'HuggingFace download is not enabled for ${spec.displayName}',
          stage: MentorDownloadStage.failed,
          error: 'unsupported',
          done: true,
        ),
      );
    }
    if (spec.sha256.isEmpty) {
      return Stream.value(
        MentorDownloadProgress(
          message: 'Missing pinned SHA-256 for ${spec.displayName}',
          stage: MentorDownloadStage.failed,
          error: 'missing_checksum',
          done: true,
        ),
      );
    }

    if (isInstalled(modelId)) {
      return Stream.value(
        MentorDownloadProgress(
          message: 'alreadyReady',
          stage: MentorDownloadStage.alreadyReady,
          fraction: 1,
          done: true,
          modelPath: pathFor(modelId),
        ),
      );
    }

    final controller = StreamController<MentorDownloadProgress>();

    () async {
      final network = await resolveMentorNetwork();
      final allowed = mentorNetworkAllowsDownload(
        kind: network,
        wifiOnly: wifiOnlyDownloads,
        allowCellularOverride: allowCellular,
      );
      if (!allowed) {
        final code = network == MentorNetworkKind.offline
            ? 'offline'
            : 'wifi_required';
        controller.add(
          MentorDownloadProgress(
            message: code,
            stage: MentorDownloadStage.failed,
            error: code,
            done: true,
          ),
        );
        await controller.close();
        return;
      }

      final download = ModelDownloadController();
      final source = ModelSource.huggingFace(
        repoId: spec.hfRepoId,
        filePath: spec.hfPreferredFile!,
      );

      late final StreamSubscription<ModelDownloadTaskSnapshot> sub;
      sub = download.snapshots.listen((snap) {
        if (controller.isClosed) return;
        final progress = snap.progress;
        controller.add(
          MentorDownloadProgress(
            message: snap.stage.name,
            stage: _mapStage(snap.stage),
            fraction: snap.fraction,
            receivedBytes: progress?.receivedBytes,
            totalBytes: progress?.totalBytes,
            done: snap.stage == ModelDownloadTaskStage.ready ||
                snap.stage == ModelDownloadTaskStage.failed ||
                snap.stage == ModelDownloadTaskStage.cancelled,
            error: snap.errorMessage,
            modelPath: snap.entry?.filePath,
          ),
        );
      });

      try {
        final entry = await download.start(source);
        if (!controller.isClosed) {
          controller.add(
            MentorDownloadProgress(
              message: 'verifying',
              stage: MentorDownloadStage.verifying,
              fraction: 1,
              modelPath: entry.filePath,
            ),
          );
        }
        await verifySha256OrThrow(
          path: entry.filePath,
          expectedHex: spec.sha256,
        );
        await registerLocalPath(modelId, entry.filePath);
        await selectModel(modelId);
        if (!controller.isClosed) {
          controller.add(
            MentorDownloadProgress(
              message: 'ready',
              stage: MentorDownloadStage.ready,
              fraction: 1,
              done: true,
              modelPath: entry.filePath,
            ),
          );
        }
      } catch (e) {
        if (!controller.isClosed) {
          controller.add(
            MentorDownloadProgress(
              message: e.toString(),
              stage: MentorDownloadStage.failed,
              error: e.toString(),
              done: true,
            ),
          );
        }
      } finally {
        await sub.cancel();
        await download.dispose();
        await controller.close();
      }
    }();

    return controller.stream;
  }

  MentorDownloadStage _mapStage(ModelDownloadTaskStage stage) {
    return switch (stage) {
      ModelDownloadTaskStage.idle => MentorDownloadStage.idle,
      ModelDownloadTaskStage.resolving => MentorDownloadStage.resolving,
      ModelDownloadTaskStage.checkingCache => MentorDownloadStage.checkingCache,
      ModelDownloadTaskStage.downloading => MentorDownloadStage.downloading,
      ModelDownloadTaskStage.verifying => MentorDownloadStage.verifying,
      ModelDownloadTaskStage.ready => MentorDownloadStage.ready,
      ModelDownloadTaskStage.failed => MentorDownloadStage.failed,
      ModelDownloadTaskStage.cancelled => MentorDownloadStage.cancelled,
    };
  }

  @override
  bool get disclaimerAccepted => _prefs.disclaimerAccepted;

  @override
  Future<void> acceptDisclaimer() => _prefs.setDisclaimerAccepted(true);

  @override
  int remainingAudiencesToday() => _prefs.remainingToday();

  @override
  Future<void> recordAudienceCompleted() => _prefs.recordAudienceCompleted();
}
