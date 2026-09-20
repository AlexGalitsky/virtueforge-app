// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'virtues_dao.dart';

// ignore_for_file: type=lint
mixin _$VirtuesDaoMixin on DatabaseAccessor<AppDatabase> {
  $StoicCategoriesTable get stoicCategories => attachedDatabase.stoicCategories;
  $FranklinVirtuesTable get franklinVirtues => attachedDatabase.franklinVirtues;
  VirtuesDaoManager get managers => VirtuesDaoManager(this);
}

class VirtuesDaoManager {
  final _$VirtuesDaoMixin _db;
  VirtuesDaoManager(this._db);
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
}
