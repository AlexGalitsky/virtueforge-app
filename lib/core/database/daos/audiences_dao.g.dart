// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audiences_dao.dart';

// ignore_for_file: type=lint
mixin _$AudiencesDaoMixin on DatabaseAccessor<AppDatabase> {
  $StoicAudiencesTable get stoicAudiences => attachedDatabase.stoicAudiences;
  AudiencesDaoManager get managers => AudiencesDaoManager(this);
}

class AudiencesDaoManager {
  final _$AudiencesDaoMixin _db;
  AudiencesDaoManager(this._db);
  $$StoicAudiencesTableTableManager get stoicAudiences =>
      $$StoicAudiencesTableTableManager(
        _db.attachedDatabase,
        _db.stoicAudiences,
      );
}
