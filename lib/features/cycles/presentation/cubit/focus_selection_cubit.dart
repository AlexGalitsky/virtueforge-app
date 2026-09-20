import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/set_focus_virtue_use_case.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/watch_current_focus_use_case.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/journal/domain/repositories/catalog_repository.dart';

class FocusSelectionState {
  const FocusSelectionState({
    required this.virtues,
    required this.selectedWeekNumber,
    required this.loading,
    this.saving = false,
    this.error,
  });

  final List<FranklinVirtue> virtues;
  final int selectedWeekNumber;
  final bool loading;
  final bool saving;
  final String? error;

  FocusSelectionState copyWith({
    List<FranklinVirtue>? virtues,
    int? selectedWeekNumber,
    bool? loading,
    bool? saving,
    String? error,
    bool clearError = false,
  }) {
    return FocusSelectionState(
      virtues: virtues ?? this.virtues,
      selectedWeekNumber: selectedWeekNumber ?? this.selectedWeekNumber,
      loading: loading ?? this.loading,
      saving: saving ?? this.saving,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class FocusSelectionCubit extends Cubit<FocusSelectionState> {
  FocusSelectionCubit({
    required CatalogRepository catalogRepository,
    required WatchCurrentFocusUseCase watchCurrentFocus,
    required SetFocusVirtueUseCase setFocusVirtue,
  })  : _catalog = catalogRepository,
        _watchCurrentFocus = watchCurrentFocus,
        _setFocusVirtue = setFocusVirtue,
        super(
          const FocusSelectionState(
            virtues: [],
            selectedWeekNumber: 1,
            loading: true,
          ),
        );

  final CatalogRepository _catalog;
  final WatchCurrentFocusUseCase _watchCurrentFocus;
  final SetFocusVirtueUseCase _setFocusVirtue;

  Future<void> load() async {
    emit(state.copyWith(loading: true, clearError: true));
    try {
      final virtues = await _catalog.watchVirtues().first;
      final sorted = [...virtues]
        ..sort((a, b) => a.defaultWeekNumber.compareTo(b.defaultWeekNumber));
      final focus = await _watchCurrentFocus().first;
      emit(
        FocusSelectionState(
          virtues: sorted,
          selectedWeekNumber: focus.focusWeekNumber,
          loading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  void selectWeekNumber(int weekNumber) {
    emit(state.copyWith(selectedWeekNumber: weekNumber, clearError: true));
  }

  Future<bool> confirm() async {
    emit(state.copyWith(saving: true, clearError: true));
    try {
      await _setFocusVirtue(weekNumber: state.selectedWeekNumber);
      emit(state.copyWith(saving: false));
      return true;
    } catch (e) {
      emit(state.copyWith(saving: false, error: e.toString()));
      return false;
    }
  }
}
