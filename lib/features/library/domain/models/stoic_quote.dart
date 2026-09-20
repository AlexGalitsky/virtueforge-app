class StoicQuote {
  const StoicQuote({
    required this.id,
    required this.text,
    required this.author,
    required this.virtueWeekNumbers,
    this.stoicCategory,
  });

  final String id;
  final String text;
  final String author;
  final List<int> virtueWeekNumbers;
  final String? stoicCategory;

  factory StoicQuote.fromJson(Map<String, dynamic> json) {
    final weeksRaw = json['virtueWeekNumbers'];
    final weeks = <int>[];
    if (weeksRaw is List) {
      for (final item in weeksRaw) {
        final n = item is int ? item : int.tryParse('$item');
        if (n != null && n >= 1 && n <= 13) weeks.add(n);
      }
    }
    final category = json['stoicCategory'];
    return StoicQuote(
      id: json['id'] as String? ?? '',
      text: json['text'] as String? ?? '',
      author: json['author'] as String? ?? '',
      virtueWeekNumbers: weeks,
      stoicCategory: category is String ? category : null,
    );
  }

  bool get hasText => text.trim().isNotEmpty;
}
