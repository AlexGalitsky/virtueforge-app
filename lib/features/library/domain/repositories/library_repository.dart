import 'package:virtue_forge/features/library/domain/models/essay.dart';

abstract class LibraryRepository {
  Future<List<Essay>> loadEssays();

  Future<List<Essay>> essaysForWeek(int weekNumber, {int limit = 6});

  Future<Essay?> randomEssay({int? focusWeekNumber});

  Future<String> loadEssayBody(String essayId);

  Future<String> loadEssayAnalysis(String essayId);

  /// Best-effort: pull bodies into disk cache (API or bundled assets).
  Future<void> prewarmEssayBodies(Iterable<String> essayIds);
}
