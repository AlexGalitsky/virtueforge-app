import 'package:drift/drift.dart';
import 'package:virtue_forge/core/database/daos/audiences_dao.dart';
import 'package:virtue_forge/core/database/daos/cycles_dao.dart';
import 'package:virtue_forge/core/database/daos/journal_dao.dart';
import 'package:virtue_forge/core/database/daos/virtues_dao.dart';
import 'package:virtue_forge/core/database/daos/xp_events_dao.dart';
import 'package:virtue_forge/core/database/tables/daily_logs.dart';
import 'package:virtue_forge/core/database/tables/franklin_virtues.dart';
import 'package:virtue_forge/core/database/tables/practice_cycles.dart';
import 'package:virtue_forge/core/database/tables/stoic_audiences.dart';
import 'package:virtue_forge/core/database/tables/stoic_categories.dart';
import 'package:virtue_forge/core/database/tables/strike_notes.dart';
import 'package:virtue_forge/core/database/tables/xp_events.dart';
import 'connection/connection.dart' as impl;

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    StoicCategories,
    FranklinVirtues,
    DailyLogs,
    PracticeCycles,
    StrikeNotes,
    XpEvents,
    StoicAudiences,
  ],
  daos: [
    JournalDao,
    VirtuesDao,
    CyclesDao,
    XpEventsDao,
    AudiencesDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect('my_app_db'));

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await transaction(() async {
          await _seedStaticData();
        });
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Additive-only upgrades. Never wipe user data here.
        // If a future migration cannot be applied safely, fail loudly rather
        // than deleting the database.
        await transaction(() async {
          if (from < 2) {
            await m.createTable(practiceCycles);
          }
          if (from < 3) {
            await m.addColumn(dailyLogs, dailyLogs.strikeNote);
          }
          if (from < 4) {
            await m.createTable(strikeNotes);
          }
          if (from < 5) {
            await m.createTable(xpEvents);
          }
          if (from < 6) {
            await m.createTable(stoicAudiences);
          }
        });
      },
    );
  }

  /// В БД хранятся ключи локализации (`stoicTemperance`, `virtueAbstinence`…).
  /// Отображаемый текст: `context.l10n.resolveCatalogKey(row.name)`.
  Future<void> _seedStaticData() async {
    final int temperanceId = await into(stoicCategories).insert(
      StoicCategoriesCompanion.insert(
        id: const Value(1),
        name: 'stoicTemperance',
        description: 'stoicTemperanceDesc',
        iconPath: const Value('assets/icons/temperance.svg'),
      ),
    );

    final int wisdomId = await into(stoicCategories).insert(
      StoicCategoriesCompanion.insert(
        id: const Value(2),
        name: 'stoicWisdom',
        description: 'stoicWisdomDesc',
        iconPath: const Value('assets/icons/wisdom.svg'),
      ),
    );

    final int courageId = await into(stoicCategories).insert(
      StoicCategoriesCompanion.insert(
        id: const Value(3),
        name: 'stoicCourage',
        description: 'stoicCourageDesc',
        iconPath: const Value('assets/icons/courage.svg'),
      ),
    );

    final int justiceId = await into(stoicCategories).insert(
      StoicCategoriesCompanion.insert(
        id: const Value(4),
        name: 'stoicJustice',
        description: 'stoicJusticeDesc',
        iconPath: const Value('assets/icons/justice.svg'),
      ),
    );

    final List<FranklinVirtuesCompanion> virtues = [
      FranklinVirtuesCompanion.insert(
        name: 'virtueAbstinence',
        description: 'virtueAbstinenceDesc',
        defaultWeekNumber: 1,
        stoicCategoryId: temperanceId,
      ),
      FranklinVirtuesCompanion.insert(
        name: 'virtueModeration',
        description: 'virtueModerationDesc',
        defaultWeekNumber: 9,
        stoicCategoryId: temperanceId,
      ),
      FranklinVirtuesCompanion.insert(
        name: 'virtueCleanliness',
        description: 'virtueCleanlinessDesc',
        defaultWeekNumber: 10,
        stoicCategoryId: temperanceId,
      ),
      FranklinVirtuesCompanion.insert(
        name: 'virtueChastity',
        description: 'virtueChastityDesc',
        defaultWeekNumber: 12,
        stoicCategoryId: temperanceId,
      ),
      FranklinVirtuesCompanion.insert(
        name: 'virtueSilence',
        description: 'virtueSilenceDesc',
        defaultWeekNumber: 2,
        stoicCategoryId: wisdomId,
      ),
      FranklinVirtuesCompanion.insert(
        name: 'virtueOrder',
        description: 'virtueOrderDesc',
        defaultWeekNumber: 3,
        stoicCategoryId: wisdomId,
      ),
      FranklinVirtuesCompanion.insert(
        name: 'virtueTranquility',
        description: 'virtueTranquilityDesc',
        defaultWeekNumber: 11,
        stoicCategoryId: wisdomId,
      ),
      FranklinVirtuesCompanion.insert(
        name: 'virtueResolution',
        description: 'virtueResolutionDesc',
        defaultWeekNumber: 4,
        stoicCategoryId: courageId,
      ),
      FranklinVirtuesCompanion.insert(
        name: 'virtueIndustry',
        description: 'virtueIndustryDesc',
        defaultWeekNumber: 6,
        stoicCategoryId: courageId,
      ),
      FranklinVirtuesCompanion.insert(
        name: 'virtueFrugality',
        description: 'virtueFrugalityDesc',
        defaultWeekNumber: 5,
        stoicCategoryId: justiceId,
      ),
      FranklinVirtuesCompanion.insert(
        name: 'virtueSincerity',
        description: 'virtueSincerityDesc',
        defaultWeekNumber: 7,
        stoicCategoryId: justiceId,
      ),
      FranklinVirtuesCompanion.insert(
        name: 'virtueJustice',
        description: 'virtueJusticeDesc',
        defaultWeekNumber: 8,
        stoicCategoryId: justiceId,
      ),
      FranklinVirtuesCompanion.insert(
        name: 'virtueHumility',
        description: 'virtueHumilityDesc',
        defaultWeekNumber: 13,
        stoicCategoryId: justiceId,
      ),
    ];

    await batch((batch) {
      batch.insertAll(franklinVirtues, virtues);
    });
  }
}
