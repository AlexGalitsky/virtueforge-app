import 'package:virtue_forge/features/journal/domain/repositories/catalog_repository.dart';

class SaveVirtueDescriptionUseCase {
  SaveVirtueDescriptionUseCase(this._catalog);

  final CatalogRepository _catalog;

  Future<void> call({
    required int id,
    required String? customDescription,
  }) {
    return _catalog.updateVirtueCustomDescription(
      id: id,
      customDescription: customDescription,
    );
  }
}
