import 'package:virtue_forge/core/database/daos/virtues_dao.dart';
import 'package:virtue_forge/features/journal/data/mappers/drift_catalog_mappers.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/entities/stoic_category.dart';
import 'package:virtue_forge/features/journal/domain/repositories/catalog_repository.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl(this._virtuesDao);

  final VirtuesDao _virtuesDao;

  @override
  Stream<List<FranklinVirtue>> watchVirtues() {
    return _virtuesDao.watchAllVirtues().map(CatalogDriftMapper.toVirtues);
  }

  @override
  Stream<List<StoicCategory>> watchCategories() {
    return _virtuesDao.watchAllCategories().map(CatalogDriftMapper.toCategories);
  }

  @override
  Future<void> updateVirtueCustomDescription({
    required int id,
    required String? customDescription,
  }) {
    return _virtuesDao.updateCustomDescription(id, customDescription);
  }
}
