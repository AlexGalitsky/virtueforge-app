part of 'portico_bloc.dart';

@freezed
class PorticoEvent with _$PorticoEvent {
  const factory PorticoEvent.started() = PorticoStarted;

  const factory PorticoEvent.randomThoughtRequested() =
      PorticoRandomThoughtRequested;

  const factory PorticoEvent.actionErrorCleared() = PorticoActionErrorCleared;
}
