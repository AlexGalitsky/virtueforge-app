import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:virtue_forge/features/library/domain/models/essay.dart';
import 'package:virtue_forge/features/library/domain/usecases/load_portico_content_use_case.dart';
import 'package:virtue_forge/features/library/domain/usecases/load_random_thought_use_case.dart';

part 'portico_bloc.freezed.dart';
part 'portico_event.dart';
part 'portico_state.dart';

class PorticoBloc extends Bloc<PorticoEvent, PorticoState> {
  PorticoBloc({
    required LoadPorticoContentUseCase loadPorticoContent,
    required LoadRandomThoughtUseCase loadRandomThought,
  })  : _loadPorticoContent = loadPorticoContent,
        _loadRandomThought = loadRandomThought,
        super(const PorticoState.initial()) {
    on<PorticoStarted>(_onStarted);
    on<PorticoRandomThoughtRequested>(_onRandom);
    on<PorticoActionErrorCleared>(_onClearError);
  }

  final LoadPorticoContentUseCase _loadPorticoContent;
  final LoadRandomThoughtUseCase _loadRandomThought;

  Future<void> _onStarted(
    PorticoStarted event,
    Emitter<PorticoState> emit,
  ) async {
    emit(const PorticoState.loading());
    try {
      final content = await _loadPorticoContent();
      emit(
        PorticoState.loaded(
          essays: content.essays,
          focusWeekNumber: content.focusWeekNumber,
        ),
      );
    } catch (error) {
      emit(PorticoState.failure(error.toString()));
    }
  }

  Future<void> _onRandom(
    PorticoRandomThoughtRequested event,
    Emitter<PorticoState> emit,
  ) async {
    final current = state;
    if (current is! PorticoLoaded) return;
    try {
      final essay = await _loadRandomThought(
        focusWeekNumber: current.focusWeekNumber,
      );
      if (essay == null) return;
      emit(current.copyWith(randomThought: essay, actionError: null));
    } catch (error) {
      emit(current.copyWith(actionError: error.toString()));
    }
  }

  void _onClearError(
    PorticoActionErrorCleared event,
    Emitter<PorticoState> emit,
  ) {
    final current = state;
    if (current is PorticoLoaded && current.actionError != null) {
      emit(current.copyWith(actionError: null));
    }
  }
}
