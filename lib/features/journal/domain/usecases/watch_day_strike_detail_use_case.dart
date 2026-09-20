import 'package:virtue_forge/core/utils/stream_combine.dart';
import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/entities/strike_note_entry.dart';
import 'package:virtue_forge/features/journal/domain/repositories/catalog_repository.dart';
import 'package:virtue_forge/features/journal/domain/repositories/journal_repository.dart';

class DayStrikeDetailSnapshot {
  const DayStrikeDetailSnapshot({
    required this.virtue,
    required this.date,
    required this.strikesCount,
    required this.notes,
    required this.canEdit,
  });

  final FranklinVirtue virtue;
  final DateTime date;
  final int strikesCount;
  final List<StrikeNoteEntry> notes;
  final bool canEdit;
}

/// Стрим детализации дня×добродетели для экрана медитации над проступками.
class WatchDayStrikeDetailUseCase {
  WatchDayStrikeDetailUseCase({
    required CatalogRepository catalogRepository,
    required JournalRepository journalRepository,
  })  : _catalog = catalogRepository,
        _journal = journalRepository;

  final CatalogRepository _catalog;
  final JournalRepository _journal;

  Stream<DayStrikeDetailSnapshot> call({
    required int virtueId,
    required DateTime date,
  }) {
    final normalized = WeekDateUtils.normalizeDate(date);
    final today = WeekDateUtils.normalizeDate(DateTime.now());
    final canEdit = !normalized.isAfter(today);

    return combineLatest3(
      _catalog.watchVirtues(),
      _journal.watchLogForDay(date: normalized, virtueId: virtueId),
      _journal.watchNotesForDay(date: normalized, virtueId: virtueId),
    ).map((tuple) {
      final (virtues, log, notes) = tuple;
      final virtue = virtues.firstWhere(
        (v) => v.id == virtueId,
        orElse: () => throw StateError('Virtue $virtueId not found'),
      );
      return DayStrikeDetailSnapshot(
        virtue: virtue,
        date: normalized,
        strikesCount: log?.strikesCount ?? 0,
        notes: notes,
        canEdit: canEdit,
      );
    });
  }
}
