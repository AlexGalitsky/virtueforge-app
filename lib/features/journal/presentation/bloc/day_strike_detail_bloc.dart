import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/entities/strike_note_entry.dart';
import 'package:virtue_forge/features/journal/domain/usecases/delete_strike_note_use_case.dart';
import 'package:virtue_forge/features/journal/domain/usecases/save_strike_note_use_case.dart';
import 'package:virtue_forge/features/journal/domain/usecases/update_strike_use_case.dart';
import 'package:virtue_forge/features/journal/domain/usecases/watch_day_strike_detail_use_case.dart';

part 'day_strike_detail_bloc.freezed.dart';
part 'day_strike_detail_event.dart';
part 'day_strike_detail_state.dart';

class DayStrikeDetailBloc
    extends Bloc<DayStrikeDetailEvent, DayStrikeDetailState> {
  DayStrikeDetailBloc({
    required WatchDayStrikeDetailUseCase watchDayStrikeDetail,
    required UpdateStrikeUseCase updateStrike,
    required SaveStrikeNoteUseCase saveStrikeNote,
    required DeleteStrikeNoteUseCase deleteStrikeNote,
  })  : _watchDayStrikeDetail = watchDayStrikeDetail,
        _updateStrike = updateStrike,
        _saveStrikeNote = saveStrikeNote,
        _deleteStrikeNote = deleteStrikeNote,
        super(const DayStrikeDetailState.initial()) {
    on<DayStrikeDetailStarted>(_onStarted, transformer: restartable());
    on<DayStrikeDetailStrikeUpdated>(_onStrikeUpdated, transformer: sequential());
    on<DayStrikeDetailNoteSaved>(_onNoteSaved, transformer: sequential());
    on<DayStrikeDetailNoteDeleted>(_onNoteDeleted, transformer: sequential());
    on<DayStrikeDetailActionErrorCleared>(_onClearActionError);
  }

  final WatchDayStrikeDetailUseCase _watchDayStrikeDetail;
  final UpdateStrikeUseCase _updateStrike;
  final SaveStrikeNoteUseCase _saveStrikeNote;
  final DeleteStrikeNoteUseCase _deleteStrikeNote;

  Future<void> _onStarted(
    DayStrikeDetailStarted event,
    Emitter<DayStrikeDetailState> emit,
  ) async {
    emit(const DayStrikeDetailState.loading());
    await emit.forEach(
      _watchDayStrikeDetail(virtueId: event.virtueId, date: event.date),
      onData: (snapshot) => DayStrikeDetailState.loaded(
        virtue: snapshot.virtue,
        date: snapshot.date,
        strikesCount: snapshot.strikesCount,
        notes: snapshot.notes,
        canEdit: snapshot.canEdit,
      ),
      onError: (error, _) => DayStrikeDetailState.failure(error.toString()),
    );
  }

  Future<void> _onStrikeUpdated(
    DayStrikeDetailStrikeUpdated event,
    Emitter<DayStrikeDetailState> emit,
  ) async {
    final current = state;
    if (current is! DayStrikeDetailLoaded || !current.canEdit) return;

    try {
      await _updateStrike(
        date: current.date,
        virtueId: current.virtue.id,
        amount: event.amount,
      );
    } catch (error) {
      emit(current.copyWith(actionError: error.toString()));
    }
  }

  Future<void> _onNoteSaved(
    DayStrikeDetailNoteSaved event,
    Emitter<DayStrikeDetailState> emit,
  ) async {
    final current = state;
    if (current is! DayStrikeDetailLoaded || !current.canEdit) return;
    if (event.ordinal < 1 || event.ordinal > current.strikesCount) return;

    try {
      await _saveStrikeNote(
        date: current.date,
        virtueId: current.virtue.id,
        ordinal: event.ordinal,
        body: event.body,
      );
    } catch (error) {
      emit(current.copyWith(actionError: error.toString()));
    }
  }

  Future<void> _onNoteDeleted(
    DayStrikeDetailNoteDeleted event,
    Emitter<DayStrikeDetailState> emit,
  ) async {
    final current = state;
    if (current is! DayStrikeDetailLoaded || !current.canEdit) return;

    try {
      await _deleteStrikeNote(
        date: current.date,
        virtueId: current.virtue.id,
        ordinal: event.ordinal,
      );
    } catch (error) {
      emit(current.copyWith(actionError: error.toString()));
    }
  }

  void _onClearActionError(
    DayStrikeDetailActionErrorCleared event,
    Emitter<DayStrikeDetailState> emit,
  ) {
    final current = state;
    if (current is DayStrikeDetailLoaded && current.actionError != null) {
      emit(current.copyWith(actionError: null));
    }
  }
}
