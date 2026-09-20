import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:virtue_forge/core/di/injection_container.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/cycle_repository.dart';
import 'package:virtue_forge/features/cycles/presentation/cubit/cycle_archive_cubit.dart';
import 'package:virtue_forge/features/cycles/presentation/cubit/focus_selection_cubit.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/watch_current_focus_use_case.dart';
import 'package:virtue_forge/features/journal/domain/usecases/load_today_strike_context_use_case.dart';
import 'package:virtue_forge/features/journal/presentation/bloc/day_strike_detail_bloc.dart';
import 'package:virtue_forge/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:virtue_forge/features/journal/presentation/pages/day_strike_reflection_page.dart';
import 'package:virtue_forge/features/journal/presentation/pages/franklin_journal_page.dart';
import 'package:virtue_forge/features/journal/presentation/pages/virtues_selection_page.dart';
import 'package:virtue_forge/features/library/data/essay_reader_preferences.dart';
import 'package:virtue_forge/features/library/domain/usecases/get_quote_of_day_use_case.dart';
import 'package:virtue_forge/features/library/presentation/bloc/portico_bloc.dart';
import 'package:virtue_forge/features/library/presentation/pages/portico_page.dart';
import 'package:virtue_forge/features/onboarding/data/onboarding_repository.dart';
import 'package:virtue_forge/features/onboarding/data/tutorial_repository.dart';
import 'package:virtue_forge/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';
import 'package:virtue_forge/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:virtue_forge/features/onboarding/presentation/pages/tutorial_page.dart';
import 'package:virtue_forge/features/profile_progress/data/pillar_coach_repository.dart';
import 'package:virtue_forge/features/profile_progress/data/pillar_level_floor_repository.dart';
import 'package:virtue_forge/features/profile_progress/data/temple_dust_repository.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/apply_temple_dust_use_case.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/sync_xp_ledger_use_case.dart';
import 'package:virtue_forge/features/profile_progress/presentation/bloc/temple_bloc.dart';
import 'package:virtue_forge/features/profile_progress/presentation/pages/temple_page.dart';
import 'package:virtue_forge/features/settings/presentation/bloc/virtue_editor_bloc.dart';
import 'package:virtue_forge/features/settings/presentation/pages/birth_date_page.dart';
import 'package:virtue_forge/features/settings/presentation/pages/order_page.dart';
import 'package:virtue_forge/features/settings/presentation/pages/virtue_editor_page.dart';

import 'scaffold_with_nav_bar.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/journal',
  redirect: (context, state) async {
    final onboarding = sl<OnboardingRepository>();
    final tutorial = sl<TutorialRepository>();
    final onboardingDone = await onboarding.hasCompletedOnboarding();
    final tutorialDone = await tutorial.hasCompletedTutorial();
    final loc = state.matchedLocation;
    final onOnboarding = loc == '/onboarding';
    final onTutorial = loc == '/tutorial';

    if (!onboardingDone && !onOnboarding) return '/onboarding';
    if (onboardingDone && onOnboarding) return '/journal';
    // Tutorial is optional (offer dialog after onboarding; replay from Order).
    if (tutorialDone && onTutorial) return '/journal';
    return null;
  },
  routes: $appRoutes,
);

@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OnboardingPage(
      completeOnboarding: sl<CompleteOnboardingUseCase>(),
      tutorialRepository: sl<TutorialRepository>(),
    );
  }
}

@TypedGoRoute<TutorialRoute>(path: '/tutorial')
class TutorialRoute extends GoRouteData with $TutorialRoute {
  const TutorialRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TutorialPage(
      tutorialRepository: sl<TutorialRepository>(),
      levelFloorRepository: sl<PillarLevelFloorRepository>(),
      cycleRepository: sl<CycleRepository>(),
      syncXpLedger: sl<SyncXpLedgerUseCase>(),
    );
  }
}

@TypedStatefulShellRoute<AppShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<JournalBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<JournalRoute>(path: '/journal'),
      ],
    ),
    TypedStatefulShellBranch<TempleBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<TempleRoute>(path: '/temple'),
      ],
    ),
    TypedStatefulShellBranch<PorticoBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<PorticoRoute>(path: '/portico'),
      ],
    ),
    TypedStatefulShellBranch<OrderBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<OrderRoute>(path: '/order'),
      ],
    ),
  ],
)
class AppShellRouteData extends StatefulShellRouteData {
  const AppShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return ScaffoldWithNavBar(navigationShell: navigationShell);
  }
}

class JournalBranchData extends StatefulShellBranchData {
  const JournalBranchData();
}

class JournalRoute extends GoRouteData with $JournalRoute {
  const JournalRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => sl<JournalBloc>()..add(const JournalEvent.started()),
      child: FranklinJournalPage(
        loadTodayStrikeContext: () => sl<LoadTodayStrikeContextUseCase>()(),
        loadQuoteOfDay: ({
          required String localeCode,
          int? focusWeekNumber,
        }) {
          return sl<GetQuoteOfDayUseCase>()(
            localeCode: localeCode,
            focusWeekNumber: focusWeekNumber,
          );
        },
        coach: sl<PillarCoachRepository>(),
        dust: sl<TempleDustRepository>(),
        openDayDetail: ({
          required BuildContext context,
          required int virtueId,
          required DateTime date,
        }) {
          return DayStrikeReflectionPage.open(
            context,
            createBloc: () => sl<DayStrikeDetailBloc>(),
            virtueId: virtueId,
            date: date,
          );
        },
      ),
    );
  }
}

class TempleBranchData extends StatefulShellBranchData {
  const TempleBranchData();
}

class TempleRoute extends GoRouteData with $TempleRoute {
  const TempleRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => sl<TempleBloc>()..add(const TempleEvent.started()),
      child: TemplePage(
        loadPracticeOrigin: () => sl<CycleRepository>().practiceOrigin(),
        coach: sl<PillarCoachRepository>(),
        dust: sl<TempleDustRepository>(),
      ),
    );
  }
}

class PorticoBranchData extends StatefulShellBranchData {
  const PorticoBranchData();
}

class PorticoRoute extends GoRouteData with $PorticoRoute {
  const PorticoRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => sl<PorticoBloc>()..add(const PorticoEvent.started()),
      child: PorticoPage(readerPrefs: sl<EssayReaderPreferences>()),
    );
  }
}

class OrderBranchData extends StatefulShellBranchData {
  const OrderBranchData();
}

class OrderRoute extends GoRouteData with $OrderRoute {
  const OrderRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => sl<CycleArchiveCubit>(),
      child: OrderPage(
        currentFocusStream: sl<WatchCurrentFocusUseCase>()(),
        onReplayTutorial: () async {
          await sl<TutorialRepository>().resetTutorialForReplay();
          // ignore: use_build_context_synchronously
          const TutorialRoute().go(context);
        },
        onSimulateTempleDust: () async {
          await sl<ApplyTempleDustUseCase>().simulateDustDays(dustDays: 5);
        },
        focusSelectionBuilder: (_) => BlocProvider(
          create: (_) => sl<FocusSelectionCubit>()..load(),
          child: const VirtuesSelectionPage(),
        ),
        birthDatePageBuilder: (_) => const BirthDatePage(),
        virtueEditorBuilder: (_) => BlocProvider(
          create: (_) =>
              sl<VirtueEditorBloc>()..add(const VirtueEditorEvent.started()),
          child: const VirtueEditorPage(),
        ),
      ),
    );
  }
}
