import 'package:virtue_forge/features/cycles/domain/services/focus_resolver.dart';

abstract class FocusShiftRepository {
  FocusShift? load();

  Stream<FocusShift?> watch();

  Future<void> save(FocusShift shift);

  Future<void> clear();
}
