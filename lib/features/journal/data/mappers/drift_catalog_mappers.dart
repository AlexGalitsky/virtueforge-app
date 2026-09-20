import 'package:virtue_forge/core/database/app_database.dart' as db;
import 'package:virtue_forge/features/journal/domain/entities/daily_log_entry.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/entities/stoic_category.dart';
import 'package:virtue_forge/features/journal/domain/entities/strike_note_entry.dart';

abstract final class CatalogDriftMapper {
  static FranklinVirtue toVirtue(db.FranklinVirtue row) {
    return FranklinVirtue(
      id: row.id,
      stoicCategoryId: row.stoicCategoryId,
      name: row.name,
      description: row.description,
      customDescription: row.customDescription,
      defaultWeekNumber: row.defaultWeekNumber,
    );
  }

  static StoicCategory toCategory(db.StoicCategory row) {
    return StoicCategory(
      id: row.id,
      name: row.name,
      description: row.description,
      iconPath: row.iconPath,
    );
  }

  static List<FranklinVirtue> toVirtues(List<db.FranklinVirtue> rows) =>
      rows.map(toVirtue).toList();

  static List<StoicCategory> toCategories(List<db.StoicCategory> rows) =>
      rows.map(toCategory).toList();
}

abstract final class DailyLogDriftMapper {
  static DailyLogEntry toEntry(db.DailyLog row) {
    return DailyLogEntry(
      id: row.id,
      date: row.date,
      virtueId: row.virtueId,
      strikesCount: row.strikesCount,
      noteControlled: row.noteControlled,
      noteUncontrolled: row.noteUncontrolled,
      strikeNote: row.strikeNote,
    );
  }

  static List<DailyLogEntry> toEntries(List<db.DailyLog> rows) =>
      rows.map(toEntry).toList();

  static StrikeNoteEntry toStrikeNote(db.StrikeNote row) {
    return StrikeNoteEntry(
      id: row.id,
      date: row.date,
      virtueId: row.virtueId,
      ordinal: row.ordinal,
      body: row.body,
    );
  }

  static List<StrikeNoteEntry> toStrikeNotes(List<db.StrikeNote> rows) =>
      rows.map(toStrikeNote).toList();
}
