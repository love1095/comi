import 'package:intl/intl.dart';

/// Money is integer VND everywhere (§1, §17.1).
/// vi: `150.000 ₫` · other languages: `150,000 VND`.
String formatVnd(num amount, {String locale = 'vi'}) {
  final rounded = amount.round();
  if (locale == 'vi') {
    return '${NumberFormat.decimalPattern('vi').format(rounded)} ₫';
  }
  return '${NumberFormat.decimalPattern('en').format(rounded)} VND';
}

/// Minutes from midnight → `HH:mm` (24-hour). 1500 → `01:00` (after midnight).
String formatMinute(int minuteOfDay) {
  final m = minuteOfDay % 1440;
  return '${(m ~/ 60).toString().padLeft(2, '0')}:${(m % 60).toString().padLeft(2, '0')}';
}

/// Restaurant local time. Launch city is Vietnam (UTC+7, no DST); other zones
/// come with the API's `timezone` field later.
DateTime toVietnamTime(DateTime utc) => utc.toUtc().add(const Duration(hours: 7));

/// `12:15` in Vietnam time for an ISO/UTC instant.
String formatLocalTime(DateTime utc) {
  final t = toVietnamTime(utc);
  return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

/// `YYYY-MM-DD` of "today + days" in Vietnam.
String vietnamDate({int days = 0, DateTime? now}) {
  final t = toVietnamTime(now ?? DateTime.now()).add(Duration(days: days));
  return '${t.year.toString().padLeft(4, '0')}-${t.month.toString().padLeft(2, '0')}-${t.day.toString().padLeft(2, '0')}';
}
