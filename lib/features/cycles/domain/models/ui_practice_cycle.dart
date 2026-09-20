class UIPracticeCycle {
  const UIPracticeCycle({
    required this.id,
    required this.startedAt,
    required this.endedAt,
    required this.sequenceNumber,
    required this.cycleInYear,
    required this.isActive,
    this.successPercent,
    this.weakPillarId,
    this.totalStrikes,
    this.weekInCycle,
  });

  final int id;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int sequenceNumber;
  final int cycleInYear;
  final bool isActive;
  final int? successPercent;
  final int? weakPillarId;
  final int? totalStrikes;

  /// Только для активного: 1–13.
  final int? weekInCycle;
}
