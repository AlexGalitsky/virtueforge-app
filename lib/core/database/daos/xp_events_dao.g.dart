// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xp_events_dao.dart';

// ignore_for_file: type=lint
mixin _$XpEventsDaoMixin on DatabaseAccessor<AppDatabase> {
  $StoicCategoriesTable get stoicCategories => attachedDatabase.stoicCategories;
  $FranklinVirtuesTable get franklinVirtues => attachedDatabase.franklinVirtues;
  $XpEventsTable get xpEvents => attachedDatabase.xpEvents;
  XpEventsDaoManager get managers => XpEventsDaoManager(this);
}

class XpEventsDaoManager {
  final _$XpEventsDaoMixin _db;
  XpEventsDaoManager(this._db);
  $$StoicCategoriesTableTableManager get stoicCategories =>
      $$StoicCategoriesTableTableManager(
        _db.attachedDatabase,
        _db.stoicCategories,
      );
  $$FranklinVirtuesTableTableManager get franklinVirtues =>
      $$FranklinVirtuesTableTableManager(
        _db.attachedDatabase,
        _db.franklinVirtues,
      );
  $$XpEventsTableTableManager get xpEvents =>
      $$XpEventsTableTableManager(_db.attachedDatabase, _db.xpEvents);
}
