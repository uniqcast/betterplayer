import 'dart:js_util' as js_util;

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
    final milliseconds = time.truncate();
    duration = Duration(milliseconds: milliseconds);
  }
  return duration;
}

Object mapToJsObject(Map map) {
  final object = js_util.newObject();
  map.forEach((k, v) {
    if (v is Map) {
      js_util.setProperty(object, k, mapToJsObject(v));
    } else {
      js_util.setProperty(object, k, v);
    }
  });
  return object;
}
