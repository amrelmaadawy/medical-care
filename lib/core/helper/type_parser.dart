class TypeParser {
  static int? parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is bool) return value ? 1 : 0;
    if (value is double) return value.toInt();
    return null;
  }

  static String? parseString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is bool && !value) return null; // API often returns false for empty strings
    return value.toString();
  }

  static List<T>? parseList<T>(dynamic value) {
    if (value == null) return null;
    if (value is List) return value.cast<T>();
    if (value is bool && !value) return [];
    return null;
  }

  static Map<String, dynamic>? parseMap(dynamic value) {
    if (value == null) return null;
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    if (value is bool && !value) return null;
    return null;
  }
}
