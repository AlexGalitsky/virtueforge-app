// connection.dart
import 'package:drift/drift.dart';

// Условный импорт: если доступен dart.library.js_interop, берем web.dart,
// если dart.library.io (мобилки/десктоп) — native.dart
import 'native.dart' if (dart.library.js_interop) 'web.dart' as impl;

/// Создает подключение к базе данных для текущей платформы
QueryExecutor connect(String dbName) {
  return impl.connect(dbName);
}
