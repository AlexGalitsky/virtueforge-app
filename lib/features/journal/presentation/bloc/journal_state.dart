part of 'journal_bloc.dart';

@freezed
class JournalState with _$JournalState {
  const factory JournalState.initial() = JournalInitial;

  const factory JournalState.loading() = JournalLoading;

  const factory JournalState.loaded({
    required List<UIFranklinVirtue> virtues,
    required int focusWeekNumber,
    required DateTime weekStart,
    @Default(false) bool canGoPrev,
    @Default(false) bool canGoNext,
    String? actionError,
  }) = JournalLoaded;

  const factory JournalState.failure(String message) = JournalFailure;
}
