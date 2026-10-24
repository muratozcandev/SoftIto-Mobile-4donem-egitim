<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: auth_controller.dart
// Görev: Kullanıcı oturum açma (login), kayıt olma (register) ve oturum kapatma
// (logout) süreçlerini ve form doğrulama mantığını yönetir.
// Açıklama: Proje şartnamesi uyarınca backend ve harici veritabanı kullanılmaz;
// oturum durumu bellek içi (in-memory) ValueNotifier ile reaktif yönetilir.
// ==============================================================================

import 'package:flutter/material.dart';

/// [UserModel] sınıfı, oturum açmış kullanıcıya ait temel profil verilerini temsil eder.
@immutable
class UserModel {
  /// Kullanıcının adı ve soyadı
  final String fullName;

  /// Kullanıcının iletişim e-posta adresi
  final String email;

  /// Kullanıcının cep telefonu numarası
  final String phone;

  /// Kullanıcının üyelik tipi (Standart, VIP, Gold vb.)
  final String membershipTier;

  /// Değişmez kurucu metot
  const UserModel({
    required this.fullName,
    required this.email,
    required this.phone,
    this.membershipTier = 'AraÇek VIP Üye',
  });
}

/// [AuthController] sınıfı, kimlik doğrulama işlemlerini ve oturum durumunu yönetir.
class AuthController {
  // ---------------------------------------------------------------------------
  // Tekil Örnek (Singleton Deseni)
  // ---------------------------------------------------------------------------
  /// Tüm ekranlardan aynı oturum verisine erişebilmek için tekil örnek kullanılır.
  static final AuthController instance = AuthController._internal();

  /// Özel kurucu metot
  AuthController._internal();

  // ---------------------------------------------------------------------------
  // Reaktif Durum Değişkenleri
  // ---------------------------------------------------------------------------
  /// Aktif oturum açmış kullanıcıyı saklayan [ValueNotifier].
  /// Başlangıçta oturum açılmamışsa 'null' değerini alır.
  final ValueNotifier<UserModel?> currentUserNotifier =
      ValueNotifier<UserModel?>(
    // Varsayılan olarak prototip akışını hızlı test edebilmek için hazır profil tanımlıyoruz.
    const UserModel(
      fullName: 'Murat Yılmaz',
      email: 'murat@aracek.com',
      phone: '0555 123 45 67',
    ),
  );

  /// Kullanıcının oturumunun açık olup olmadığını kontrol eden yardımcı getter.
  bool get isAuthenticated => currentUserNotifier.value != null;

  /// Oturum açmış aktif kullanıcının adını döner, yoksa 'Misafir' döner.
  String get currentUserName =>
      currentUserNotifier.value?.fullName ?? 'Misafir';

  // ---------------------------------------------------------------------------
  // Oturum İşlem Metotları (Simülasyon)
  // ---------------------------------------------------------------------------
  /// Kullanıcı girişi simülasyonu.
  /// Form geçerli olduğunda örnek kullanıcı profili oluşturur ve oturumu açar.
  bool login({
    required String emailOrPhone,
    required String password,
  }) {
    // Şifre ve e-posta temel kontrolleri
    if (emailOrPhone.trim().isEmpty || password.length < 6) {
      return false;
    }

    // Başarılı giriş simülasyonu: Kullanıcı modelini güncelliyoruz
    currentUserNotifier.value = UserModel(
      fullName: 'Murat Yılmaz',
      email: emailOrPhone.contains('@') ? emailOrPhone : 'murat@aracek.com',
      phone: emailOrPhone.contains('@') ? '0555 123 45 67' : emailOrPhone,
    );
    return true;
  }

  /// Yeni kullanıcı kaydı simülasyonu.
  /// Kayıt bilgilerini alarak aktif kullanıcıyı günceller ve ana sayfaya yönlendirir.
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
  bool register({
    required String fullName,
    required String email,
    required String phone,
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
    required String password,
  }) {
    // Temel form kontrolleri
    if (fullName.trim().isEmpty ||
        email.trim().isEmpty ||
        phone.trim().isEmpty ||
        password.length < 6) {
      return false;
    }

    // Yeni kullanıcı nesnesi oluşturularak reaktif duruma atanır
    currentUserNotifier.value = UserModel(
      fullName: fullName.trim(),
      email: email.trim(),
      phone: phone.trim(),
    );
    return true;
  }

  /// Oturumu kapatır ve kullanıcıyı giriş ekranına döndürür.
  void logout() {
    currentUserNotifier.value = null;
  }

  // ---------------------------------------------------------------------------
  // Form Doğrulama (Validator) Yardımcıları
  // ---------------------------------------------------------------------------
  /// Zorunlu alan kontrolü: Boş veya yalnızca boşluk girilmesini engeller.
  static String? validateRequired(String? value, String errorMessage) {
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
    if (value == null || value.trim().isEmpty) {
      return errorMessage;
    }
    return null;
  }

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
  /// E-posta veya telefon numarası formatı kontrolü.
  static String? validateEmailOrPhone(String? value, String errorMessage) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage;
    }
    final trimmed = value.trim();
    final bool isEmail = trimmed.contains('@') && trimmed.contains('.');
    final bool isPhone = RegExp(r'^[0-9\s\+\-]{10,15}$').hasMatch(trimmed);

    if (!isEmail && !isPhone) {
      return errorMessage;
=======
>>>>>>> Stashed changes
  /// E-posta veya telefon biçimi kontrolü için doğrulayıcı
  String? validateIdentifier(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Lütfen e-posta veya telefon giriniz';
    }
    if (value.length < 5) {
      return 'Geçerli bir iletişim bilgisi giriniz';
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
    }
    return null;
  }

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
  /// Şifre uzunluğu kontrolü (en az 6 karakter).
  static String? validatePassword(String? value, String errorMessage) {
    if (value == null || value.trim().length < 6) {
      return errorMessage;
=======
>>>>>>> Stashed changes
  /// Şifre uzunluğu doğrulayıcı (Minimum 6 karakter)
  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Şifre alanı boş bırakılamaz';
    }
    if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır';
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
    }
    return null;
  }
}
