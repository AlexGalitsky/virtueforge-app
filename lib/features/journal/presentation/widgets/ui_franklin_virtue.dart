import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/journal/domain/models/ui_franklin_virtue.dart';
import 'package:virtue_forge/features/journal/presentation/widgets/strike/strike_cell.dart';

/// Режим дня в сетке: только [today] принимает быстрые жесты ±1.
enum GridDayMode { past, today, future }

class FranklinGridWidget extends StatelessWidget {
  final List<UIFranklinVirtue> virtues;
  final DateTime weekStart;
  final void Function(int virtueId, int dayIndex) onAddStrike;
  final void Function(int virtueId, int dayIndex) onRemoveStrike;
  final void Function(UIFranklinVirtue virtue, int dayIndex) onOpenDayDetail;
  final void Function(UIFranklinVirtue virtue) onOpenVirtueInfo;

  const FranklinGridWidget({
    super.key,
    required this.virtues,
    required this.weekStart,
    required this.onAddStrike,
    required this.onRemoveStrike,
    required this.onOpenDayDetail,
    required this.onOpenVirtueInfo,
  });

  GridDayMode _modeForDay(int dayIndex, int todayIndex) {
    if (todayIndex < 0) {
      final weekMonday = WeekDateUtils.normalizeDate(weekStart);
      final now = WeekDateUtils.normalizeDate(DateTime.now());
      return now.isBefore(weekMonday) ? GridDayMode.future : GridDayMode.past;
    }
    if (dayIndex < todayIndex) return GridDayMode.past;
    if (dayIndex > todayIndex) return GridDayMode.future;
    return GridDayMode.today;
  }

  double _opacityFor(GridDayMode mode) => switch (mode) {
    GridDayMode.today => 1,
    GridDayMode.past => 0.48,
    GridDayMode.future => 0.28,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;
    final daysOfWeek = l10n.weekdayShortLabels;
    final todayIndex = WeekDateUtils.dayIndexInWeek(DateTime.now(), weekStart);
    final todayHighlight =
        (context.stoicColors.focusHighlight ?? colors.primaryContainer)
            .withValues(alpha: 0.55);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Expanded(flex: 3, child: SizedBox()),
              ...List.generate(7, (dayIndex) {
                final mode = _modeForDay(dayIndex, todayIndex);
                final isToday = mode == GridDayMode.today;
                return Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: isToday ? todayHighlight : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          daysOfWeek[dayIndex],
                          style: isToday
                              ? text.gridDay.copyWith(
                                  color: colors.primary,
                                  fontWeight: FontWeight.w700,
                                )
                              : text.gridDay.copyWith(
                                  color: text.gridDay.color?.withValues(
                                    alpha: _opacityFor(mode),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: colors.outline.withValues(alpha: 0.35), height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: virtues.length,
            separatorBuilder: (_, _) => Divider(
              color: colors.outline.withValues(alpha: 0.2),
              height: 1,
            ),
            itemBuilder: (context, index) {
              final virtue = virtues[index];
              final displayName = l10n.virtueGridLabel(
                virtue.weekNumber,
                l10n.resolveCatalogKey(virtue.name),
              );
              return Slidable(
                key: ValueKey('virtue-row-${virtue.id}'),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  extentRatio: 0.42,
                  children: [
                    SlidableAction(
                      onPressed: (_) {
                        final day = todayIndex >= 0 ? todayIndex : 0;
                        onOpenDayDetail(virtue, day);
                      },
                      backgroundColor: colors.primary.withValues(alpha: 0.85),
                      foregroundColor: colors.onPrimary,
                      icon: Icons.menu_book_outlined,
                      label: l10n.gridSwipeNotes,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    SlidableAction(
                      onPressed: (_) => onOpenVirtueInfo(virtue),
                      backgroundColor: colors.secondary.withValues(alpha: 0.85),
                      foregroundColor: colors.onSecondary,
                      icon: Icons.info_outline,
                      label: l10n.gridSwipeInfo,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ],
                ),
                child: Container(
                  color: virtue.isCurrentWeekFocus
                      ? context.stoicColors.focusHighlight
                      : Colors.transparent,
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          displayName,
                          style: virtue.isCurrentWeekFocus
                              ? text.gridVirtueFocus
                              : text.gridVirtue,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ...List.generate(7, (dayIndex) {
                        final mode = _modeForDay(dayIndex, todayIndex);
                        final isToday = mode == GridDayMode.today;
                        final isPast = mode == GridDayMode.past;
                        final hasNotes = virtue.weeklyNoteCounts[dayIndex] > 0;
                        return Expanded(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: isToday
                                  ? todayHighlight
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  StrikeCell(
                                    strikes: virtue.weeklyStrikes[dayIndex],
                                    opacity: _opacityFor(mode),
                                    onTap: isToday
                                        ? () => onAddStrike(virtue.id, dayIndex)
                                        : isPast
                                        ? () =>
                                              onOpenDayDetail(virtue, dayIndex)
                                        : null,
                                    onLongPress: isToday
                                        ? () => onRemoveStrike(
                                            virtue.id,
                                            dayIndex,
                                          )
                                        : null,
                                    onDoubleTap: isToday || isPast
                                        ? () =>
                                              onOpenDayDetail(virtue, dayIndex)
                                        : null,
                                  ),
                                  if (hasNotes)
                                    Positioned(
                                      right: 2,
                                      top: 0,
                                      child: Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: colors.primary,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
