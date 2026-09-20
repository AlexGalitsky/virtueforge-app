import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:virtue_forge/features/profile_progress/domain/models/ui_stoic_pillar.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/watch_temple_dashboard_use_case.dart';

part 'temple_bloc.freezed.dart';
part 'temple_event.dart';
part 'temple_state.dart';

class TempleBloc extends Bloc<TempleEvent, TempleState> {
  TempleBloc({required WatchTempleDashboardUseCase watchTempleDashboard})
      : _watchTempleDashboard = watchTempleDashboard,
        super(const TempleState.initial()) {
    on<TempleStarted>(_onStarted);
  }

  final WatchTempleDashboardUseCase _watchTempleDashboard;

  Future<void> _onStarted(
    TempleStarted event,
    Emitter<TempleState> emit,
  ) async {
    emit(const TempleState.loading());
    await emit.forEach(
      _watchTempleDashboard(),
      onData: (dashboard) => TempleState.loaded(
        pillars: dashboard.pillars,
        cycleInYear: dashboard.cycleInYear,
        cyclesPerYear: dashboard.cyclesPerYear,
      ),
      onError: (error, _) => TempleState.failure(error.toString()),
    );
  }
}
