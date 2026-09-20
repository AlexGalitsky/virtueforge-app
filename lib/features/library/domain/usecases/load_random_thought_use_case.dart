import 'package:virtue_forge/features/library/domain/models/essay.dart';
import 'package:virtue_forge/features/library/domain/repositories/library_repository.dart';

class LoadRandomThoughtUseCase {
  LoadRandomThoughtUseCase(this._library);

  final LibraryRepository _library;

  Future<Essay?> call({int? focusWeekNumber}) =>
      _library.randomEssay(focusWeekNumber: focusWeekNumber);
}
