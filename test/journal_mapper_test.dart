import 'package:flutter_test/flutter_test.dart';
import 'package:virtue_forge/features/journal/domain/entities/daily_log_entry.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/entities/strike_note_entry.dart';
import 'package:virtue_forge/features/journal/domain/mappers/journal_mapper.dart';

void main() {
  test('JournalMapper fills weekly strikes by day index', () {
    final weekStart = DateTime(2026, 7, 20);
    final virtues = [
      const FranklinVirtue(
        id: 1,
        stoicCategoryId: 1,
        name: 'virtueAbstinence',
        description: 'virtueAbstinenceDesc',
        defaultWeekNumber: 1,
      ),
      const FranklinVirtue(
        id: 2,
        stoicCategoryId: 2,
        name: 'virtueSilence',
        description: 'virtueSilenceDesc',
        defaultWeekNumber: 2,
      ),
    ];

    final logs = [
      DailyLogEntry(
        id: 1,
        date: DateTime(2026, 7, 20),
        virtueId: 1,
        strikesCount: 2,
      ),
      DailyLogEntry(
        id: 2,
        date: DateTime(2026, 7, 22),
        virtueId: 1,
        strikesCount: 1,
      ),
    ];

    final ui = JournalMapper.toUiVirtues(
      virtues: virtues,
      weekLogs: logs,
      weekNotes: const [],
      weekStart: weekStart,
      focusWeekNumber: 1,
    );

    expect(ui.length, 2);
    expect(ui.first.isCurrentWeekFocus, isTrue);
    expect(ui.first.weeklyStrikes, [2, 0, 1, 0, 0, 0, 0]);
    expect(ui.first.weeklyNoteCounts, everyElement(0));
    expect(ui[1].isCurrentWeekFocus, isFalse);
    expect(ui[1].weeklyStrikes, everyElement(0));
  });

  test('JournalMapper counts per-strike notes by day', () {
    final weekStart = DateTime(2026, 7, 20);
    final virtues = [
      const FranklinVirtue(
        id: 1,
        stoicCategoryId: 1,
        name: 'virtueAbstinence',
        description: 'virtueAbstinenceDesc',
        defaultWeekNumber: 1,
      ),
    ];
    final notes = [
      StrikeNoteEntry(
        id: 1,
        date: DateTime(2026, 7, 21),
        virtueId: 1,
        ordinal: 1,
        body: 'first',
      ),
      StrikeNoteEntry(
        id: 2,
        date: DateTime(2026, 7, 21),
        virtueId: 1,
        ordinal: 2,
        body: 'second',
      ),
    ];

    final ui = JournalMapper.toUiVirtues(
      virtues: virtues,
      weekLogs: const [],
      weekNotes: notes,
      weekStart: weekStart,
      focusWeekNumber: 1,
    );

    expect(ui.first.weeklyNoteCounts[1], 2);
  });
}
