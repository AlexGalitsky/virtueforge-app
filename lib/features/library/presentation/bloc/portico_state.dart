part of 'portico_bloc.dart';

@freezed
class PorticoState with _$PorticoState {
  const factory PorticoState.initial() = PorticoInitial;

  const factory PorticoState.loading() = PorticoLoading;

  const factory PorticoState.loaded({
    required List<Essay> essays,
    required int focusWeekNumber,
    Essay? randomThought,
    String? actionError,
  }) = PorticoLoaded;

  const factory PorticoState.failure(String message) = PorticoFailure;
}
