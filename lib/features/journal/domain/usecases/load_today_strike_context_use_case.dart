import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/repositories/catalog_repository.dart';
import 'package:virtue_forge/features/journal/domain/repositories/journal_repository.dart';
import 'package:virtue_forge/core/utils/week_date_utils.dart';

class TodayStrikeNoteItem {
  const TodayStrikeNoteItem({
    required this.ordinal,
    this.body,
  });

  final int ordinal;
  final String? body;
}

class TodayVirtueStrikeGroup {
  const TodayVirtueStrikeGroup({
    required this.virtue,
    required this.strikesCount,
    required this.notes,
  });

  final FranklinVirtue virtue;
  final int strikesCount;
  final List<TodayStrikeNoteItem> notes;
}

class TodayStrikeContext {
  const TodayStrikeContext({required this.groups});

  final List<TodayVirtueStrikeGroup> groups;

  bool get isEmpty => groups.isEmpty;
}

/// Today's slips across all virtues with per-strike notes for evening reflection.
class LoadTodayStrikeContextUseCase {
  LoadTodayStrikeContextUseCase({
    required JournalRepository journalRepository,
    required CatalogRepository catalogRepository,
  })  : _journal = journalRepository,
        _catalog = catalogRepository;

  final JournalRepository _journal;
  final CatalogRepository _catalog;

  Future<TodayStrikeContext> call({DateTime? now}) async {
    final day = WeekDateUtils.normalizeDate(now ?? DateTime.now());
    final next = day.add(const Duration(days: 1));
    final logs = await _journal.getLogsInRange(day, next);
    final virtues = await _catalog.watchVirtues().first;
    final virtuesById = {for (final v in virtues) v.id: v};

    final groups = <TodayVirtueStrikeGroup>[];

    for (final log in logs) {
      if (log.strikesCount <= 0) continue;
      final virtue = virtuesById[log.virtueId];
      if (virtue == null) continue;

      final notes = await _journal.getNotesForDay(
        date: day,
        virtueId: log.virtueId,
      );
      final byOrdinal = {for (final n in notes) n.ordinal: n};

      final items = <TodayStrikeNoteItem>[];
      for (var ordinal = 1; ordinal <= log.strikesCount; ordinal++) {
        final note = byOrdinal[ordinal];
        items.add(
          TodayStrikeNoteItem(
            ordinal: ordinal,
            body: note?.body,
          ),
        );
      }

      groups.add(
        TodayVirtueStrikeGroup(
          virtue: virtue,
          strikesCount: log.strikesCount,
          notes: items,
        ),
      );
    }

    groups.sort(
      (a, b) => a.virtue.defaultWeekNumber.compareTo(b.virtue.defaultWeekNumber),
    );

    return TodayStrikeContext(groups: groups);
  }
}
