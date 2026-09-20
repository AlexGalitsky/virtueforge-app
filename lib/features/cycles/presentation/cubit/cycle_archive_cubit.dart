import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtue_forge/features/cycles/domain/models/ui_practice_cycle.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/watch_cycle_archive_use_case.dart';

class CycleArchiveState {
  const CycleArchiveState({
    this.active,
    this.archived = const [],
    this.loading = true,
  });

  final UIPracticeCycle? active;
  final List<UIPracticeCycle> archived;
  final bool loading;
}

class CycleArchiveCubit extends Cubit<CycleArchiveState> {
  CycleArchiveCubit({required WatchCycleArchiveUseCase watchCycleArchive})
      : super(const CycleArchiveState()) {
    _sub = watchCycleArchive().listen((snapshot) {
      emit(
        CycleArchiveState(
          active: snapshot.active,
          archived: snapshot.archived,
          loading: false,
        ),
      );
    });
  }

  StreamSubscription<CycleArchiveSnapshot>? _sub;

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
