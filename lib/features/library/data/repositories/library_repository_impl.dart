import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtue_forge/core/config/app_config.dart';
import 'package:virtue_forge/features/library/domain/models/essay.dart';
import 'package:virtue_forge/features/library/domain/repositories/library_repository.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  LibraryRepositoryImpl({
    required SharedPreferences prefs,
    http.Client? client,
    AssetBundle? bundle,
  })  : _prefs = prefs,
        _client = client ?? http.Client(),
        _bundle = bundle ?? rootBundle;

  static const _versionKey = 'library_content_version';

  final SharedPreferences _prefs;
  final http.Client _client;
  final AssetBundle _bundle;

  List<Essay>? _memory;

  @override
  Future<List<Essay>> loadEssays() async {
    if (_memory != null) return _memory!;
    await _syncIndexIfNeeded();
    final disk = await _readDiskIndex();
    if (disk != null && disk.isNotEmpty) {
      _memory = disk;
      return disk;
    }
    final asset = await _readAssetIndex();
    _memory = asset;
    return asset;
  }

  @override
  Future<List<Essay>> essaysForWeek(int weekNumber, {int limit = 6}) async {
    final all = await loadEssays();
    final matched =
        all.where((e) => e.virtueWeekNumbers.contains(weekNumber)).toList();
    final pool = matched.isNotEmpty ? matched : all;
    if (pool.length <= limit) return pool;
    return pool.take(limit).toList();
  }

  @override
  Future<Essay?> randomEssay({int? focusWeekNumber}) async {
    final all = await loadEssays();
    if (all.isEmpty) return null;
    var pool = all;
    if (focusWeekNumber != null) {
      final focused =
          all.where((e) => e.virtueWeekNumbers.contains(focusWeekNumber)).toList();
      if (focused.isNotEmpty) pool = focused;
    }
    return pool[Random().nextInt(pool.length)];
  }

  @override
  Future<String> loadEssayBody(String essayId) async {
    final cacheFile = await _bodyCacheFile(essayId);
    if (await cacheFile.exists()) {
      return cacheFile.readAsString();
    }

    try {
      final uri = Uri.parse(
        '${AppConfig.apiBaseUrl}/v1/library/essays/${Uri.encodeComponent(essayId)}',
      );
      final response =
          await _client.get(uri).timeout(const Duration(seconds: 12));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final markdown = json['markdown'] as String? ?? '';
        if (markdown.isNotEmpty) {
          await _writeUtf8(cacheFile, markdown);
          return markdown;
        }
      }
    } catch (_) {
      // Fall through.
    }

    // Bundled offline pack (assets/library/{bodyPath}).
    try {
      final essays = await loadEssays();
      Essay? meta;
      for (final e in essays) {
        if (e.id == essayId) {
          meta = e;
          break;
        }
      }
      final rel = meta?.bodyPath;
      if (rel != null && rel.isNotEmpty) {
        final markdown = await _bundle.loadString('assets/library/$rel');
        if (markdown.isNotEmpty) {
          await _writeUtf8(cacheFile, markdown);
          return markdown;
        }
      }
    } catch (_) {}

    throw StateError('Essay body unavailable offline: $essayId');
  }

  @override
  Future<void> prewarmEssayBodies(Iterable<String> essayIds) async {
    for (final id in essayIds) {
      try {
        await loadEssayBody(id);
      } catch (_) {
        // Best-effort; skip missing bodies.
      }
    }
  }

  @override
  Future<String> loadEssayAnalysis(String essayId) async {
    final cacheFile = await _analysisCacheFile(essayId);
    if (await cacheFile.exists()) {
      return cacheFile.readAsString();
    }

    try {
      final uri = Uri.parse(
        '${AppConfig.apiBaseUrl}/v1/library/essays/${Uri.encodeComponent(essayId)}/analysis',
      );
      final response =
          await _client.get(uri).timeout(const Duration(seconds: 12));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final markdown = json['markdown'] as String? ?? '';
        if (markdown.isNotEmpty) {
          await _writeUtf8(cacheFile, markdown);
          return markdown;
        }
      }
      if (response.statusCode == 404) {
        throw StateError('Essay analysis unavailable: $essayId');
      }
    } catch (e) {
      if (e is StateError) rethrow;
      // Fall through to assets.
    }

    try {
      final essays = await loadEssays();
      Essay? meta;
      for (final e in essays) {
        if (e.id == essayId) {
          meta = e;
          break;
        }
      }
      final rel = meta?.analysisPath;
      if (rel != null && rel.isNotEmpty) {
        final markdown = await _bundle.loadString('assets/library/$rel');
        if (markdown.isNotEmpty) {
          await _writeUtf8(cacheFile, markdown);
          return markdown;
        }
      }
      // Convention fallback next to bodyPath.
      final body = meta?.bodyPath;
      if (body != null && body.isNotEmpty) {
        final stem = body.replaceAll(RegExp(r'\.md$', caseSensitive: false), '');
        final markdown =
            await _bundle.loadString('assets/library/${stem}_analysis.md');
        if (markdown.isNotEmpty) {
          await _writeUtf8(cacheFile, markdown);
          return markdown;
        }
      }
    } catch (_) {}

    throw StateError('Essay analysis unavailable offline: $essayId');
  }

  Future<void> _writeUtf8(File file, String text) async {
    await file.parent.create(recursive: true);
    await file.writeAsString(text, encoding: utf8);
  }

  Future<void> _syncIndexIfNeeded() async {
    try {
      final uri = Uri.parse('${AppConfig.apiBaseUrl}/v1/library/index');
      final response =
          await _client.get(uri).timeout(const Duration(seconds: 8));
      if (response.statusCode != 200) return;

      final decoded = jsonDecode(response.body);
      final version = decoded is Map
          ? (decoded['contentVersion'] as String? ?? '')
          : '';
      final known = _prefs.getString(_versionKey) ?? '';
      final file = await _indexCacheFile();
      if (version.isNotEmpty &&
          version == known &&
          await file.exists()) {
        return;
      }

      await file.parent.create(recursive: true);
      await file.writeAsString(response.body, encoding: utf8);
      if (version.isNotEmpty) {
        await _prefs.setString(_versionKey, version);
      }
      _memory = null;
    } catch (_) {
      // Offline.
    }
  }

  Future<List<Essay>?> _readDiskIndex() async {
    final file = await _indexCacheFile();
    if (!await file.exists()) return null;
    try {
      return _parseIndex(await file.readAsString());
    } catch (_) {
      return null;
    }
  }

  Future<List<Essay>> _readAssetIndex() async {
    try {
      final raw = await _bundle.loadString('assets/library/index.json');
      return _parseIndex(raw);
    } catch (_) {
      try {
        final raw = await _bundle.loadString('assets/essays.json');
        return _parseIndex(raw);
      } catch (_) {
        return const [];
      }
    }
  }

  List<Essay> _parseIndex(String raw) {
    final decoded = jsonDecode(raw);
    final list = decoded is List
        ? decoded
        : (decoded is Map && decoded['essays'] is List)
            ? decoded['essays'] as List
            : const [];
    return list
        .whereType<Map>()
        .map((e) => Essay.fromJson(Map<String, dynamic>.from(e)))
        .where((e) => e.id.isNotEmpty)
        .toList();
  }

  Future<File> _indexCacheFile() async {
    final dir = await getApplicationSupportDirectory();
    return File(p.join(dir.path, 'library', 'index.json'));
  }

  Future<File> _bodyCacheFile(String essayId) async {
    final dir = await getApplicationSupportDirectory();
    final safe = essayId.replaceAll(RegExp(r'[^\w\-.]'), '_');
    return File(p.join(dir.path, 'library', 'bodies', '$safe.md'));
  }

  Future<File> _analysisCacheFile(String essayId) async {
    final dir = await getApplicationSupportDirectory();
    final safe = essayId.replaceAll(RegExp(r'[^\w\-.]'), '_');
    return File(p.join(dir.path, 'library', 'analysis', '$safe.md'));
  }
}
