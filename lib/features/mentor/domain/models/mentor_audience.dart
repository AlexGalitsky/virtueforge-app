class MentorAudience {
  const MentorAudience({
    required this.id,
    required this.createdAt,
    required this.virtueWeekNumber,
    required this.virtueLabel,
    required this.misdeedSummary,
    required this.note,
    required this.userReflection,
    required this.aiResponse,
    required this.modelId,
    required this.interrupted,
  });

  final String id;
  final DateTime createdAt;
  final int virtueWeekNumber;
  final String virtueLabel;
  final String misdeedSummary;
  final String note;
  final String userReflection;
  final String aiResponse;
  final String modelId;
  final bool interrupted;
}
