extension IsSameDate on DateTime {
  /// Return `true` if the dates are equal.
  /// Only comparing [day], [month] and [year].
  bool isSameDate(DateTime other) {
    return day == other.day && month == other.month && year == other.year;
  }
}
