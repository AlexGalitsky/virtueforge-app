import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/entities/stoic_category.dart';

abstract class CatalogRepository {
  Stream<List<FranklinVirtue>> watchVirtues();

  Stream<List<StoicCategory>> watchCategories();

  Future<void> updateVirtueCustomDescription({
    required int id,
    required String? customDescription,
  });
}
