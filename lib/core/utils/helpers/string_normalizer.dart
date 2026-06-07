class StringNormalizer {
  /// Normalizes Arabic strings by handling common character variations
  /// and English strings by trimming and lowercasing.
  static String normalize(String? text) {
    if (text == null) return '';
    return text
        .trim()
        .toLowerCase()
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي');
  }

  /// Checks if the gender string refers to Male in a robust way.
  static bool isMale(String? gender) {
    final normalized = normalize(gender);
    return normalized == 'male' || normalized == 'ذكر' || normalized == 'man';
  }

  /// Checks if the nationality string refers to Saudi in a robust way.
  static bool isSaudi(String? nationality) {
    final normalized = normalize(nationality);
    return normalized == 'saudi' || normalized == 'سعودي';
  }

  /// Checks if the city string refers to Jeddah in a robust way.
  static bool isJeddah(String? city) {
    final normalized = normalize(city);
    return normalized == 'jeddah' || normalized == 'جده';
  }

  /// Checks if the attendance type refers to check-in in a robust way.
  static bool isCheckIn(String? type) {
    final normalized = normalize(type);
    return normalized == 'checked in' ||
        normalized == 'تم تسجيل الوصول' ||
        normalized == 'check_in';
  }
}
