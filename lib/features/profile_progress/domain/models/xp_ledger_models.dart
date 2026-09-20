/// Stable kind strings stored in [XpEvents.kind].
abstract final class XpEventKind {
  static const weekBase = 'weekBase';
  static const cleanDay = 'cleanDay';
  static const focusStrike = 'focusStrike';
  static const nonFocusStrike = 'nonFocusStrike';
  static const archetypeBonus = 'archetypeBonus';
  static const dust = 'dust';
}

class XpLedgerEvent {
  const XpLedgerEvent({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.kind,
    required this.eventDate,
    this.virtueId,
    this.weekStart,
  });

  final int id;
  final int categoryId;
  final int amount;
  final String kind;
  final DateTime eventDate;
  final int? virtueId;
  final DateTime? weekStart;
}

class VirtueStrikeBar {
  const VirtueStrikeBar({
    required this.virtueId,
    required this.nameKey,
    required this.strikes,
  });

  final int virtueId;
  final String nameKey;
  final int strikes;
}
