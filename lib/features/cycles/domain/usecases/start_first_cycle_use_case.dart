import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/cycles/domain/repositories/cycle_repository.dart';

class StartFirstCycleUseCase {
  StartFirstCycleUseCase(this._cycles);

  final CycleRepository _cycles;

  Future<void> call({DateTime? anchor}) async {
    if (await _cycles.hasAnyCycle()) return;

    final startedAt = WeekDateUtils.startOfWeek(anchor ?? DateTime.now());
    await _cycles.createCycle(startedAt: startedAt, sequenceNumber: 1);
  }
}
