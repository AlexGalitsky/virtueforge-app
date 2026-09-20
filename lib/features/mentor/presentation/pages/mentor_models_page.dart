import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtue_forge/core/di/injection_container.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/mentor/data/mentor_network.dart';
import 'package:virtue_forge/features/mentor/domain/models/mentor_model_spec.dart';
import 'package:virtue_forge/features/mentor/domain/repositories/mentor_repositories.dart';
import 'package:virtue_forge/features/mentor/domain/services/local_mentor_engine.dart';
import 'package:virtue_forge/generated/l10n/app_localizations.dart';

class MentorModelsPage extends StatefulWidget {
  const MentorModelsPage({
    super.key,
    required this.store,
    required this.engine,
  });

  final MentorModelStore store;
  final LocalMentorEngine engine;

  static Future<void> open(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MentorModelsPage(
          store: sl<MentorModelStore>(),
          engine: sl<LocalMentorEngine>(),
        ),
      ),
    );
  }

  @override
  State<MentorModelsPage> createState() => _MentorModelsPageState();
}

class _MentorModelsPageState extends State<MentorModelsPage> {
  MentorModelStore get _store => widget.store;
  LocalMentorEngine get _engine => widget.engine;
  String? _busyModelId;
  String _status = '';
  double? _progress;
  bool _releasing = false;

  Future<void> _refresh() async => setState(() {});

  String _loadedModelLabel() {
    final path = _engine.loadedPath;
    if (path == null) return '';
    for (final spec in MentorModelCatalog.all) {
      final p = _store.pathFor(spec.id);
      if (p != null && p == path) return spec.displayName;
    }
    final name = path.replaceAll('\\', '/').split('/').last;
    return name.isEmpty ? path : name;
  }

  Future<void> _releaseMemory() async {
    if (!_engine.isReady || _releasing) return;
    setState(() => _releasing = true);
    try {
      await _engine.unload();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.mentorMemoryReleased)),
      );
    } finally {
      if (mounted) setState(() => _releasing = false);
    }
  }

  Future<bool> _ensureLicense(MentorModelSpec spec) async {
    if (!spec.requiresLicenseAcceptance) return true;
    if (_store.isLicenseAccepted(spec.licenseId)) return true;
    if (!mounted) return false;
    final l10n = context.l10n;
    final body = switch (spec.license) {
      MentorLicenseKind.qwenResearch => l10n.mentorLicenseGateQwenResearch,
      MentorLicenseKind.llamaCommunity => l10n.mentorLicenseGateLlama,
      MentorLicenseKind.apache2 => '',
    };
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(ctx.l10n.mentorLicenseGateTitle),
        content: SingleChildScrollView(child: Text(body)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(ctx.l10n.mentorLicenseGateCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(ctx.l10n.mentorLicenseGateAccept),
          ),
        ],
      ),
    );
    if (ok != true) return false;
    await _store.acceptLicense(spec.licenseId);
    return true;
  }

  Future<void> _showNotice() async {
    final text = await rootBundle.loadString('assets/legal/NOTICE.txt');
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(ctx.l10n.mentorLicenseNoticeTitle),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Text(text, style: const TextStyle(fontSize: 12, height: 1.35)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(ctx.l10n.mentorLicenseGateCancel),
          ),
        ],
      ),
    );
  }

  Future<void> _pickLocal(MentorModelSpec spec) async {
    if (!await _ensureLicense(spec)) return;
    const typeGroup = XTypeGroup(
      label: 'GGUF',
      extensions: ['gguf'],
    );
    final file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file == null) return;
    await _store.registerLocalPath(spec.id, file.path);
    await _store.selectModel(spec.id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.mentorModelRegistered)),
    );
    await _refresh();
  }

  Future<void> _download(MentorModelSpec spec, {bool allowCellular = false}) async {
    if (!await _ensureLicense(spec)) return;
    final l10n = context.l10n;

    if (!allowCellular && _store.wifiOnlyDownloads) {
      final network = await resolveMentorNetwork();
      if (network == MentorNetworkKind.offline) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.mentorDownloadOffline)),
        );
        return;
      }
      if (network == MentorNetworkKind.mobile ||
          network == MentorNetworkKind.unknown) {
        if (!mounted) return;
        final go = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(ctx.l10n.mentorWifiRequiredTitle),
            content: Text(
              ctx.l10n.mentorWifiRequiredBody(spec.approxSizeLabel),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(ctx.l10n.mentorWifiRequiredWait),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(ctx.l10n.mentorWifiRequiredContinue),
              ),
            ],
          ),
        );
        if (go != true) return;
        allowCellular = true;
      }
    }

    setState(() {
      _busyModelId = spec.id;
      _status = l10n.mentorDownloadStarting;
      _progress = null;
    });

    await for (final p in _store.downloadFromHuggingFace(
      spec.id,
      allowCellular: allowCellular,
    )) {
      if (!mounted) return;
      setState(() {
        _status = _statusFor(l10n, p);
        _progress = p.fraction;
        if (p.done) _busyModelId = null;
      });
      if (p.stage == MentorDownloadStage.alreadyReady) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.mentorDownloadAlreadyReady)),
        );
        await _refresh();
        return;
      }
      if (p.error != null) {
        final msg = switch (p.error) {
          'offline' => l10n.mentorDownloadOffline,
          'wifi_required' => l10n.mentorDownloadWifiBlocked,
          _ => p.error!,
        };
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
        return;
      }
      if (p.done && p.modelPath != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.mentorDownloadDone)),
        );
      }
    }
    await _refresh();
  }

  String _statusFor(AppLocalizations l10n, MentorDownloadProgress p) {
    final bytes = _bytesLabel(l10n, p);
    return switch (p.stage) {
      MentorDownloadStage.alreadyReady => l10n.mentorDownloadAlreadyReady,
      MentorDownloadStage.resolving => l10n.mentorDownloadResolving,
      MentorDownloadStage.checkingCache => l10n.mentorDownloadCheckingCache,
      MentorDownloadStage.downloading => bytes.isEmpty
          ? l10n.mentorDownloadDownloading
          : '${l10n.mentorDownloadDownloading} · $bytes',
      MentorDownloadStage.verifying => l10n.mentorDownloadVerifying,
      MentorDownloadStage.ready => l10n.mentorDownloadDone,
      MentorDownloadStage.failed => p.error ?? l10n.mentorDownloadFailed,
      MentorDownloadStage.cancelled => l10n.mentorDownloadCancelled,
      MentorDownloadStage.idle => l10n.mentorDownloadStarting,
    };
  }

  String _bytesLabel(AppLocalizations l10n, MentorDownloadProgress p) {
    final received = p.receivedBytes;
    if (received == null || received <= 0) {
      final f = p.fraction;
      if (f != null) {
        return l10n.mentorDownloadPercent((f * 100).clamp(0, 100).round());
      }
      return '';
    }
    final recvMb = (received / (1024 * 1024)).toStringAsFixed(1);
    final total = p.totalBytes;
    if (total != null && total > 0) {
      final totalMb = (total / (1024 * 1024)).toStringAsFixed(1);
      final pct = ((received / total) * 100).clamp(0, 100).round();
      return l10n.mentorDownloadBytes(recvMb, totalMb, pct);
    }
    return l10n.mentorDownloadBytesOnly(recvMb);
  }

  Future<void> _select(MentorModelSpec spec) async {
    if (!await _ensureLicense(spec)) return;
    final weak = _store.isWeakDevice;
    if (weak && spec.tier == MentorModelTier.standard) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(ctx.l10n.mentorWeakTitle),
          content: Text(ctx.l10n.mentorWeakBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(ctx.l10n.mentorWeakKeepLight),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(ctx.l10n.mentorWeakUseHeavy),
            ),
          ],
        ),
      );
      if (ok != true) return;
    }
    await _store.selectModel(spec.id);
    await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final l10n = context.l10n;
    final colors = context.colorScheme;

    return StoicPageScaffold(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(l10n.mentorModelsTitle, style: text.pageTitle),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            Text(l10n.mentorModelsLead, style: text.body),
            if (_engine.isReady) ...[
              const SizedBox(height: 16),
              _MemoryResidenceCard(
                modelLabel: _loadedModelLabel(),
                releasing: _releasing,
                onRelease: _releaseMemory,
              ),
            ],
            const SizedBox(height: 12),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.mentorWeakDeviceToggle, style: text.tileTitle),
              subtitle: Text(
                _store.isWeakDeviceFromAuto
                    ? l10n.mentorWeakDeviceToggleSubAuto
                    : l10n.mentorWeakDeviceToggleSub,
                style: text.captionAccent,
              ),
              value: _store.isWeakDevice,
              onChanged: (v) async {
                await _store.setWeakDevice(v);
                await _refresh();
              },
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.mentorWifiOnlyToggle, style: text.tileTitle),
              subtitle: Text(l10n.mentorWifiOnlyToggleSub, style: text.captionAccent),
              value: _store.wifiOnlyDownloads,
              onChanged: (v) async {
                await _store.setWifiOnlyDownloads(v);
                await _refresh();
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: _showNotice,
                child: Text(l10n.mentorLicenseNoticeButton),
              ),
            ),
            if (_store.isInstalled(MentorModelCatalog.llama32.id) ||
                _store.selectedModelId == MentorModelCatalog.llama32.id)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  l10n.mentorBuiltWithLlama,
                  style: text.captionAccent.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.primary,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            for (final spec in MentorModelCatalog.all) ...[
              _ModelCard(
                spec: spec,
                selected: _store.selectedModelId == spec.id,
                installed: _store.isInstalled(spec.id),
                path: _store.pathFor(spec.id),
                busy: _busyModelId == spec.id,
                progress: _busyModelId == spec.id ? _progress : null,
                status: _busyModelId == spec.id ? _status : null,
                onSelect: () => _select(spec),
                onPickLocal: () => _pickLocal(spec),
                onDownload: spec.supportsHfDownload
                    ? () => _download(spec)
                    : null,
                onClear: _store.isInstalled(spec.id)
                    ? () async {
                        await _store.clearPath(spec.id);
                        await _refresh();
                      }
                    : null,
              ),
              const SizedBox(height: 12),
            ],
            Text(
              l10n.mentorLicenseFootnote,
              style: text.captionAccent.copyWith(
                color: colors.onSurface.withValues(alpha: 0.65),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemoryResidenceCard extends StatelessWidget {
  const _MemoryResidenceCard({
    required this.modelLabel,
    required this.releasing,
    required this.onRelease,
  });

  final String modelLabel;
  final bool releasing;
  final VoidCallback onRelease;

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final colors = context.colorScheme;
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.primary.withValues(alpha: 0.45),
        ),
        color: colors.primary.withValues(alpha: 0.06),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.mentorMemoryEyebrow, style: text.eyebrowAccent),
          const SizedBox(height: 8),
          Text(
            l10n.mentorMemoryHeld(modelLabel),
            style: text.tileTitle.copyWith(height: 1.35),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.mentorMemoryHint,
            style: text.captionAccent.copyWith(
              color: colors.onSurface.withValues(alpha: 0.7),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton(
              onPressed: releasing ? null : onRelease,
              child: releasing
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colors.primary,
                      ),
                    )
                  : Text(l10n.mentorMemoryRelease),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModelCard extends StatelessWidget {
  const _ModelCard({
    required this.spec,
    required this.selected,
    required this.installed,
    required this.path,
    required this.busy,
    required this.onSelect,
    required this.onPickLocal,
    this.onDownload,
    this.onClear,
    this.progress,
    this.status,
  });

  final MentorModelSpec spec;
  final bool selected;
  final bool installed;
  final String? path;
  final bool busy;
  final VoidCallback onSelect;
  final VoidCallback onPickLocal;
  final VoidCallback? onDownload;
  final VoidCallback? onClear;
  final double? progress;
  final String? status;

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final colors = context.colorScheme;
    final l10n = context.l10n;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? colors.primary.withValues(alpha: 0.7)
                  : colors.outline.withValues(alpha: 0.35),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(spec.displayName, style: text.cardTitle),
                  ),
                  if (selected)
                    Text(l10n.mentorSelectedBadge, style: text.captionAccent),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '${spec.approxSizeLabel} · ${spec.tier.name}',
                style: text.captionAccent,
              ),
              if (installed && path != null) ...[
                const SizedBox(height: 6),
                Text(
                  path!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: text.captionAccent.copyWith(fontSize: 11),
                ),
              ],
              if (busy) ...[
                const SizedBox(height: 10),
                LinearProgressIndicator(value: progress),
                const SizedBox(height: 6),
                Text(status ?? '', style: text.captionAccent),
                if (progress == null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      l10n.mentorDownloadIndeterminateHint,
                      style: text.captionAccent.copyWith(
                        color: colors.onSurface.withValues(alpha: 0.65),
                      ),
                    ),
                  ),
              ],
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (onDownload != null)
                    OutlinedButton(
                      onPressed: busy ? null : onDownload,
                      child: Text(
                        installed
                            ? l10n.mentorDownloadHfAgain
                            : l10n.mentorDownloadHf,
                      ),
                    ),
                  OutlinedButton(
                    onPressed: busy ? null : onPickLocal,
                    child: Text(l10n.mentorPickLocal),
                  ),
                  if (onClear != null)
                    TextButton(
                      onPressed: busy ? null : onClear,
                      child: Text(l10n.mentorClearPath),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
