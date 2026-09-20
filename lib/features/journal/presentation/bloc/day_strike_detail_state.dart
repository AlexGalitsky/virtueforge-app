part of 'day_strike_detail_bloc.dart';

@freezed
class DayStrikeDetailState with _$DayStrikeDetailState {
  const factory DayStrikeDetailState.initial() = DayStrikeDetailInitial;

  const factory DayStrikeDetailState.loading() = DayStrikeDetailLoading;

  const factory DayStrikeDetailState.loaded({
    required FranklinVirtue virtue,
    required DateTime date,
    required int strikesCount,
    required List<StrikeNoteEntry> notes,
    required bool canEdit,
    String? actionError,
  }) = DayStrikeDetailLoaded;

  const factory DayStrikeDetailState.failure(String message) =
      DayStrikeDetailFailure;
}
