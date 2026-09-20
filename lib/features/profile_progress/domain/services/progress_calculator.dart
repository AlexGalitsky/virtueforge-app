import 'dart:math';

/// Input strikes for one Franklin week (focus category scope + clean days).
class WeekStrikesData {
  WeekStrikesData({
    required this.focusVirtueStrikes,
    required this.nonFocusVirtuesStrikes,
    this.cleanDays = 0,
  });

  final int focusVirtueStrikes;
  final int nonFocusVirtuesStrikes;

  /// Days in the week with zero strikes across the whole grid (0–7).
  final int cleanDays;
}

/// Lifetime pillar level derived from total XP.
class PillarProgressState {
  PillarProgressState({
    required this.level,
    required this.currentLevelXp,
    required this.nextLevelXp,
    required this.progress,
  });

  final int level;
  final int currentLevelXp;
  final int nextLevelXp;
  final double progress;
}

class ProgressCalculator {
  /// Base XP for an ideal week in the focus category (before clean-day bonuses).
  static const int baseMaxWeeklyXp = 150;
  static const int cleanDayBonus = 10;
  static const int focusStrikePenalty = 10;
  static const int nonFocusStrikePenalty = 3;

  /// XP required to go from [level] → level+1.
  static int xpRequiredForLevel(int level) {
    if (level < 1) return xpRequiredForLevel(1);
    if (level <= 10) return 100 * level;
    if (level <= 20) return 1000 + (level - 10) * 50;
    return 1500;
  }

  /// Weekly XP for the focus category. May be negative (honest bad weeks).
  int calculateWeeklyXp(WeekStrikesData strikes) {
    final clean =
        strikes.cleanDays.clamp(0, 7) * cleanDayBonus;
    final penalty =
        (strikes.focusVirtueStrikes * focusStrikePenalty) +
        (strikes.nonFocusVirtuesStrikes * nonFocusStrikePenalty);
    return baseMaxWeeklyXp + clean - penalty;
  }

  /// 0–1 integrity for Temple cracks (negative weeks → destroyed).
  double weekIntegrity(int weekXp) {
    return (weekXp / baseMaxWeeklyXp).clamp(0.0, 1.0);
  }

  /// Converts lifetime total XP into level / bar fill.
  PillarProgressState calculatePillarState(int totalXp) {
    var remainingXp = max(0, totalXp);
    var currentLevel = 1;

    while (true) {
      final needed = xpRequiredForLevel(currentLevel);
      if (remainingXp >= needed) {
        remainingXp -= needed;
        currentLevel++;
      } else {
        break;
      }
    }

    final xpRequiredForNext = xpRequiredForLevel(currentLevel);
    final progressPercent =
        xpRequiredForNext == 0 ? 0.0 : remainingXp / xpRequiredForNext;

    return PillarProgressState(
      level: currentLevel,
      currentLevelXp: remainingXp,
      nextLevelXp: xpRequiredForNext,
      progress: progressPercent,
    );
  }

  /// Apply level floor: never demote below [floorLevel]; bar stays at 0 if floored.
  PillarProgressState applyLevelFloor(
    PillarProgressState computed, {
    required int floorLevel,
  }) {
    final floor = max(1, floorLevel);
    if (computed.level >= floor) return computed;
    final next = xpRequiredForLevel(floor);
    return PillarProgressState(
      level: floor,
      currentLevelXp: 0,
      nextLevelXp: next,
      progress: 0,
    );
  }
}
