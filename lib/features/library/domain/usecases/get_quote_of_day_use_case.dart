import 'package:virtue_forge/features/library/domain/models/stoic_quote.dart';
import 'package:virtue_forge/features/library/domain/repositories/quotes_repository.dart';

class GetQuoteOfDayUseCase {
  GetQuoteOfDayUseCase(this._quotes);

  final QuotesRepository _quotes;

  Future<StoicQuote?> call({
    required String localeCode,
    DateTime? date,
    int? focusWeekNumber,
  }) {
    return _quotes.quoteOfDay(
      localeCode: localeCode,
      date: date,
      focusWeekNumber: focusWeekNumber,
    );
  }
}
