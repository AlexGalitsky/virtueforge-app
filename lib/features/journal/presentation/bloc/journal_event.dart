part of 'journal_bloc.dart';

@freezed
class JournalEvent with _$JournalEvent {
  const factory JournalEvent.started({DateTime? week}) = JournalStarted;

  /// Shift viewed week by [delta] ISO weeks (−1 = previous, +1 = next).
  const factory JournalEvent.weekShifted({required int delta}) =
      JournalWeekShifted;

  const factory JournalEvent.strikeUpdated({
    required int virtueId,
    required int dayIndex,
    required int amount,
  }) = StrikeUpdated;

  const factory JournalEvent.reflectionSaved({
    required String noteUncontrolled,
    required String noteControlled,
  }) = ReflectionSaved;

  const factory JournalEvent.actionErrorCleared() = JournalActionErrorCleared;
}
