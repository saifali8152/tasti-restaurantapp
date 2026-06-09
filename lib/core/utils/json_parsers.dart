int parseJsonInt(dynamic value, [int fallback = 0]) {
  if (value == null) return fallback;
  if (value is int) return value;
  return int.tryParse(value.toString()) ?? fallback;
}

double parseJsonDouble(dynamic value, [double fallback = 0.0]) {
  if (value == null || value.toString().isEmpty) return fallback;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? fallback;
}

bool parseJsonBool(dynamic value, [bool fallback = false]) {
  if (value == null) return fallback;
  if (value is bool) return value;
  if (value is int) return value != 0;
  final normalized = value.toString().toLowerCase();
  return normalized == '1' || normalized == 'true';
}

String parseJsonString(dynamic value, [String fallback = '']) {
  if (value == null) return fallback;
  return value.toString();
}
