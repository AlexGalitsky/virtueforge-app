import 'package:drift/drift.dart';

class StoicCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 3, max: 50)();
  TextColumn get description => text()();
  TextColumn get iconPath => text().nullable()(); // Путь к ассету иконки
}
