import 'package:drift/drift.dart';
import 'package:virtue_forge/core/database/tables/franklin_virtues.dart';
import 'package:virtue_forge/core/database/tables/stoic_categories.dart';

/// Append-friendly XP ledger. Rows are rebuilt idempotently via [dedupeKey].
class XpEvents extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get categoryId => integer().references(StoicCategories, #id)();

  /// Signed delta (e.g. +150, -10).
  IntColumn get amount => integer()();

  /// `weekBase` | `cleanDay` | `focusStrike` | `nonFocusStrike` | `archetypeBonus` | `dust`
  TextColumn get kind => text()();

  IntColumn get virtueId =>
      integer().nullable().references(FranklinVirtues, #id)();

  /// Calendar day the event relates to (clean day / strike day / week Monday).
  DateTimeColumn get eventDate => dateTime()();

  /// Focus week Monday; null for lifetime bonuses (archetype).
  DateTimeColumn get weekStart => dateTime().nullable()();

  TextColumn get dedupeKey => text()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {dedupeKey},
      ];
}
