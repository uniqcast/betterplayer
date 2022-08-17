Duration parseDuration(dynamic num) {
  Duration duration;
  final time = double.tryParse(num) ?? 0;
  if (!time.isFinite) {
    duration = const Duration(days: 365);
  } else {
    final seconds = time.truncate();
    final milliseconds = ((time - seconds) * 1000).truncate();
    duration = Duration(seconds: seconds, milliseconds: milliseconds);
  }
  return duration;
}
