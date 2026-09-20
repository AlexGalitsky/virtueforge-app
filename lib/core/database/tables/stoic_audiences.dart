import 'package:drift/drift.dart';

/// Saved Portico mentor audiences (local-first).
class StoicAudiences extends Table {
  TextColumn get id => text()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get virtueWeekNumber => integer()();

  TextColumn get virtueLabel => text()();

  TextColumn get misdeedSummary => text().withDefault(const Constant(''))();

  TextColumn get note => text().withDefault(const Constant(''))();

  TextColumn get userReflection => text()();

  TextColumn get aiResponse => text()();

  TextColumn get modelId => text()();

  BoolColumn get interrupted =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
