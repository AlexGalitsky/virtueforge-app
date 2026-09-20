// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_dao.dart';

// ignore_for_file: type=lint
mixin _$JournalDaoMixin on DatabaseAccessor<AppDatabase> {
  $StoicCategoriesTable get stoicCategories => attachedDatabase.stoicCategories;
  $FranklinVirtuesTable get franklinVirtues => attachedDatabase.franklinVirtues;
  $DailyLogsTable get dailyLogs => attachedDatabase.dailyLogs;
  $StrikeNotesTable get strikeNotes => attachedDatabase.strikeNotes;
  JournalDaoManager get managers => JournalDaoManager(this);
}

class JournalDaoManager {
  final _$JournalDaoMixin _db;
  JournalDaoManager(this._db);
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
  $$DailyLogsTableTableManager get dailyLogs =>
      $$DailyLogsTableTableManager(_db.attachedDatabase, _db.dailyLogs);
  $$StrikeNotesTableTableManager get strikeNotes =>
      $$StrikeNotesTableTableManager(_db.attachedDatabase, _db.strikeNotes);
}
