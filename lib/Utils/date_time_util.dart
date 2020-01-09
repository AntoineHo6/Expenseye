class DateTimeUtil {

  static const Map<int, String> monthAbb = {
    1: 'Jan.',
    2: 'Feb.',
    3: 'Mar.',
    4: 'Apr.',
    5: 'May.',
    6: 'Jun.',
    7: 'jul.',
    8: 'Aug.',
    9: 'Sep.',
    10: 'Oct.',
    11: 'Nov.',
    12: 'Dec.'
  };

  // Keep DateTimes throughout the app uniform.
  // Only dates. No time. Local.
  // TODO: rename to removeTime
  static DateTime cleanDateTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}