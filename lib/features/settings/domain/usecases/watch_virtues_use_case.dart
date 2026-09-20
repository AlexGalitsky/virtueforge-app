import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/repositories/catalog_repository.dart';

class WatchVirtuesUseCase {
  WatchVirtuesUseCase(this._catalog);

  final CatalogRepository _catalog;

  Stream<List<FranklinVirtue>> call() => _catalog.watchVirtues();
}
