class DateTimeUtil {

  // Keep DateTimes throughout the app uniform.
  // Only dates. No time.
  static DateTime cleanDateTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}