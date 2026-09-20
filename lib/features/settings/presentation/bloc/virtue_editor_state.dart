part of 'virtue_editor_bloc.dart';

@freezed
class VirtueEditorState with _$VirtueEditorState {
  const factory VirtueEditorState.initial() = VirtueEditorInitial;

  const factory VirtueEditorState.loading() = VirtueEditorLoading;

  const factory VirtueEditorState.loaded({
    required List<FranklinVirtue> virtues,
    String? actionError,
  }) = VirtueEditorLoaded;

  const factory VirtueEditorState.failure(String message) = VirtueEditorFailure;
}
