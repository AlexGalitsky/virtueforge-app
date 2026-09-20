part of 'day_strike_detail_bloc.dart';

@freezed
class DayStrikeDetailEvent with _$DayStrikeDetailEvent {
  const factory DayStrikeDetailEvent.started({
    required int virtueId,
    required DateTime date,
  }) = DayStrikeDetailStarted;

  const factory DayStrikeDetailEvent.strikeUpdated({
    required int amount,
  }) = DayStrikeDetailStrikeUpdated;

  const factory DayStrikeDetailEvent.noteSaved({
    required int ordinal,
    required String body,
  }) = DayStrikeDetailNoteSaved;

  const factory DayStrikeDetailEvent.noteDeleted({
    required int ordinal,
  }) = DayStrikeDetailNoteDeleted;

  const factory DayStrikeDetailEvent.actionErrorCleared() =
      DayStrikeDetailActionErrorCleared;
}
