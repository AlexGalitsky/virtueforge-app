import 'package:virtue_forge/core/utils/week_date_utils.dart';
import 'package:virtue_forge/features/journal/domain/repositories/catalog_repository.dart';
import 'package:virtue_forge/features/profile_progress/data/temple_dust_repository.dart';
import 'package:virtue_forge/features/profile_progress/domain/repositories/xp_ledger_repository.dart';

/// Settles Temple dust after a long absence, then records this visit as activity.
class ApplyTempleDustUseCase {
  ApplyTempleDustUseCase({
    required TempleDustRepository dustRepository,
    required XpLedgerRepository ledger,
    required CatalogRepository catalog,
  })  : _dust = dustRepository,
        _ledger = ledger,
        _catalog = catalog;

  final TempleDustRepository _dust;
  final XpLedgerRepository _ledger;
  final CatalogRepository _catalog;

  Future<TempleDustNotice?> call({DateTime? now}) async {
    final at = now ?? DateTime.now();
    final days = _dust.dustDaysIfSettlingAt(at);

    if (days <= 0) {
      await _dust.recordActivity(at);
      return null;
    }

    final last = _dust.lastActivityAt ?? at;
    final firstDustDay = WeekDateUtils.normalizeDate(
      last.add(const Duration(hours: TempleDustRepository.graceHours)),
    );

    final categories = await _catalog.watchCategories().first;
    await _ledger.appendDustEvents(
      categoryIds: categories.map((c) => c.id).toList(),
      days: days,
      firstDustDay: firstDustDay,
      xpPerDay: TempleDustRepository.xpPerDayPerPillar,
    );

    final notice = TempleDustNotice(
      days: days,
      xpLostPerPillar: days * TempleDustRepository.xpPerDayPerPillar,
    );
    await _dust.setPendingNotice(notice);
    await _dust.recordActivity(at);
    return notice;
  }

  /// Debug helper: force exactly [dustDays] of Temple dust settlement.
  Future<TempleDustNotice?> simulateDustDays({int dustDays = 5}) async {
    final at = DateTime.now();
    // dustDays = (afterGrace.inHours ~/ 24) + 1
    final hoursAway =
        TempleDustRepository.graceHours + (dustDays - 1) * 24 + 1;
    await _dust.recordActivity(at.subtract(Duration(hours: hoursAway)));
    return call(now: at);
  }
}
