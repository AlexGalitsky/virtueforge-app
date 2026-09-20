// web.dart
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

QueryExecutor connect(String dbName) {
  return LazyDatabase(() async {
    // Находим или скачиваем drift.sqlite.wasm и sqlite3.wasm
    final result = await WasmDatabase.open(
      databaseName: dbName,
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );

    if (result.missingFeatures.isNotEmpty) {
      // Браузер не поддерживает все фичи (например, старая Safari),
      // но Drift все равно попытается работать в режиме совместимости
      print('Предупреждение Drift Web: ${result.missingFeatures}');
    }

    return result.resolvedExecutor;
  });
}
