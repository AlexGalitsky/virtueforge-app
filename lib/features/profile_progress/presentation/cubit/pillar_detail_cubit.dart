import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtue_forge/features/profile_progress/domain/usecases/load_pillar_detail_use_case.dart';

sealed class PillarDetailState {
  const PillarDetailState();
}

class PillarDetailLoading extends PillarDetailState {
  const PillarDetailLoading();
}

class PillarDetailFailure extends PillarDetailState {
  const PillarDetailFailure(this.message);
  final String message;
}

class PillarDetailLoaded extends PillarDetailState {
  const PillarDetailLoaded(this.snapshot);
  final PillarDetailSnapshot snapshot;
}

class PillarDetailCubit extends Cubit<PillarDetailState> {
  PillarDetailCubit(this._load) : super(const PillarDetailLoading());

  final LoadPillarDetailUseCase _load;

  Future<void> load(int categoryId) async {
    emit(const PillarDetailLoading());
    try {
      final snapshot = await _load(categoryId);
      if (snapshot == null) {
        emit(const PillarDetailFailure('Pillar not found'));
        return;
      }
      emit(PillarDetailLoaded(snapshot));
    } catch (e) {
      emit(PillarDetailFailure(e.toString()));
    }
  }
}
