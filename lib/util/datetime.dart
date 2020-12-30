class DateTimeUtil {
  static DateTime addMonths(DateTime dt, int months) {
    int year = dt.year;
    int month = dt.month;
    for (int i = 0; i < months; i++) {
      month++;

      if (month > 12) {
        month = month - 12;
        year++;
      }
    }
    return DateTime(year, month);
  }

  static DateTime removeMonths(DateTime dt, int months) {
    int year = dt.year;
    int month = dt.month;
    for (int i = 0; i < months; i++) {
      month--;

      if (month < 1) {
        month = month + 12;
        year--;
      }
    }
    return DateTime(year, month);
  }
}
