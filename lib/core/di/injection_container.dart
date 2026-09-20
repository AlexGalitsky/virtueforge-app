import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtue_forge/core/database/app_database.dart';
import 'package:virtue_forge/core/database/daos/audiences_dao.dart';
import 'package:virtue_forge/core/database/daos/cycles_dao.dart';
import 'package:virtue_forge/core/database/daos/journal_dao.dart';
import 'package:virtue_forge/core/database/daos/virtues_dao.dart';
import 'package:virtue_forge/features/cycles/data/repositories/cycle_repository_impl.dart';
import 'package:virtue_forge/features/cycles/data/repositories/focus_shift_repository_impl.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/cycle_repository.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/focus_shift_repository.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/build_cycle_summary_use_case.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/ensure_cycle_advanced_use_case.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/load_cycle_detail_use_case.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/set_focus_virtue_use_case.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/start_first_cycle_use_case.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/watch_current_focus_use_case.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/watch_cycle_archive_use_case.dart';
import 'package:virtue_forge/features/cycles/presentation/cubit/cycle_archive_cubit.dart';
import 'package:virtue_forge/features/cycles/presentation/cubit/cycle_detail_cubit.dart';
import 'package:virtue_forge/features/cycles/presentation/cubit/focus_selection_cubit.dart';
import 'package:virtue_forge/features/journal/data/repositories/catalog_repository_impl.dart';
import 'package:virtue_forge/features/journal/data/repositories/journal_repository_impl.dart';
import 'package:virtue_forge/features/journal/domain/repositories/catalog_repository.dart';
import 'package:virtue_forge/features/journal/domain/repositories/journal_repository.dart';
import 'package:virtue_forge/features/journal/domain/usecases/delete_strike_note_use_case.dart';
import 'package:virtue_forge/features/journal/domain/usecases/load_today_strike_context_use_case.dart';
import 'package:virtue_forge/features/journal/domain/usecases/save_reflection_use_case.dart';
import 'package:virtue_forge/features/journal/domain/usecases/save_strike_note_use_case.dart';
import 'package:virtue_forge/features/journal/domain/usecases/update_strike_use_case.dart';
import 'package:virtue_forge/features/journal/domain/usecases/watch_day_strike_detail_use_case.dart';
import 'package:virtue_forge/features/journal/domain/usecases/watch_journal_week_use_case.dart';
import 'package:virtue_forge/features/journal/presentation/bloc/day_strike_detail_bloc.dart';
import 'package:virtue_forge/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:virtue_forge/features/library/data/essay_reader_preferences.dart';
import 'package:virtue_forge/features/library/data/repositories/library_repository_impl.dart';
import 'package:virtue_forge/features/library/data/repositories/quotes_repository_impl.dart';
import 'package:virtue_forge/features/library/domain/repositories/library_repository.dart';
import 'package:virtue_forge/features/library/domain/repositories/quotes_repository.dart';
import 'package:virtue_forge/features/library/domain/usecases/get_quote_of_day_use_case.dart';
import 'package:virtue_forge/features/library/domain/usecases/load_essay_analysis_use_case.dart';
import 'package:virtue_forge/features/library/domain/usecases/load_essay_body_use_case.dart';
import 'package:virtue_forge/features/library/domain/usecases/load_portico_content_use_case.dart';
import 'package:virtue_forge/features/library/domain/usecases/load_random_thought_use_case.dart';
import 'package:virtue_forge/features/library/presentation/bloc/portico_bloc.dart';
import 'package:virtue_forge/features/mentor/data/audience_repository_impl.dart';
import 'package:virtue_forge/features/mentor/data/isolated_mentor_engine.dart';
import 'package:virtue_forge/features/mentor/data/mentor_model_store_impl.dart';
import 'package:virtue_forge/features/mentor/data/mentor_preferences.dart';
import 'package:virtue_forge/features/mentor/domain/repositories/mentor_repositories.dart';
import 'package:virtue_forge/features/mentor/domain/services/local_mentor_engine.dart';
import 'package:virtue_forge/features/onboarding/data/onboarding_repository.dart';
import 'package:virtue_forge/features/onboarding/data/tutorial_repository.dart';
import 'package:virtue_forge/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';
import 'package:virtue_forge/core/database/daos/xp_events_dao.dart';
import 'package:virtue_forge/features/profile_progress/data/pillar_coach_repository.dart';
import 'package:virtue_forge/features/profile_progress/data/pillar_level_floor_repository.dart';
import 'package:virtue_forge/features/profile_progress/data/temple_dust_repository.dart';
import 'package:virtue_forge/features/profile_progress/data/xp_ledger_repository_impl.dart';
import 'package:virtue_forge/features/profile_progress/domain/repositories/xp_ledger_repository.dart';
import 'package:virtue_forge/features/profile_progress/domain/services/progress_calculator.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/apply_temple_dust_use_case.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/calculate_week_xp_use_case.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/load_pillar_detail_use_case.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/sync_xp_ledger_use_case.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/watch_pillars_use_case.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/watch_temple_dashboard_use_case.dart';
import 'package:virtue_forge/features/profile_progress/presentation/bloc/temple_bloc.dart';
import 'package:virtue_forge/features/settings/data/notification_scheduler.dart';
import 'package:virtue_forge/features/settings/data/settings_repository_impl.dart';
import 'package:virtue_forge/features/settings/domain/repositories/reminder_notifications.dart';
import 'package:virtue_forge/features/settings/domain/repositories/settings_repository.dart';
import 'package:virtue_forge/features/settings/domain/usecases/save_virtue_description_use_case.dart';
import 'package:virtue_forge/features/settings/domain/usecases/settings_use_cases.dart';
import 'package:virtue_forge/features/settings/domain/usecases/watch_virtues_use_case.dart';
import 'package:virtue_forge/features/settings/presentation/bloc/virtue_editor_bloc.dart';
import 'package:virtue_forge/features/settings/presentation/cubit/settings_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  // --- Repositories / infra (singletons) ---
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<TutorialRepository>(
    () => TutorialRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<NotificationScheduler>(NotificationScheduler.new);
  sl.registerLazySingleton<ReminderNotifications>(
    () => sl<NotificationScheduler>(),
  );

  sl.registerLazySingleton<AppDatabase>(AppDatabase.new);
  sl.registerLazySingleton<JournalDao>(() => sl<AppDatabase>().journalDao);
  sl.registerLazySingleton<VirtuesDao>(() => sl<AppDatabase>().virtuesDao);
  sl.registerLazySingleton<CyclesDao>(() => sl<AppDatabase>().cyclesDao);

  sl.registerLazySingleton<JournalRepository>(
    () => JournalRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<CatalogRepository>(
    () => CatalogRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<LibraryRepository>(
    () => LibraryRepositoryImpl(prefs: sl()),
  );
  sl.registerLazySingleton<QuotesRepository>(
    () => QuotesRepositoryImpl(prefs: sl()),
  );
  sl.registerLazySingleton<CycleRepository>(
    () => CycleRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<FocusShiftRepository>(
    () => FocusShiftRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ProgressCalculator>(ProgressCalculator.new);
  sl.registerLazySingleton(() => CalculateWeekXpUseCase(sl()));
  sl.registerLazySingleton<XpEventsDao>(() => sl<AppDatabase>().xpEventsDao);
  sl.registerLazySingleton<XpLedgerRepository>(
    () => XpLedgerRepositoryImpl(
      dao: sl(),
      journal: sl(),
      catalog: sl(),
      cycles: sl(),
      focusShift: sl(),
      floors: sl(),
    ),
  );
  sl.registerLazySingleton<PillarLevelFloorRepository>(
    () => PillarLevelFloorRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<PillarCoachRepository>(
    () => PillarCoachRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<TempleDustRepository>(
    () => TempleDustRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(
    () => ApplyTempleDustUseCase(
      dustRepository: sl(),
      ledger: sl(),
      catalog: sl(),
    ),
  );

  // --- Use cases ---
  sl.registerLazySingleton(() => StartFirstCycleUseCase(sl()));
  sl.registerLazySingleton(
    () => BuildCycleSummaryUseCase(
      journalRepository: sl(),
      catalogRepository: sl(),
      focusShiftRepository: sl(),
      calculateWeekXp: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => LoadCycleDetailUseCase(
      cycleRepository: sl(),
      journalRepository: sl(),
      catalogRepository: sl(),
      focusShiftRepository: sl(),
      calculateWeekXp: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => EnsureCycleAdvancedUseCase(
      cycleRepository: sl(),
      buildSummary: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => WatchCycleArchiveUseCase(
      ensureCycleAdvanced: sl(),
      cycleRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SetFocusVirtueUseCase(
      focusShiftRepository: sl(),
      journalRepository: sl(),
      catalogRepository: sl(),
      calculateWeekXp: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => WatchCurrentFocusUseCase(
      cycleRepository: sl(),
      focusShiftRepository: sl(),
      catalogRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => CompleteOnboardingUseCase(
      startFirstCycle: sl(),
      onboardingRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => WatchJournalWeekUseCase(
      ensureCycleAdvanced: sl(),
      startFirstCycle: sl(),
      cycleRepository: sl(),
      focusShiftRepository: sl(),
      catalogRepository: sl(),
      journalRepository: sl(),
    ),
  );
  sl.registerLazySingleton(() => UpdateStrikeUseCase(sl(), sl()));
  sl.registerLazySingleton(() => SyncXpLedgerUseCase(sl()));
  sl.registerLazySingleton(
    () => LoadPillarDetailUseCase(
      watchPillars: sl(),
      catalog: sl(),
      journal: sl(),
      cycles: sl(),
      ledger: sl(),
      syncLedger: sl(),
    ),
  );
  sl.registerLazySingleton(() => SaveReflectionUseCase(sl()));
  sl.registerLazySingleton(() => SaveStrikeNoteUseCase(sl()));
  sl.registerLazySingleton(() => DeleteStrikeNoteUseCase(sl()));
  sl.registerLazySingleton(
    () => LoadTodayStrikeContextUseCase(
      journalRepository: sl(),
      catalogRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => WatchDayStrikeDetailUseCase(
      catalogRepository: sl(),
      journalRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => WatchPillarsUseCase(
      catalogRepository: sl(),
      journalRepository: sl(),
      cycleRepository: sl(),
      focusShiftRepository: sl(),
      calculateWeekXp: sl(),
      calculator: sl(),
      levelFloorRepository: sl(),
      xpLedgerRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => WatchTempleDashboardUseCase(
      ensureCycleAdvanced: sl(),
      watchPillars: sl(),
      cycleRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => LoadPorticoContentUseCase(
      ensureCycleAdvanced: sl(),
      cycleRepository: sl(),
      focusShiftRepository: sl(),
      libraryRepository: sl(),
    ),
  );
  sl.registerLazySingleton(() => LoadRandomThoughtUseCase(sl()));
  sl.registerLazySingleton(() => LoadEssayBodyUseCase(sl()));
  sl.registerLazySingleton(() => LoadEssayAnalysisUseCase(sl()));
  sl.registerLazySingleton(() => EssayReaderPreferences(sl()));
  sl.registerLazySingleton(() => MentorPreferences(sl()));
  sl.registerLazySingleton<AudiencesDao>(() => sl<AppDatabase>().audiencesDao);
  sl.registerLazySingleton<AudienceRepository>(
    () => AudienceRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<MentorModelStore>(
    () => MentorModelStoreImpl(sl()),
  );
  sl.registerLazySingleton<LocalMentorEngine>(IsolatedMentorEngine.new);
  await sl<MentorModelStore>().seedAutoDeviceTier();
  sl.registerLazySingleton(() => GetQuoteOfDayUseCase(sl()));
  sl.registerLazySingleton(() => WatchVirtuesUseCase(sl()));
  sl.registerLazySingleton(() => SaveVirtueDescriptionUseCase(sl()));
  sl.registerLazySingleton(() => PersistSettingsUseCase(sl()));
  sl.registerLazySingleton(() => SyncReminderUseCase(sl()));
  sl.registerLazySingleton(
    () => SetReminderEnabledUseCase(
      repository: sl(),
      notifications: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SetReminderTimeUseCase(
      repository: sl(),
      notifications: sl(),
    ),
  );

  // --- Presentation factories (never singleton) ---
  sl.registerFactory(
    () => SettingsCubit(
      repository: sl(),
      persistSettings: sl(),
      syncReminder: sl(),
      setReminderEnabled: sl(),
      setReminderTime: sl(),
    ),
  );
  sl.registerFactory(
    () => JournalBloc(
      watchJournalWeek: sl(),
      updateStrike: sl(),
      saveReflection: sl(),
    ),
  );
  sl.registerFactory(
    () => DayStrikeDetailBloc(
      watchDayStrikeDetail: sl(),
      updateStrike: sl(),
      saveStrikeNote: sl(),
      deleteStrikeNote: sl(),
    ),
  );
  sl.registerFactory(() => TempleBloc(watchTempleDashboard: sl()));
  sl.registerFactory(
    () => PorticoBloc(
      loadPorticoContent: sl(),
      loadRandomThought: sl(),
    ),
  );
  sl.registerFactory(
    () => VirtueEditorBloc(
      watchVirtues: sl(),
      saveVirtueDescription: sl(),
    ),
  );
  sl.registerFactory(() => CycleArchiveCubit(watchCycleArchive: sl()));
  sl.registerFactory(() => CycleDetailCubit(sl()));
  sl.registerFactory(
    () => FocusSelectionCubit(
      catalogRepository: sl(),
      watchCurrentFocus: sl(),
      setFocusVirtue: sl(),
    ),
  );
}
