part of 'temple_bloc.dart';

@freezed
class TempleState with _$TempleState {
  const factory TempleState.initial() = TempleInitial;

  const factory TempleState.loading() = TempleLoading;

  const factory TempleState.loaded({
    required List<UIStoicPillar> pillars,
    required int cycleInYear,
    required int cyclesPerYear,
  }) = TempleLoaded;

  const factory TempleState.failure(String message) = TempleFailure;
}
