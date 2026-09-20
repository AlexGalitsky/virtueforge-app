import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/journal/domain/models/ui_franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/usecases/load_today_strike_context_use_case.dart';
import 'package:virtue_forge/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:virtue_forge/features/journal/presentation/haptics/strike_haptics.dart';
import 'package:virtue_forge/features/journal/presentation/widgets/grid_gesture_tips.dart';
import 'package:virtue_forge/features/journal/presentation/widgets/reflection_bottom_sheet.dart';
import 'package:virtue_forge/features/journal/presentation/widgets/ui_franklin_virtue.dart';
import 'package:virtue_forge/features/journal/presentation/widgets/virtue_info_sheet.dart';
import 'package:virtue_forge/features/library/domain/models/stoic_quote.dart';
import 'package:virtue_forge/features/profile_progress/data/pillar_coach_repository.dart';
import 'package:virtue_forge/features/profile_progress/data/temple_dust_repository.dart';
import 'package:virtue_forge/features/settings/presentation/cubit/settings_cubit.dart';

class FranklinJournalPage extends StatelessWidget {
  const FranklinJournalPage({
    super.key,
    required this.openDayDetail,
    required this.loadTodayStrikeContext,
    required this.loadQuoteOfDay,
    required this.coach,
    required this.dust,
  });

  /// Composition-root opener (creates [DayStrikeDetailBloc] outside widgets).
  final Future<void> Function({
    required BuildContext context,
    required int virtueId,
    required DateTime date,
  })
  openDayDetail;

  final Future<TodayStrikeContext> Function() loadTodayStrikeContext;
  final Future<StoicQuote?> Function({
    required String localeCode,
    int? focusWeekNumber,
  })
  loadQuoteOfDay;
  final PillarCoachRepository coach;
  final TempleDustRepository dust;

  @override
  Widget build(BuildContext context) {
    return BlocListener<JournalBloc, JournalState>(
      listenWhen: (previous, current) {
        final prevErr = previous is JournalLoaded ? previous.actionError : null;
        final currErr = current is JournalLoaded ? current.actionError : null;
        return currErr != null && currErr != prevErr;
      },
      listener: (context, state) {
        if (state is! JournalLoaded || state.actionError == null) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.actionError!)));
        context.read<JournalBloc>().add(
          const JournalEvent.actionErrorCleared(),
        );
      },
      child: _FranklinJournalView(
        openDayDetail: openDayDetail,
        loadTodayStrikeContext: loadTodayStrikeContext,
        loadQuoteOfDay: loadQuoteOfDay,
        coach: coach,
        dust: dust,
      ),
    );
  }
}

class _FranklinJournalView extends StatelessWidget {
  const _FranklinJournalView({
    required this.openDayDetail,
    required this.loadTodayStrikeContext,
    required this.loadQuoteOfDay,
    required this.coach,
    required this.dust,
  });

  final Future<void> Function({
    required BuildContext context,
    required int virtueId,
    required DateTime date,
  })
  openDayDetail;

  final Future<TodayStrikeContext> Function() loadTodayStrikeContext;
  final Future<StoicQuote?> Function({
    required String localeCode,
    int? focusWeekNumber,
  })
  loadQuoteOfDay;
  final PillarCoachRepository coach;
  final TempleDustRepository dust;

  Future<void> _openDetail(
    BuildContext context, {
    required UIFranklinVirtue virtue,
    required DateTime weekStart,
    required int dayIndex,
  }) {
    return openDayDetail(
      context: context,
      virtueId: virtue.id,
      date: weekStart.add(Duration(days: dayIndex)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final l10n = context.l10n;
    final isEvening = DateTime.now().hour >= 20;

    return StoicPageScaffold(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(l10n.appTitle, style: text.pageTitle),
        ),
        body: SafeArea(
          child: BlocBuilder<JournalBloc, JournalState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(child: CircularProgressIndicator()),
                loading: () => const Center(child: CircularProgressIndicator()),
                failure: (message) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      message,
                      style: text.body,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                loaded:
                    (
                      virtues,
                      focusWeekNumber,
                      weekStart,
                      canGoPrev,
                      canGoNext,
                      actionError,
                    ) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _QuoteOfDayCard(
                              focusWeekNumber: focusWeekNumber,
                              loadQuoteOfDay: loadQuoteOfDay,
                            ),
                            const SizedBox(height: 12),
                            _WeekNavHeader(
                              weekStart: weekStart,
                              canGoPrev: canGoPrev,
                              canGoNext: canGoNext,
                            ),
                            const SizedBox(height: 10),
                            FranklinGridWidget(
                              virtues: virtues,
                              weekStart: weekStart,
                              onAddStrike: (virtueId, dayIndex) {
                                StrikeHaptics.markFault();
                                context.read<JournalBloc>().add(
                                  JournalEvent.strikeUpdated(
                                    virtueId: virtueId,
                                    dayIndex: dayIndex,
                                    amount: 1,
                                  ),
                                );
                              },
                              onRemoveStrike: (virtueId, dayIndex) {
                                StrikeHaptics.undoFault();
                                context.read<JournalBloc>().add(
                                  JournalEvent.strikeUpdated(
                                    virtueId: virtueId,
                                    dayIndex: dayIndex,
                                    amount: -1,
                                  ),
                                );
                              },
                              onOpenDayDetail: (virtue, dayIndex) {
                                _openDetail(
                                  context,
                                  virtue: virtue,
                                  weekStart: weekStart,
                                  dayIndex: dayIndex,
                                );
                              },
                              onOpenVirtueInfo: (virtue) {
                                showVirtueInfoSheet(context, virtue: virtue);
                              },
                            ),
                            const SizedBox(height: 10),
                            if (context.select<SettingsCubit, bool>(
                              (c) => c.state.showGestureTips,
                            )) ...[
                              const GridGestureTips(),
                              const SizedBox(height: 12),
                            ] else
                              const SizedBox(height: 12),
                            _EveningReflectionButton(
                              label: l10n.eveningReflection,
                              isEvening: isEvening,
                              onPressed: () => ReflectionBottomSheet.show(
                                context,
                                loadTodayContext: loadTodayStrikeContext,
                                coach: coach,
                                dust: dust,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _QuoteOfDayCard extends StatefulWidget {
  const _QuoteOfDayCard({
    required this.focusWeekNumber,
    required this.loadQuoteOfDay,
  });

  final int focusWeekNumber;
  final Future<StoicQuote?> Function({
    required String localeCode,
    int? focusWeekNumber,
  })
  loadQuoteOfDay;

  @override
  State<_QuoteOfDayCard> createState() => _QuoteOfDayCardState();
}

class _QuoteOfDayCardState extends State<_QuoteOfDayCard> {
  Future<StoicQuote?>? _future;
  String? _localeCode;
  int? _focusWeek;

  void _ensureFuture(String localeCode) {
    if (_future != null &&
        _localeCode == localeCode &&
        _focusWeek == widget.focusWeekNumber) {
      return;
    }
    _localeCode = localeCode;
    _focusWeek = widget.focusWeekNumber;
    _future = widget.loadQuoteOfDay(
      localeCode: localeCode,
      focusWeekNumber: widget.focusWeekNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final localeCode = context.select<SettingsCubit, String>(
      (cubit) => cubit.state.localeCode,
    );
    _ensureFuture(localeCode);

    return FutureBuilder<StoicQuote?>(
      future: _future,
      builder: (context, snapshot) {
        final quote = snapshot.data;
        if (quote == null || !quote.hasText) {
          return QuoteCard(
            author: l10n.quoteMarcusAuthor,
            quote: l10n.quoteMarcusBody,
          );
        }
        return QuoteCard(author: quote.author, quote: quote.text);
      },
    );
  }
}

class _WeekNavHeader extends StatelessWidget {
  const _WeekNavHeader({
    required this.weekStart,
    required this.canGoPrev,
    required this.canGoNext,
  });

  final DateTime weekStart;
  final bool canGoPrev;
  final bool canGoNext;

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final l10n = context.l10n;
    final colors = context.colorScheme;
    final currentWeekStart = WeekDateUtils.startOfWeek(DateTime.now());
    final isCurrentWeek =
        WeekDateUtils.normalizeDate(weekStart) ==
        WeekDateUtils.normalizeDate(currentWeekStart);

    final label = isCurrentWeek
        ? l10n.weekNavCurrent
        : l10n.weekNavPast(_formatWeekStart(weekStart));

    return Row(
      children: [
        IconButton(
          tooltip: l10n.weekPrev,
          onPressed: canGoPrev
              ? () => context.read<JournalBloc>().add(
                  const JournalEvent.weekShifted(delta: -1),
                )
              : null,
          icon: Icon(
            Icons.chevron_left,
            color: canGoPrev
                ? colors.onSurface
                : colors.onSurface.withValues(alpha: 0.25),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                l10n.journalGridTitle,
                style: text.tileTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: text.captionAccent,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: l10n.weekNext,
          onPressed: canGoNext
              ? () => context.read<JournalBloc>().add(
                  const JournalEvent.weekShifted(delta: 1),
                )
              : null,
          icon: Icon(
            Icons.chevron_right,
            color: canGoNext
                ? colors.onSurface
                : colors.onSurface.withValues(alpha: 0.25),
          ),
        ),
      ],
    );
  }

  String _formatWeekStart(DateTime weekStart) {
    final d = weekStart.day.toString().padLeft(2, '0');
    final m = weekStart.month.toString().padLeft(2, '0');
    return '$d.$m.${weekStart.year}';
  }
}

class _EveningReflectionButton extends StatefulWidget {
  const _EveningReflectionButton({
    required this.label,
    required this.isEvening,
    required this.onPressed,
  });

  final String label;
  final bool isEvening;
  final VoidCallback onPressed;

  @override
  State<_EveningReflectionButton> createState() =>
      _EveningReflectionButtonState();
}

class _EveningReflectionButtonState extends State<_EveningReflectionButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    _opacity = Tween<double>(
      begin: 0.55,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    if (widget.isEvening) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant _EveningReflectionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isEvening && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isEvening && _controller.isAnimating) {
      _controller.stop();
      _controller.value = 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isEvening) {
      return StoicOutlinedButton(
        label: widget.label,
        dimmed: true,
        onPressed: widget.onPressed,
      );
    }

    return FadeTransition(
      opacity: _opacity,
      child: StoicOutlinedButton(
        label: widget.label,
        onPressed: widget.onPressed,
      ),
    );
  }
}
