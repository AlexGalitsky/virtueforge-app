import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/journal/domain/models/ui_franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/usecases/save_reflection_use_case.dart';
import 'package:virtue_forge/features/journal/domain/usecases/update_strike_use_case.dart';
import 'package:virtue_forge/features/journal/domain/usecases/watch_journal_week_use_case.dart';

part 'journal_bloc.freezed.dart';
part 'journal_event.dart';
part 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  JournalBloc({
    required WatchJournalWeekUseCase watchJournalWeek,
    required UpdateStrikeUseCase updateStrike,
    required SaveReflectionUseCase saveReflection,
  })  : _watchJournalWeek = watchJournalWeek,
        _updateStrike = updateStrike,
        _saveReflection = saveReflection,
        super(const JournalState.initial()) {
    on<JournalStarted>(_onStarted, transformer: restartable());
    on<JournalWeekShifted>(_onWeekShifted);
    on<StrikeUpdated>(_onStrikeUpdated, transformer: sequential());
    on<ReflectionSaved>(_onReflectionSaved, transformer: sequential());
    on<JournalActionErrorCleared>(_onClearActionError);
  }

  final WatchJournalWeekUseCase _watchJournalWeek;
  final UpdateStrikeUseCase _updateStrike;
  final SaveReflectionUseCase _saveReflection;

  DateTime? _viewedWeekStart;

  Future<void> _onStarted(
    JournalStarted event,
    Emitter<JournalState> emit,
  ) async {
    emit(const JournalState.loading());
    await emit.forEach(
      _watchJournalWeek(week: event.week ?? _viewedWeekStart),
      onData: (snapshot) {
        _viewedWeekStart = snapshot.weekStart;
        return JournalState.loaded(
          virtues: snapshot.virtues,
          focusWeekNumber: snapshot.focusWeekNumber,
          weekStart: snapshot.weekStart,
          canGoPrev: snapshot.canGoPrev,
          canGoNext: snapshot.canGoNext,
        );
      },
      onError: (error, _) => JournalState.failure(error.toString()),
    );
  }

  void _onWeekShifted(
    JournalWeekShifted event,
    Emitter<JournalState> emit,
  ) {
    final current = state;
    if (current is! JournalLoaded) return;
    if (event.delta < 0 && !current.canGoPrev) return;
    if (event.delta > 0 && !current.canGoNext) return;
    if (event.delta == 0) return;

    final nextWeek = current.weekStart.add(Duration(days: 7 * event.delta));
    add(JournalEvent.started(week: nextWeek));
  }

  Future<void> _onStrikeUpdated(
    StrikeUpdated event,
    Emitter<JournalState> emit,
  ) async {
    final current = state;
    if (current is! JournalLoaded) return;
    if (!_isEditableToday(current, event.dayIndex)) return;

    final date = current.weekStart.add(Duration(days: event.dayIndex));
    try {
      await _updateStrike(
        date: date,
        virtueId: event.virtueId,
        amount: event.amount,
      );
    } catch (error) {
      emit(current.copyWith(actionError: error.toString()));
    }
  }

  Future<void> _onReflectionSaved(
    ReflectionSaved event,
    Emitter<JournalState> emit,
  ) async {
    final current = state;
    if (current is! JournalLoaded) return;

    UIFranklinVirtue? focusVirtue;
    for (final virtue in current.virtues) {
      if (virtue.weekNumber == current.focusWeekNumber) {
        focusVirtue = virtue;
        break;
      }
    }
    if (focusVirtue == null) return;

    try {
      await _saveReflection(
        date: DateTime.now(),
        virtueId: focusVirtue.id,
        noteControlled: event.noteControlled,
        noteUncontrolled: event.noteUncontrolled,
      );
    } catch (error) {
      emit(current.copyWith(actionError: error.toString()));
    }
  }

  void _onClearActionError(
    JournalActionErrorCleared event,
    Emitter<JournalState> emit,
  ) {
    final current = state;
    if (current is JournalLoaded && current.actionError != null) {
      emit(current.copyWith(actionError: null));
    }
  }

  bool _isEditableToday(JournalLoaded state, int dayIndex) {
    final todayIndex =
        WeekDateUtils.dayIndexInWeek(DateTime.now(), state.weekStart);
    return todayIndex >= 0 && dayIndex == todayIndex;
  }
}
