import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_franklin_virtue.freezed.dart';

@freezed
abstract class UIFranklinVirtue with _$UIFranklinVirtue {
  const factory UIFranklinVirtue({
    required int id,
    /// Ключ локализации из БД (`virtueAbstinence`).
    required String name,
    /// Ключ описания добродетели.
    required String description,
    required int weekNumber,
    required bool isCurrentWeekFocus,
    /// Ровно 7 элементов: Пн…Вс.
    required List<int> weeklyStrikes,
    /// Ровно 7 элементов: сколько заметок на день (для бейджа в сетке).
    required List<int> weeklyNoteCounts,
  }) = _UIFranklinVirtue;
}
