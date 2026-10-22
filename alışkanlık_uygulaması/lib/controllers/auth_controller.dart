import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class AuthController extends ChangeNotifier {
  static final AuthController instance = AuthController._internal();
  AuthController._internal();

  bool _isLoggedIn = true; // Prototipte kullanıcı başlangıçta oturum açmış olarak başlar, çıkış yapılabilir
  UserProfile _user = UserProfile.defaultUser();

  bool get isLoggedIn => _isLoggedIn;
  UserProfile get user => _user;

  String? login({required String identifier, required String password}) {
    if (identifier.trim().isEmpty) {
      return 'Lütfen e-posta veya telefon numaranızı girin.';
    }
    if (password.trim().isEmpty) {
      return 'Lütfen şifrenizi girin.';
    }
    if (password.length < 4) {
      return 'Şifre en az 4 karakter olmalıdır.';
    }

    _isLoggedIn = true;
    _user = _user.copyWith(emailOrPhone: identifier.trim());
    notifyListeners();
    return null; // Başarılı
  }

  String? register({
    required String fullName,
    required String identifier,
    required String password,
    required bool termsAccepted,
    required bool kvkkAccepted,
  }) {
    if (fullName.trim().isEmpty) {
      return 'Lütfen adınızı ve soyadınızı girin.';
    }
    if (identifier.trim().isEmpty) {
      return 'Lütfen geçerli bir e-posta veya telefon girin.';
    }
    if (password.length < 4) {
      return 'Şifre en az 4 karakter olmalıdır.';
    }
    if (!termsAccepted) {
      return 'Lütfen Kullanıcı Sözleşmesini onaylayın.';
    }
    if (!kvkkAccepted) {
      return 'Lütfen KVKK Aydınlatma Metnini onaylayın.';
    }

    _user = _user.copyWith(
      fullName: fullName.trim(),
      emailOrPhone: identifier.trim(),
    );
    notifyListeners();
    return null; // Başarılı kayıt
  }

  void updateProfile({String? fullName, String? emailOrPhone}) {
    _user = _user.copyWith(
      fullName: fullName,
      emailOrPhone: emailOrPhone,
    );
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
