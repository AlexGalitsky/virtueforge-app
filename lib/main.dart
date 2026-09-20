import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtue_forge/core/di/injection_container.dart';
import 'package:virtue_forge/core/navigation/app_router.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/apply_temple_dust_use_case.dart';
import 'package:virtue_forge/features/settings/data/notification_scheduler.dart';
import 'package:virtue_forge/features/settings/domain/models/app_settings.dart';
import 'package:virtue_forge/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:virtue_forge/features/settings/presentation/mappers/app_settings_ui.dart';
import 'package:virtue_forge/generated/l10n/app_localizations.dart';

void _logFatal(Object error, StackTrace stack) {
  // Keep local-first: no third-party crash SDK yet. Surface in debug / console.
  FlutterError.presentError(
    FlutterErrorDetails(exception: error, stack: stack),
  );
  debugPrint('FATAL: $error\n$stack');
}

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      debugPrint('FlutterError: ${details.exceptionAsString()}');
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      _logFatal(error, stack);
      return true;
    };

    await initDependencies();
    await sl<NotificationScheduler>().init();
    await sl<ApplyTempleDustUseCase>()();
    final settingsCubit = sl<SettingsCubit>();
    runApp(MyApp(settingsCubit: settingsCubit));
  }, _logFatal);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.settingsCubit});

  final SettingsCubit settingsCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: settingsCubit,
      child: BlocBuilder<SettingsCubit, AppSettings>(
        buildWhen: (previous, current) =>
            previous.localeCode != current.localeCode ||
            previous.themePreference != current.themePreference,
        builder: (context, settings) {
          return MaterialApp.router(
            onGenerateTitle: (context) => context.l10n.appTitle,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: settings.locale,
            debugShowCheckedModeBanner: false,
            routerConfig: goRouter,
            theme: StoicTheme.lightTheme,
            darkTheme: StoicTheme.darkTheme,
            themeMode: settings.themePreference.toThemeMode(),
            builder: (context, child) => _ReminderLocaleSync(child: child),
          );
        },
      ),
    );
  }
}

class _ReminderLocaleSync extends StatefulWidget {
  const _ReminderLocaleSync({this.child});

  final Widget? child;

  @override
  State<_ReminderLocaleSync> createState() => _ReminderLocaleSyncState();
}

class _ReminderLocaleSyncState extends State<_ReminderLocaleSync> {
  String? _syncedLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context).languageCode;
    if (_syncedLocale == locale) return;
    _syncedLocale = locale;

    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<SettingsCubit>().syncReminder(
            title: l10n.reminderNotificationTitle,
            body: l10n.reminderNotificationBody,
          );
    });
  }

  @override
  Widget build(BuildContext context) =>
      widget.child ?? const SizedBox.shrink();
}
