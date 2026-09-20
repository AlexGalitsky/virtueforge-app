import 'package:virtue_forge/features/library/domain/models/stoic_quote.dart';

abstract class QuotesRepository {
  /// Locale-aware quote list (network → disk cache → assets fallback).
  Future<List<StoicQuote>> loadQuotes(String localeCode);

  /// Deterministic daily quote. Prefers [focusWeekNumber] tags when set.
  Future<StoicQuote?> quoteOfDay({
    required String localeCode,
    DateTime? date,
    int? focusWeekNumber,
  });
}
