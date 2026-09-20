import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtue_forge/features/cycles/domain/models/cycle_detail_snapshot.dart';
import 'package:virtue_forge/features/cycles/domain/usecases/load_cycle_detail_use_case.dart';

sealed class CycleDetailState {
  const CycleDetailState();
}

class CycleDetailLoading extends CycleDetailState {
  const CycleDetailLoading();
}

class CycleDetailFailure extends CycleDetailState {
  const CycleDetailFailure(this.message);
  final String message;
}

class CycleDetailLoaded extends CycleDetailState {
  const CycleDetailLoaded(this.snapshot);
  final CycleDetailSnapshot snapshot;
}

class CycleDetailCubit extends Cubit<CycleDetailState> {
  CycleDetailCubit(this._load) : super(const CycleDetailLoading());

  final LoadCycleDetailUseCase _load;

  Future<void> load(int cycleId) async {
    emit(const CycleDetailLoading());
    try {
      final snapshot = await _load(cycleId);
      if (snapshot == null) {
        emit(const CycleDetailFailure('Cycle not found'));
        return;
      }
      emit(CycleDetailLoaded(snapshot));
    } catch (e) {
      emit(CycleDetailFailure(e.toString()));
    }
  }
}
