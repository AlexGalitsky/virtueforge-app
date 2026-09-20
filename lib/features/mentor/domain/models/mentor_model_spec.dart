enum MentorModelTier { light, standard }

enum MentorLicenseKind { apache2, qwenResearch, llamaCommunity }

/// Static catalog entry for an on-device GGUF mentor model.
class MentorModelSpec {
  const MentorModelSpec({
    required this.id,
    required this.displayName,
    required this.expectedFilename,
    required this.tier,
    required this.license,
    required this.hfRepoId,
    /// Lowercase hex SHA-256 of the HF file (fail closed when downloading).
    required this.sha256,
    this.hfPreferredFile,
    this.supportsHfDownload = false,
    this.approxSizeLabel = '~1 GB',
  });

  final String id;
  final String displayName;
  final String expectedFilename;
  final MentorModelTier tier;
  final MentorLicenseKind license;
  final String hfRepoId;
  final String sha256;
  final String? hfPreferredFile;
  final bool supportsHfDownload;
  final String approxSizeLabel;

  /// Stable id for prefs / NOTICE mapping.
  String get licenseId => switch (license) {
        MentorLicenseKind.apache2 => 'apache-2.0',
        MentorLicenseKind.qwenResearch => 'qwen-research',
        MentorLicenseKind.llamaCommunity => 'llama-3.2-community',
      };

  /// Qwen Research + Llama need an explicit accept before download/select.
  bool get requiresLicenseAcceptance =>
      license == MentorLicenseKind.qwenResearch ||
      license == MentorLicenseKind.llamaCommunity;
}

abstract final class MentorModelCatalog {
  /// Hashes from Hugging Face LFS pointers (repo main, fetched 2026-09-04).
  static const qwen15 = MentorModelSpec(
    id: 'qwen15',
    displayName: 'Qwen 2.5 1.5B',
    expectedFilename: 'Qwen2.5-1.5B-Instruct-Q4_K_M.gguf',
    tier: MentorModelTier.light,
    license: MentorLicenseKind.apache2,
    hfRepoId: 'Qwen/Qwen2.5-1.5B-Instruct-GGUF',
    hfPreferredFile: 'qwen2.5-1.5b-instruct-q4_k_m.gguf',
    supportsHfDownload: true,
    approxSizeLabel: '~1.1 GB',
    sha256:
        '6a1a2eb6d15622bf3c96857206351ba97e1af16c30d7a74ee38970e434e9407e',
  );

  static const qwen3 = MentorModelSpec(
    id: 'qwen3',
    displayName: 'Qwen 2.5 3B',
    expectedFilename: 'Qwen2.5-3B-Instruct-Q4_K_M.gguf',
    tier: MentorModelTier.standard,
    license: MentorLicenseKind.qwenResearch,
    hfRepoId: 'Qwen/Qwen2.5-3B-Instruct-GGUF',
    hfPreferredFile: 'qwen2.5-3b-instruct-q4_k_m.gguf',
    supportsHfDownload: true,
    approxSizeLabel: '~2.0 GB',
    sha256:
        '626b4a6678b86442240e33df819e00132d3ba7dddfe1cdc4fbb18e0a9615c62d',
  );

  static const llama32 = MentorModelSpec(
    id: 'llama32',
    displayName: 'Llama 3.2 3B',
    expectedFilename: 'Llama-3.2-3B-Instruct-Q4_K_M.gguf',
    tier: MentorModelTier.standard,
    license: MentorLicenseKind.llamaCommunity,
    hfRepoId: 'bartowski/Llama-3.2-3B-Instruct-GGUF',
    hfPreferredFile: 'Llama-3.2-3B-Instruct-Q4_K_M.gguf',
    supportsHfDownload: true,
    approxSizeLabel: '~2.0 GB',
    sha256:
        '6c1a2b41161032677be168d354123594c0e6e67d2b9227c84f296ad037c728ff',
  );

  static const List<MentorModelSpec> all = [qwen15, qwen3, llama32];

  static MentorModelSpec byId(String id) {
    for (final m in all) {
      if (m.id == id) return m;
    }
    return qwen15;
  }

  static const defaultModelId = 'qwen15';
}
