import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/cycle_repository.dart';
import 'package:virtue_forge/features/journal/domain/repositories/catalog_repository.dart';
import 'package:virtue_forge/features/journal/domain/repositories/journal_repository.dart';
import 'package:virtue_forge/features/profile_progress/domain/models/ui_stoic_pillar.dart';
import 'package:virtue_forge/features/profile_progress/domain/models/xp_ledger_models.dart';
import 'package:virtue_forge/features/profile_progress/domain/repositories/xp_ledger_repository.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/sync_xp_ledger_use_case.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/watch_pillars_use_case.dart';

class PillarDetailSnapshot {
  const PillarDetailSnapshot({
    required this.pillar,
    required this.mottoKey,
    required this.weekStrikeCount,
    required this.virtueBars,
    required this.events,
  });

  final UIStoicPillar pillar;
  final String mottoKey;
  final int weekStrikeCount;
  final List<VirtueStrikeBar> virtueBars;
  final List<XpLedgerEvent> events;
}

class LoadPillarDetailUseCase {
  LoadPillarDetailUseCase({
    required WatchPillarsUseCase watchPillars,
    required CatalogRepository catalog,
    required JournalRepository journal,
    required CycleRepository cycles,
    required XpLedgerRepository ledger,
    required SyncXpLedgerUseCase syncLedger,
  })  : _watchPillars = watchPillars,
        _catalog = catalog,
        _journal = journal,
        _cycles = cycles,
        _ledger = ledger,
        _syncLedger = syncLedger;

  final WatchPillarsUseCase _watchPillars;
  final CatalogRepository _catalog;
  final JournalRepository _journal;
  final CycleRepository _cycles;
  final XpLedgerRepository _ledger;
  final SyncXpLedgerUseCase _syncLedger;

  Future<PillarDetailSnapshot?> call(int categoryId) async {
    await _syncLedger();

    final pillars = await _watchPillars().first;
    UIStoicPillar? pillar;
    for (final p in pillars) {
      if (p.id == categoryId) {
        pillar = p;
        break;
      }
    }
    if (pillar == null) return null;

    final virtues = await _catalog.watchVirtues().first;
    final categoryVirtues =
        virtues.where((v) => v.stoicCategoryId == categoryId).toList()
          ..sort((a, b) => a.defaultWeekNumber.compareTo(b.defaultWeekNumber));

    final active = await _cycles.getActiveCycle();
    final cycleStart = active?.startedAt ?? WeekDateUtils.startOfWeek(DateTime.now());
    final cycleEnd = active?.endedAt ??
        cycleStart.add(const Duration(days: 13 * 7));
    final logs = await _journal.getLogsInRange(cycleStart, cycleEnd);

    final strikesByVirtue = <int, int>{
      for (final v in categoryVirtues) v.id: 0,
    };
    var weekStrikes = 0;
    final currentWeek = WeekDateUtils.startOfWeek(DateTime.now());
    for (final log in logs) {
      if (!strikesByVirtue.containsKey(log.virtueId)) continue;
      strikesByVirtue[log.virtueId] =
          (strikesByVirtue[log.virtueId] ?? 0) + log.strikesCount;
      if (WeekDateUtils.startOfWeek(log.date) == currentWeek) {
        weekStrikes += log.strikesCount;
      }
    }

    final bars = [
      for (final v in categoryVirtues)
        VirtueStrikeBar(
          virtueId: v.id,
          nameKey: v.name,
          strikes: strikesByVirtue[v.id] ?? 0,
        ),
    ];

    final events = await _ledger.getCategoryEvents(categoryId);

    return PillarDetailSnapshot(
      pillar: pillar,
      mottoKey: pillar.nameKey,
      weekStrikeCount: weekStrikes,
      virtueBars: bars,
      events: events,
    );
  }
}
