import 'package:drift/drift.dart';
import 'package:virtue_forge/core/database/tables/franklin_virtues.dart';

/// Заметка, привязанная к конкретному проступку (ordinal 1..N за день×добродетель).
class StrikeNotes extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get date => dateTime()();

  IntColumn get virtueId => integer().references(FranklinVirtues, #id)();

  /// Порядковый номер проступка в этот день (1 = первый, …).
  IntColumn get ordinal => integer()();

  TextColumn get body => text()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {date, virtueId, ordinal},
      ];
}
