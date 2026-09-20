import 'package:drift/drift.dart';
import 'package:virtue_forge/core/database/tables/stoic_categories.dart';

class FranklinVirtues extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Внешний ключ: привязка к 4 главным стоическим категориям
  IntColumn get stoicCategoryId => integer().references(StoicCategories, #id)();

  TextColumn get name => text().withLength(min: 3, max: 50)();
  TextColumn get description => text()(); // Ключ l10n или дефолтный текст Франклина
  TextColumn get customDescription => text().nullable()(); // Пользовательская формулировка
  IntColumn get defaultWeekNumber => integer()(); // Порядковый номер недели в цикле (1..13)
}