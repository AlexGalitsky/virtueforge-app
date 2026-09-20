// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycles_dao.dart';

// ignore_for_file: type=lint
mixin _$CyclesDaoMixin on DatabaseAccessor<AppDatabase> {
  $PracticeCyclesTable get practiceCycles => attachedDatabase.practiceCycles;
  CyclesDaoManager get managers => CyclesDaoManager(this);
}

class CyclesDaoManager {
  final _$CyclesDaoMixin _db;
  CyclesDaoManager(this._db);
  $$PracticeCyclesTableTableManager get practiceCycles =>
      $$PracticeCyclesTableTableManager(
        _db.attachedDatabase,
        _db.practiceCycles,
      );
}
