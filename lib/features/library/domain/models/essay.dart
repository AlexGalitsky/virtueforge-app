import 'package:freezed_annotation/freezed_annotation.dart';

part 'essay.freezed.dart';

@freezed
abstract class Essay with _$Essay {
  const Essay._();

  const factory Essay({
    required String id,
    required String authorKey,
    required String title,
    required String snippet,
    @Default([]) List<int> virtueWeekNumbers,
    String? bodyPath,
    String? sourceWork,
    String? stoicCategory,
    @Default('ru') String locale,
    String? analysisPath,
    @Default(false) bool hasAnalysis,
  }) = _Essay;

  /// Primary Franklin week for UI chips (first tagged week, else 1).
  int get virtueWeekNumber =>
      virtueWeekNumbers.isEmpty ? 1 : virtueWeekNumbers.first;

  factory Essay.fromJson(Map<String, dynamic> json) {
    // Legacy assets/essays.json (titleKey / single week).
    if (json.containsKey('titleKey')) {
      final week = json['virtueWeekNumber'] as int? ?? 1;
      return Essay(
        id: json['id'] as String? ?? '',
        authorKey: json['authorKey'] as String? ?? '',
        title: json['titleKey'] as String? ?? '',
        snippet: json['snippetKey'] as String? ?? '',
        virtueWeekNumbers: [week],
      );
    }

    final weeksRaw = json['virtueWeekNumbers'];
    final weeks = <int>[];
    if (weeksRaw is List) {
      for (final item in weeksRaw) {
        final n = item is int ? item : int.tryParse('$item');
        if (n != null && n >= 1 && n <= 13) weeks.add(n);
      }
    }

    return Essay(
      id: json['id'] as String? ?? '',
      authorKey: json['authorKey'] as String? ?? '',
      title: json['title'] as String? ?? '',
      snippet: json['snippet'] as String? ?? '',
      bodyPath: json['bodyPath'] as String?,
      sourceWork: json['sourceWork'] as String?,
      stoicCategory: json['stoicCategory'] as String?,
      locale: json['locale'] as String? ?? 'ru',
      virtueWeekNumbers: weeks,
      analysisPath: json['analysisPath'] as String?,
      hasAnalysis: json['hasAnalysis'] as bool? ??
          ((json['analysisPath'] as String?)?.isNotEmpty ?? false),
    );
  }
}
