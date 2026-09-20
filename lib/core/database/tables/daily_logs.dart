import 'package:drift/drift.dart';

import 'franklin_virtues.dart';

class DailyLogs extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Дата лога. Храним как DateTime, Drift сам сконвертирует в Текст/UnixTime
  DateTimeColumn get date => dateTime()();

  // К какой добродетели относится лог (обычно это фокусная добродетель этой недели)
  IntColumn get virtueId => integer().references(FranklinVirtues, #id)();

  // Количество "черных точек" (проступков) за этот день
  IntColumn get strikesCount => integer().withDefault(const Constant(0))();

  // Вечерняя стоическая рефлексия (Дихотомия контроля)
  TextColumn get noteControlled => text().nullable()(); // Что я контролировал?
  TextColumn get noteUncontrolled => text().nullable()(); // Что было вне моего контроля?

  /// Deprecated (schema 3): day-level note. Prefer [StrikeNotes] per ordinal.
  TextColumn get strikeNote => text().nullable()();

  // Уникальный индекс, чтобы на один день для одной добродетели была только одна запись
  @override
  List<Set<Column>> get uniqueKeys => [
    {date, virtueId}
  ];
}