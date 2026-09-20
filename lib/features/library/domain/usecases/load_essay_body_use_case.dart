import 'package:virtue_forge/features/library/domain/repositories/library_repository.dart';

class LoadEssayBodyUseCase {
  LoadEssayBodyUseCase(this._library);

  final LibraryRepository _library;

  Future<String> call(String essayId) => _library.loadEssayBody(essayId);
}
