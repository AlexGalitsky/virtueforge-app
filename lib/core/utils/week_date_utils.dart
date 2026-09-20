/// Утилиты для нормализации дат и ISO-недель (понедельник — старт недели).
///
/// Фокус добродетели Франклина считается через [CycleCalculator]
/// от якоря практики, не от номера ISO-недели.
abstract final class WeekDateUtils {
  /// Обнуляет время: оставляет только год-месяц-день.
  static DateTime normalizeDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  /// Понедельник текущей ISO-недели для [date].
  static DateTime startOfWeek(DateTime date) {
    final normalized = normalizeDate(date);
    // DateTime.weekday: Mon=1 … Sun=7
    return normalized.subtract(Duration(days: normalized.weekday - 1));
  }

  /// Индекс дня в неделе: 0 = Пн … 6 = Вс. Или -1, если вне диапазона.
  static int dayIndexInWeek(DateTime date, DateTime weekStart) {
    final normalized = normalizeDate(date);
    final start = normalizeDate(weekStart);
    final index = normalized.difference(start).inDays;
    if (index < 0 || index > 6) return -1;
    return index;
  }
}
