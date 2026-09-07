class DateTimeUtils {
  static DateTime parse(dynamic date) {
    if (date == null) return DateTime.now();
    if (date is int) return DateTime.fromMillisecondsSinceEpoch(date);
    if (date is DateTime) return date;

    try {
      return DateTime.parse(date.toString());
    } catch (_) {
      return DateTime.now();
    }
  }
}
