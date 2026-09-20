part of 'virtue_editor_bloc.dart';

@freezed
class VirtueEditorEvent with _$VirtueEditorEvent {
  const factory VirtueEditorEvent.started() = VirtueEditorStarted;

  const factory VirtueEditorEvent.descriptionSaved({
    required int virtueId,
    required String? customDescription,
  }) = VirtueDescriptionSaved;

  const factory VirtueEditorEvent.actionErrorCleared() =
      VirtueEditorActionErrorCleared;
}
