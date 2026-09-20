class DailyLogEntry {
  const DailyLogEntry({
    required this.id,
    required this.date,
    required this.virtueId,
    required this.strikesCount,
    this.noteControlled,
    this.noteUncontrolled,
    this.strikeNote,
  });

  final int id;
  final DateTime date;
  final int virtueId;
  final int strikesCount;
  final String? noteControlled;
  final String? noteUncontrolled;
  final String? strikeNote;
}
