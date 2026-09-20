import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtue_forge/core/config/app_config.dart';
import 'package:virtue_forge/features/library/domain/models/stoic_quote.dart';
import 'package:virtue_forge/features/library/domain/repositories/quotes_repository.dart';

class QuotesRepositoryImpl implements QuotesRepository {
  QuotesRepositoryImpl({
    required SharedPreferences prefs,
    http.Client? client,
    AssetBundle? bundle,
  })  : _prefs = prefs,
        _client = client ?? http.Client(),
        _bundle = bundle ?? rootBundle;

  static const _versionKey = 'quotes_content_version';
  static const _etagPrefix = 'quotes_etag_';

  final SharedPreferences _prefs;
  final http.Client _client;
  final AssetBundle _bundle;

  final Map<String, List<StoicQuote>> _memory = {};

  @override
  Future<List<StoicQuote>> loadQuotes(String localeCode) async {
    final locale = _normalizeLocale(localeCode);
    final cachedMem = _memory[locale];
    if (cachedMem != null) return cachedMem;

    await _syncFromNetworkIfNeeded();

    final disk = await _readDiskCache(locale);
    if (disk != null && disk.isNotEmpty) {
      _memory[locale] = disk;
      return disk;
    }

    final asset = await _readAssetFallback(locale);
    _memory[locale] = asset;
    return asset;
  }

  @override
  Future<StoicQuote?> quoteOfDay({
    required String localeCode,
    DateTime? date,
    int? focusWeekNumber,
  }) async {
    final locale = _normalizeLocale(localeCode);
    final day = date ?? DateTime.now();
    final dateIso =
        '${day.year.toString().padLeft(4, '0')}-'
        '${day.month.toString().padLeft(2, '0')}-'
        '${day.day.toString().padLeft(2, '0')}';

    try {
      final uri = Uri.parse('${AppConfig.apiBaseUrl}/v1/quotes/daily').replace(
        queryParameters: {
          'locale': locale,
          'date': dateIso,
          if (focusWeekNumber != null) 'focusWeek': '$focusWeekNumber',
        },
      );
      final response = await _client
          .get(uri)
          .timeout(const Duration(seconds: 4));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final quote = StoicQuote.fromJson(json);
        if (quote.hasText) return quote;
      }
    } catch (_) {
      // Fall through to local pool.
    }

    final quotes = await loadQuotes(locale);
    return _pickLocalDaily(
      quotes: quotes,
      day: day,
      focusWeekNumber: focusWeekNumber,
    );
  }

  Future<void> _syncFromNetworkIfNeeded() async {
    try {
      final metaUri = Uri.parse('${AppConfig.apiBaseUrl}/v1/meta');
      final metaRes =
          await _client.get(metaUri).timeout(const Duration(seconds: 4));
      if (metaRes.statusCode != 200) return;

      final meta = jsonDecode(metaRes.body) as Map<String, dynamic>;
      final version = meta['contentVersion'] as String? ?? '';
      final known = _prefs.getString(_versionKey) ?? '';

      final enPath = await _cacheFile('en');
      final ruPath = await _cacheFile('ru');
      final needsFetch = version.isEmpty ||
          version != known ||
          !await enPath.exists() ||
          !await ruPath.exists();
      if (!needsFetch) return;

      await _fetchAndStoreLocale('en');
      await _fetchAndStoreLocale('ru');
      if (version.isNotEmpty) {
        await _prefs.setString(_versionKey, version);
      }
      _memory.clear();
    } catch (_) {
      // Offline: keep whatever cache/assets we have.
    }
  }

  Future<void> _fetchAndStoreLocale(String locale) async {
    final uri = Uri.parse('${AppConfig.apiBaseUrl}/v1/quotes').replace(
      queryParameters: {'locale': locale},
    );
    final headers = <String, String>{};
    final etag = _prefs.getString('$_etagPrefix$locale');
    if (etag != null) headers['If-None-Match'] = etag;

    final response = await _client
        .get(uri, headers: headers)
        .timeout(const Duration(seconds: 20));

    if (response.statusCode == 304) return;
    if (response.statusCode != 200) return;

    final responseEtag = response.headers['etag'];
    if (responseEtag != null) {
      await _prefs.setString('$_etagPrefix$locale', responseEtag);
    }

    final file = await _cacheFile(locale);
    await file.parent.create(recursive: true);
    await file.writeAsString(response.body, encoding: utf8);
  }

  Future<List<StoicQuote>?> _readDiskCache(String locale) async {
    final file = await _cacheFile(locale);
    if (!await file.exists()) return null;
    try {
      final raw = await file.readAsString();
      return _parseList(raw);
    } catch (_) {
      return null;
    }
  }

  Future<List<StoicQuote>> _readAssetFallback(String locale) async {
    final primary = await _loadAssetQuotes(locale);
    if (primary.isNotEmpty) return primary;
    if (locale != 'en') {
      return _loadAssetQuotes('en');
    }
    return const [];
  }

  /// Prefer gzipped APK assets (~0.7 MB) over plain JSON (~2.9 MB).
  Future<List<StoicQuote>> _loadAssetQuotes(String locale) async {
    final gz = await _tryParseAssetBytes('assets/quotes/$locale.json.gz');
    if (gz.isNotEmpty) return gz;
    return _tryParseAssetString('assets/quotes/$locale.json');
  }

  Future<List<StoicQuote>> _tryParseAssetBytes(String assetPath) async {
    try {
      final data = await _bundle.load(assetPath);
      final compressed =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      final raw = utf8.decode(gzip.decode(compressed));
      return _parseList(raw);
    } catch (_) {
      return const [];
    }
  }

  Future<List<StoicQuote>> _tryParseAssetString(String assetPath) async {
    try {
      final raw = await _bundle.loadString(assetPath);
      return _parseList(raw);
    } catch (_) {
      return const [];
    }
  }

  List<StoicQuote> _parseList(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! List) return const [];
    return decoded
        .whereType<Map>()
        .map((e) => StoicQuote.fromJson(Map<String, dynamic>.from(e)))
        .where((q) => q.id.isNotEmpty)
        .toList();
  }

  StoicQuote? _pickLocalDaily({
    required List<StoicQuote> quotes,
    required DateTime day,
    int? focusWeekNumber,
  }) {
    final withText = quotes.where((q) => q.hasText).toList();
    if (withText.isEmpty) return null;

    var pool = withText;
    if (focusWeekNumber != null) {
      final focused = withText
          .where((q) => q.virtueWeekNumbers.contains(focusWeekNumber))
          .toList();
      if (focused.isNotEmpty) pool = focused;
    } else {
      final tagged =
          withText.where((q) => q.virtueWeekNumbers.isNotEmpty).toList();
      if (tagged.isNotEmpty) pool = tagged;
    }

    final dayIndex = DateTime.utc(day.year, day.month, day.day)
            .millisecondsSinceEpoch ~/
        Duration.millisecondsPerDay;
    return pool[dayIndex % pool.length];
  }

  Future<File> _cacheFile(String locale) async {
    final dir = await getApplicationSupportDirectory();
    return File(p.join(dir.path, 'quotes', '$locale.json'));
  }

  String _normalizeLocale(String localeCode) {
    final code = localeCode.toLowerCase().split(RegExp('[-_]')).first;
    return code == 'ru' ? 'ru' : 'en';
  }
}
