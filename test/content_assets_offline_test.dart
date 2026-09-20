import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('gzipped EN/RU quote assets decompress to non-empty JSON lists', () {
    for (final locale in ['en', 'ru']) {
      final file = File('assets/quotes/$locale.json.gz');
      expect(file.existsSync(), isTrue, reason: '$locale.gz missing');
      final raw = utf8.decode(gzip.decode(file.readAsBytesSync()));
      final decoded = jsonDecode(raw);
      expect(decoded, isA<List>());
      expect((decoded as List).length, greaterThan(100));
    }
  });

  test('gzipped quotes are much smaller than plain JSON sources', () {
    final enJson = File('assets/quotes/en.json').lengthSync();
    final enGz = File('assets/quotes/en.json.gz').lengthSync();
    final ruJson = File('assets/quotes/ru.json').lengthSync();
    final ruGz = File('assets/quotes/ru.json.gz').lengthSync();
    expect(enGz / enJson, lessThan(0.4));
    expect(ruGz / ruJson, lessThan(0.4));
  });

  test('bundled essay bodies cover index bodyPath entries', () {
    final indexRaw = File('assets/library/index.json').readAsStringSync();
    final decoded = jsonDecode(indexRaw);
    final essays = decoded is List
        ? decoded
        : (decoded as Map)['essays'] as List;
    var missing = 0;
    for (final entry in essays.whereType<Map>()) {
      final bodyPath = entry['bodyPath'] as String?;
      if (bodyPath == null || bodyPath.isEmpty) {
        missing++;
        continue;
      }
      final file = File('assets/library/$bodyPath');
      if (!file.existsSync() || file.lengthSync() == 0) missing++;
    }
    expect(missing, 0);
    expect(essays.length, greaterThan(50));
  });
}
