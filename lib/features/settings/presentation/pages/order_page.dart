import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/cycles/domain/models/ui_practice_cycle.dart';
import 'package:virtue_forge/features/cycles/domain/services/cycle_calculator.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/watch_current_focus_use_case.dart';
import 'package:virtue_forge/features/cycles/presentation/cubit/cycle_archive_cubit.dart';
import 'package:virtue_forge/features/cycles/presentation/pages/cycle_detail_page.dart';
import 'package:virtue_forge/features/settings/domain/models/app_settings.dart';
import 'package:virtue_forge/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:virtue_forge/features/settings/presentation/mappers/app_settings_ui.dart';
import 'package:virtue_forge/features/settings/presentation/pages/ledger_export_page.dart';
import 'package:virtue_forge/features/settings/presentation/pages/privacy_manifest_page.dart';
import 'package:virtue_forge/features/mentor/presentation/pages/mentor_about_page.dart';
import 'package:virtue_forge/generated/l10n/app_localizations.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({
    super.key,
    required this.virtueEditorBuilder,
    required this.focusSelectionBuilder,
    required this.birthDatePageBuilder,
    required this.currentFocusStream,
    required this.onReplayTutorial,
    this.onSimulateTempleDust,
  });

  final WidgetBuilder virtueEditorBuilder;
  final WidgetBuilder focusSelectionBuilder;
  final WidgetBuilder birthDatePageBuilder;
  final Stream<CurrentFocusSnapshot> currentFocusStream;
  final VoidCallback onReplayTutorial;
  final Future<void> Function()? onSimulateTempleDust;

  @override
  Widget build(BuildContext context) => _OrderView(
        virtueEditorBuilder: virtueEditorBuilder,
        focusSelectionBuilder: focusSelectionBuilder,
        birthDatePageBuilder: birthDatePageBuilder,
        currentFocusStream: currentFocusStream,
        onReplayTutorial: onReplayTutorial,
        onSimulateTempleDust: onSimulateTempleDust,
      );
}

class _OrderView extends StatelessWidget {
  const _OrderView({
    required this.virtueEditorBuilder,
    required this.focusSelectionBuilder,
    required this.birthDatePageBuilder,
    required this.currentFocusStream,
    required this.onReplayTutorial,
    this.onSimulateTempleDust,
  });

  final WidgetBuilder virtueEditorBuilder;
  final Future<void> Function()? onSimulateTempleDust;
  final WidgetBuilder focusSelectionBuilder;
  final WidgetBuilder birthDatePageBuilder;
  final Stream<CurrentFocusSnapshot> currentFocusStream;
  final VoidCallback onReplayTutorial;

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final l10n = context.l10n;

    return StoicPageScaffold(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(l10n.orderTitle, style: text.pageTitle),
        ),
        body: BlocBuilder<SettingsCubit, AppSettings>(
          builder: (context, settings) {
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Text(l10n.archiveCycles, style: text.eyebrowAccent),
                ),
                BlocBuilder<CycleArchiveCubit, CycleArchiveState>(
                  builder: (context, archive) {
                    if (archive.loading) {
                      return const Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final tiles = <Widget>[];
                    final active = archive.active;
                    if (active != null) {
                      tiles.add(
                        StoicSettingsTile(
                          icon: Icons.auto_stories_outlined,
                          title: _cycleTitle(l10n, active),
                          subtitle: l10n.cycleActiveSubtitle(
                            active.weekInCycle ?? 1,
                            CycleCalculator.weeksPerCycle,
                          ),
                          onTap: () => _openCycleDetail(context, active.id),
                        ),
                      );
                    }

                    if (archive.archived.isEmpty) {
                      tiles.add(
                        StoicSettingsTile(
                          icon: Icons.lock_clock,
                          title: l10n.archiveEmptyTitle,
                          subtitle: l10n.archiveEmptySubtitle,
                        ),
                      );
                    } else {
                      for (final cycle in archive.archived) {
                        tiles.add(
                          StoicSettingsTile(
                            icon: Icons.history_edu,
                            title: _cycleTitle(l10n, cycle),
                            subtitle: _archivedSubtitle(l10n, cycle),
                            onTap: () => _openCycleDetail(context, cycle.id),
                          ),
                        );
                      }
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: tiles,
                    );
                  },
                ),
                const SizedBox(height: 16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Text(l10n.preferencesTitle, style: text.eyebrowAccent),
                ),
                StreamBuilder<CurrentFocusSnapshot>(
                  stream: currentFocusStream,
                  builder: (context, snapshot) {
                    final focus = snapshot.data;
                    final name = focus?.virtue == null
                        ? '—'
                        : l10n.resolveCatalogKey(focus!.virtue!.name);
                    final subtitle = focus == null
                        ? l10n.focusSelectTileSubtitleAuto
                        : focus.isManualShift
                            ? l10n.focusSelectTileSubtitleManual(
                                focus.focusWeekNumber,
                                name,
                              )
                            : l10n.focusSelectTileSubtitleAutoNamed(
                                focus.focusWeekNumber,
                                name,
                              );
                    return StoicSettingsTile(
                      icon: Icons.center_focus_strong_outlined,
                      title: l10n.focusSelectTileTitle,
                      subtitle: subtitle,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: focusSelectionBuilder),
                        );
                      },
                    );
                  },
                ),
                StoicSettingsTile(
                  icon: Icons.language,
                  title: l10n.languageTitle,
                  subtitle: _languageLabel(l10n, settings.localeCode),
                  onTap: () => _pickLanguage(context, settings.localeCode),
                ),
                StoicSettingsTile(
                  icon: Icons.brightness_6_outlined,
                  title: l10n.themeTitle,
                  subtitle: _themeLabel(l10n, settings.themePreference),
                  onTap: () =>
                      _pickTheme(context, settings.themePreference),
                ),
                StoicSettingsTile(
                  icon: Icons.notifications_none,
                  title: l10n.reminderTitle,
                  subtitle: settings.reminderEnabled
                      ? l10n.reminderSubtitle(settings.reminderTimeLabel)
                      : l10n.reminderOffSubtitle,
                  onTap: () => _pickReminderTime(context, settings),
                  trailing: Switch.adaptive(
                    value: settings.reminderEnabled,
                    onChanged: (enabled) => _toggleReminder(context, enabled),
                  ),
                ),
                StoicSettingsTile(
                  icon: Icons.lightbulb_outline,
                  title: l10n.gestureTipsTitle,
                  subtitle: settings.showGestureTips
                      ? l10n.gestureTipsSubtitleOn
                      : l10n.gestureTipsSubtitleOff,
                  trailing: Switch.adaptive(
                    value: settings.showGestureTips,
                    onChanged: (enabled) => context
                        .read<SettingsCubit>()
                        .setShowGestureTips(enabled),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Text(l10n.personalSettings, style: text.eyebrowAccent),
                ),
                StoicSettingsTile(
                  icon: Icons.school_outlined,
                  title: l10n.tutorialReplayTitle,
                  subtitle: l10n.tutorialReplaySubtitle,
                  onTap: onReplayTutorial,
                ),
                StoicSettingsTile(
                  icon: Icons.menu_book_outlined,
                  title: l10n.ledgerExportTileTitle,
                  subtitle: l10n.ledgerExportTileSubtitle,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LedgerExportPage(),
                      ),
                    );
                  },
                ),
                StoicSettingsTile(
                  icon: Icons.psychology_alt_outlined,
                  title: l10n.mentorOrderTileTitle,
                  subtitle: l10n.mentorOrderTileSubtitle,
                  onTap: () => MentorAboutPage.open(context),
                ),
                StoicSettingsTile(
                  icon: Icons.hourglass_empty_outlined,
                  title: l10n.birthDateTileTitle,
                  subtitle: settings.birthDate == null
                      ? l10n.birthDateTileSubtitleEmpty
                      : l10n.birthDateTileSubtitleSet(
                          _formatBirthDate(settings.birthDate!),
                        ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: birthDatePageBuilder),
                    );
                  },
                ),
                StoicSettingsTile(
                  icon: Icons.edit_note,
                  title: l10n.editorTitle,
                  subtitle: l10n.editorSubtitle,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: virtueEditorBuilder),
                    );
                  },
                ),
                StoicSettingsTile(
                  icon: Icons.security,
                  title: l10n.privacyTitle,
                  subtitle: l10n.privacySubtitle,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PrivacyManifestPage(),
                      ),
                    );
                  },
                ),
                if (kDebugMode && onSimulateTempleDust != null) ...[
                  const SizedBox(height: 16),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: Text(l10n.debugSectionTitle, style: text.eyebrowAccent),
                  ),
                  StoicSettingsTile(
                    icon: Icons.hourglass_bottom,
                    title: l10n.debugSimulateDustTitle,
                    subtitle: l10n.debugSimulateDustSubtitle,
                    onTap: () async {
                      await onSimulateTempleDust!();
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.debugSimulateDustDone)),
                      );
                    },
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  String _cycleTitle(AppLocalizations l10n, UIPracticeCycle cycle) {
    return l10n.cycleTitle(
      CycleCalculator.romanNumeral(cycle.cycleInYear),
      cycle.startedAt.year,
    );
  }

  void _openCycleDetail(BuildContext context, int cycleId) {
    CycleDetailPage.open(context, cycleId: cycleId);
  }

  String _archivedSubtitle(AppLocalizations l10n, UIPracticeCycle cycle) {
    final percent = cycle.successPercent ?? 0;
    final weakId = cycle.weakPillarId;
    if (weakId == null) {
      return l10n.cycleDoneSubtitleNoWeak(percent);
    }
    return l10n.cycleDoneSubtitle(percent, _pillarName(l10n, weakId));
  }

  String _pillarName(AppLocalizations l10n, int? pillarId) {
    switch (pillarId) {
      case 1:
        return l10n.resolveCatalogKey('stoicTemperance');
      case 2:
        return l10n.resolveCatalogKey('stoicWisdom');
      case 3:
        return l10n.resolveCatalogKey('stoicCourage');
      case 4:
        return l10n.resolveCatalogKey('stoicJustice');
      default:
        return '—';
    }
  }

  String _formatBirthDate(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    return '$d.$m.${date.year}';
  }

  String _languageLabel(AppLocalizations l10n, String code) {
    return code == 'ru' ? l10n.languageRussian : l10n.languageEnglish;
  }

  String _themeLabel(AppLocalizations l10n, ThemePreference preference) {
    switch (preference) {
      case ThemePreference.light:
        return l10n.themeLight;
      case ThemePreference.dark:
        return l10n.themeDark;
      case ThemePreference.system:
        return l10n.themeSystem;
    }
  }

  Future<void> _pickLanguage(BuildContext context, String current) async {
    final l10n = context.l10n;
    final selected = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(l10n.languageEnglish),
                trailing: current == 'en' ? const Icon(Icons.check) : null,
                onTap: () => Navigator.pop(sheetContext, 'en'),
              ),
              ListTile(
                title: Text(l10n.languageRussian),
                trailing: current == 'ru' ? const Icon(Icons.check) : null,
                onTap: () => Navigator.pop(sheetContext, 'ru'),
              ),
            ],
          ),
        );
      },
    );
    if (selected == null || !context.mounted) return;
    await context.read<SettingsCubit>().setLocale(selected);
  }

  Future<void> _pickTheme(
    BuildContext context,
    ThemePreference current,
  ) async {
    final l10n = context.l10n;
    final selected = await showModalBottomSheet<ThemePreference>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final preference in ThemePreference.values)
                ListTile(
                  title: Text(_themeLabel(l10n, preference)),
                  trailing:
                      current == preference ? const Icon(Icons.check) : null,
                  onTap: () => Navigator.pop(sheetContext, preference),
                ),
            ],
          ),
        );
      },
    );
    if (selected == null || !context.mounted) return;
    await context.read<SettingsCubit>().setThemePreference(selected);
  }

  Future<void> _toggleReminder(BuildContext context, bool enabled) async {
    final l10n = context.l10n;
    final ok = await context.read<SettingsCubit>().setReminderEnabled(
          enabled: enabled,
          title: l10n.reminderNotificationTitle,
          body: l10n.reminderNotificationBody,
        );
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.reminderPermissionDenied)),
      );
    }
  }

  Future<void> _pickReminderTime(
    BuildContext context,
    AppSettings settings,
  ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: settings.reminderTime,
    );
    if (picked == null || !context.mounted) return;

    final l10n = context.l10n;
    await context.read<SettingsCubit>().setReminderTime(
          hour: picked.hour,
          minute: picked.minute,
          title: l10n.reminderNotificationTitle,
          body: l10n.reminderNotificationBody,
        );
  }
}
