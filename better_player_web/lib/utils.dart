Duration parseDuration(dynamic value) {
  Duration duration;
  final time = value is num
      ? value
      : value is String
          ? num.tryParse(value) ?? 0
          : 0;
  if (!time.isFinite) {
    duration = const Duration(days: 365);
  } else {
    final seconds = time.truncate();
    final milliseconds = ((time - seconds) * 1000).truncate();
    duration = Duration(seconds: seconds, milliseconds: milliseconds);
  }
  return duration;
}
