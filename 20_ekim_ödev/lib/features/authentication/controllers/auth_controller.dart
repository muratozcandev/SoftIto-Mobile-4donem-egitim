import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

/// [AuthController] sınıfı, kullanıcının giriş yapma, kayıt olma,
/// oturum durumu ve profil bilgilerini yöneten merkezi kontrolcüdür.
class AuthController {
  // Singleton deseni: Tüm uygulama boyunca oturum bilgisini tek elden yönetir
  AuthController._internal();
  static final AuthController instance = AuthController._internal();

  /// Kullanıcının giriş yapıp yapmadığını bildiren reaktif durum nesnesi
  final ValueNotifier<bool> isLoggedInNotifier = ValueNotifier<bool>(true);

  /// Aktif oturum açmış kullanıcı nesnesini tutan reaktif bildirim
  final ValueNotifier<User> currentUserNotifier =
      ValueNotifier<User>(User.demoUser);

  /// Aktif kullanıcı getter'ı
  User get currentUser => currentUserNotifier.value;

  /// Kullanıcı girişi simülasyonu:
  /// Verilen e-posta/telefon ve şifre geçerli ise oturumu açar.
  bool login({required String identifier, required String password}) {
    if (identifier.trim().isEmpty || password.trim().isEmpty) {
      return false;
    }
    // Örnek kullanıcı ile oturumu aktifleştirir
    isLoggedInNotifier.value = true;
    return true;
  }

  /// Yeni kullanıcı kaydı simülasyonu:
  /// Girilen bilgilerle yeni bir kullanıcı profili oluşturup oturumu açar.
  bool register({
    required String fullName,
    required String email,
    required String phone,
    required int licenseYears,
    required String password,
  }) {
    if (fullName.isEmpty || email.isEmpty || phone.isEmpty) {
      return false;
    }

    final newUser = User(
      fullName: fullName,
      email: email,
      phone: phone,
      licenseYears: licenseYears,
      memberLevel: 'Yeni Üye',
    );

    currentUserNotifier.value = newUser;
    isLoggedInNotifier.value = true;
    return true;
  }

  /// Oturumu kapatma (Logout) metodu:
  /// Kullanıcıyı çıkış yaptırarak giriş ekranına yönlendirir.
  void logout() {
    isLoggedInNotifier.value = false;
  }

  /// Zorunlu alan kontrolü için yardımcı doğrulayıcı (Validator)
  String? validateRequired(String? value, String errorMessage) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage;
    }
    return null;
  }

  /// E-posta veya telefon biçimi kontrolü için doğrulayıcı
  String? validateIdentifier(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Lütfen e-posta veya telefon giriniz';
    }
    if (value.length < 5) {
      return 'Geçerli bir iletişim bilgisi giriniz';
    }
    return null;
  }

  /// Şifre uzunluğu doğrulayıcı (Minimum 6 karakter)
  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Şifre alanı boş bırakılamaz';
    }
    if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır';
    }
    return null;
  }
}
