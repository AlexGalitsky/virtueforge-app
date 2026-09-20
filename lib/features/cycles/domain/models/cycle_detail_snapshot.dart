import 'package:virtue_forge/features/cycles/domain/models/ui_practice_cycle.dart';

class CycleDetailSnapshot {
  const CycleDetailSnapshot({
    required this.cycle,
    required this.rangeEnd,
    required this.successPercent,
    required this.totalStrikes,
    required this.weakPillarId,
    required this.virtueBars,
    required this.pillarBars,
    required this.weekPoints,
    this.compare,
  });

  final UIPracticeCycle cycle;
  final DateTime rangeEnd;
  final int successPercent;
  final int totalStrikes;
  final int? weakPillarId;
  final List<CycleVirtueBar> virtueBars;
  final List<CyclePillarBar> pillarBars;
  final List<CycleWeekPoint> weekPoints;
  final CycleCompareSnapshot? compare;
}

class CycleCompareSnapshot {
  const CycleCompareSnapshot({
    required this.previous,
    required this.successDelta,
    required this.strikesDelta,
    required this.previousWeakPillarId,
  });

  final UIPracticeCycle previous;
  final int successDelta;
  final int strikesDelta;
  final int? previousWeakPillarId;
}

class CycleVirtueBar {
  const CycleVirtueBar({
    required this.virtueId,
    required this.nameKey,
    required this.strikes,
  });

  final int virtueId;
  final String nameKey;
  final int strikes;
}

class CyclePillarBar {
  const CyclePillarBar({
    required this.categoryId,
    required this.nameKey,
    required this.strikes,
    required this.avgWeekXp,
    required this.weekCount,
  });

  final int categoryId;
  final String nameKey;
  final int strikes;
  final int avgWeekXp;
  final int weekCount;
}

class CycleWeekPoint {
  const CycleWeekPoint({
    required this.weekIndex,
    required this.weekStart,
    required this.strikes,
    required this.cleanDays,
    required this.weekXp,
    required this.focusWeekNumber,
  });

  /// 0-based week within the cycle (0..12).
  final int weekIndex;
  final DateTime weekStart;
  final int strikes;
  final int cleanDays;
  final int weekXp;
  final int focusWeekNumber;
}
