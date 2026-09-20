import 'package:drift/drift.dart';

/// 13-недельный цикл практики Франклина.
/// Ровно один ряд с [endedAt] == null — активный цикл.
class PracticeCycles extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Понедельник недели 1 (добродетель 1).
  DateTimeColumn get startedAt => dateTime()();

  /// null = активный; иначе дата закрытия (обычно [startedAt] + 13 недель).
  DateTimeColumn get endedAt => dateTime().nullable()();

  /// Глобальный порядковый номер (1, 2, 3…).
  IntColumn get sequenceNumber => integer()();

  /// Заполняется при закрытии: средний % успеха (0–100).
  IntColumn get successPercent => integer().nullable()();

  /// Stoic category id самой слабой колонны в цикле.
  IntColumn get weakPillarId => integer().nullable()();

  IntColumn get totalStrikes => integer().nullable()();
}
