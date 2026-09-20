class StrikeNoteEntry {
  const StrikeNoteEntry({
    required this.id,
    required this.date,
    required this.virtueId,
    required this.ordinal,
    required this.body,
  });

  final int id;
  final DateTime date;
  final int virtueId;

  /// 1-based index among that day's strikes for the virtue.
  final int ordinal;
  final String body;
}
