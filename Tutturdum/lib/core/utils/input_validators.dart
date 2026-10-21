/// Form ve alan doğrulayıcı yardımcı sınıf
abstract class InputValidators {
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName alanı boş bırakılamaz';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'E-posta adresi zorunludur';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value.trim())) {
      return 'Geçerli bir e-posta adresi giriniz';
    }
    return null;
  }

  static String? validateTcNo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'TC Kimlik Numarası zorunludur';
    }
    final trimmed = value.trim();
    if (trimmed.length != 11 || !RegExp(r'^[0-9]+$').hasMatch(trimmed)) {
      return 'TC Kimlik Numarası 11 haneli rakamlardan oluşmalıdır';
    }
    if (trimmed.startsWith('0')) {
      return 'TC Kimlik Numarası 0 ile başlayamaz';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Telefon numarası zorunludur';
    }
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length < 10 || digits.length > 11) {
      return 'Geçerli bir telefon numarası giriniz (örn: 05xx xxx xx xx)';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre zorunludur';
    }
    if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Şifre tekrarı zorunludur';
    }
    if (value != originalPassword) {
      return 'Şifreler birbiriyle eşleşmiyor';
    }
    return null;
  }

  static String? validateBetAmount(String? value, double currentBalance) {
    if (value == null || value.trim().isEmpty) {
      return 'Bahis tutarı giriniz';
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed <= 0) {
      return 'Geçerli bir tutar giriniz';
    }
    if (parsed < 50.0) {
      return 'Minimum bahis tutarı 50 ₺ dir';
    }
    if (parsed > currentBalance) {
      return 'Yetersiz bakiye! Mevcut: ${currentBalance.toStringAsFixed(2)} ₺';
    }
    return null;
  }
}
