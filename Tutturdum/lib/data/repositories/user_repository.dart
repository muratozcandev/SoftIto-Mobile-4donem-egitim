import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../models/user_model.dart';
import '../../core/storage/local_storage_service.dart';
import '../../core/constants/app_constants.dart';

/// Kullanıcı kimlik doğrulama ve kayıt repository'si
class UserRepository {
  static final UserRepository instance = UserRepository._internal();
  UserRepository._internal();

  UserModel? _currentUser;
  final List<UserModel> _registeredUsers = [];

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  Future<void> init() async {
    // Kayıtlı demo kullanıcıları başlat
    if (_registeredUsers.isEmpty) {
      _registeredUsers.add(UserModel(
        id: 'demo_user_1',
        fullName: 'Ahmet Yılmaz',
        tcNo: '12345678901',
        phone: '05551234567',
        email: 'demo@tutturdum.com',
        passwordHash: _hashPassword('123456'),
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ));
    }

    // Yerel depolamadan aktif kullanıcıyı yükle
    final savedUserJson = LocalStorageService.instance.getString(AppConstants.keyCurrentUser);
    if (savedUserJson != null) {
      try {
        final map = jsonDecode(savedUserJson) as Map<String, dynamic>;
        _currentUser = UserModel.fromJson(map);
      } catch (_) {
        _currentUser = null;
      }
    }
  }

  /// Şifre hashleme simülasyonu (SHA-256)
  String _hashPassword(String password) {
    final bytes = utf8.encode('tutturdum_salt_$password');
    return sha256.convert(bytes).toString();
  }

  /// Giriş Yap (TC No veya E-posta ile)
  Future<UserModel?> login({required String identifier, required String password}) async {
    final trimmedId = identifier.trim().toLowerCase();
    final hash = _hashPassword(password);

    for (final user in _registeredUsers) {
      if ((user.email.toLowerCase() == trimmedId || user.tcNo == identifier.trim()) &&
          user.passwordHash == hash) {
        _currentUser = user;
        await LocalStorageService.instance.setString(
          AppConstants.keyCurrentUser,
          jsonEncode(user.toJson()),
        );
        return user;
      }
    }
    return null;
  }

  /// Demo hesapla hızlı giriş
  Future<UserModel> loginWithDemoAccount() async {
    final demo = _registeredUsers.first;
    _currentUser = demo;
    await LocalStorageService.instance.setString(
      AppConstants.keyCurrentUser,
      jsonEncode(demo.toJson()),
    );
    return demo;
  }

  /// Yeni Kullanıcı Kaydı
  Future<UserModel> register({
    required String fullName,
    required String tcNo,
    required String phone,
    required String email,
    required String password,
  }) async {
    final trimmedTc = tcNo.trim();
    final trimmedEmail = email.trim().toLowerCase();

    // Çift kayıt kontrolü
    for (final user in _registeredUsers) {
      if (user.tcNo == trimmedTc) {
        throw Exception('Bu TC Kimlik Numarası ile zaten kayıtlı bir hesap var.');
      }
      if (user.email.toLowerCase() == trimmedEmail) {
        throw Exception('Bu e-posta adresi ile zaten kayıtlı bir hesap var.');
      }
    }

    final newUser = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      fullName: fullName.trim(),
      tcNo: trimmedTc,
      phone: phone.trim(),
      email: trimmedEmail,
      passwordHash: _hashPassword(password),
      createdAt: DateTime.now(),
    );

    _registeredUsers.add(newUser);
    return newUser;
  }

  /// Çıkış Yap
  Future<void> logout() async {
    _currentUser = null;
    await LocalStorageService.instance.remove(AppConstants.keyCurrentUser);
  }
}
