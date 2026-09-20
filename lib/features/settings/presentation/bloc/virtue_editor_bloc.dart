import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/settings/domain/usecases/save_virtue_description_use_case.dart';
import 'package:virtue_forge/features/settings/domain/usecases/watch_virtues_use_case.dart';

part 'virtue_editor_bloc.freezed.dart';
part 'virtue_editor_event.dart';
part 'virtue_editor_state.dart';

class VirtueEditorBloc extends Bloc<VirtueEditorEvent, VirtueEditorState> {
  VirtueEditorBloc({
    required WatchVirtuesUseCase watchVirtues,
    required SaveVirtueDescriptionUseCase saveVirtueDescription,
  })  : _watchVirtues = watchVirtues,
        _saveVirtueDescription = saveVirtueDescription,
        super(const VirtueEditorState.initial()) {
    on<VirtueEditorStarted>(_onStarted, transformer: restartable());
    on<VirtueDescriptionSaved>(_onSaved, transformer: sequential());
    on<VirtueEditorActionErrorCleared>(_onClearError);
  }

  final WatchVirtuesUseCase _watchVirtues;
  final SaveVirtueDescriptionUseCase _saveVirtueDescription;

  Future<void> _onStarted(
    VirtueEditorStarted event,
    Emitter<VirtueEditorState> emit,
  ) async {
    emit(const VirtueEditorState.loading());
    await emit.forEach(
      _watchVirtues(),
      onData: (virtues) => VirtueEditorState.loaded(virtues: virtues),
      onError: (error, _) => VirtueEditorState.failure(error.toString()),
    );
  }

  Future<void> _onSaved(
    VirtueDescriptionSaved event,
    Emitter<VirtueEditorState> emit,
  ) async {
    final current = state;
    if (current is! VirtueEditorLoaded) return;
    try {
      await _saveVirtueDescription(
        id: event.virtueId,
        customDescription: event.customDescription,
      );
    } catch (error) {
      emit(current.copyWith(actionError: error.toString()));
    }
  }

  void _onClearError(
    VirtueEditorActionErrorCleared event,
    Emitter<VirtueEditorState> emit,
  ) {
    final current = state;
    if (current is VirtueEditorLoaded && current.actionError != null) {
      emit(current.copyWith(actionError: null));
    }
  }
}
