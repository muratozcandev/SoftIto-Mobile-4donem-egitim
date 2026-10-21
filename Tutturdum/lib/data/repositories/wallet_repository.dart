import 'package:flutter/foundation.dart';
import '../../core/storage/local_storage_service.dart';
import '../../core/constants/app_constants.dart';

/// Sanal Bakiye Repository (Tek Doğruluk Kaynağı / Single Source of Truth)
class WalletRepository {
  static final WalletRepository instance = WalletRepository._internal();
  WalletRepository._internal();

  final ValueNotifier<double> balanceNotifier = ValueNotifier<double>(AppConstants.initialDemoBalance);

  double get balance => balanceNotifier.value;

  Future<void> init() async {
    final saved = LocalStorageService.instance.getDouble(AppConstants.keyVirtualBalance);
    if (saved != null) {
      balanceNotifier.value = saved;
    } else {
      balanceNotifier.value = AppConstants.initialDemoBalance;
      await LocalStorageService.instance.setDouble(AppConstants.keyVirtualBalance, AppConstants.initialDemoBalance);
    }
  }

  /// Bakiye yükleme simülasyonu
  Future<bool> deposit(double amount) async {
    if (amount <= 0) return false;
    final newBalance = balanceNotifier.value + amount;
    balanceNotifier.value = double.parse(newBalance.toStringAsFixed(2));
    await LocalStorageService.instance.setDouble(AppConstants.keyVirtualBalance, balanceNotifier.value);
    return true;
  }

  /// Kupon oynama bakiye düşümü
  Future<bool> deduct(double amount) async {
    if (amount <= 0 || amount > balanceNotifier.value) return false;
    final newBalance = balanceNotifier.value - amount;
    balanceNotifier.value = double.parse(newBalance.toStringAsFixed(2));
    await LocalStorageService.instance.setDouble(AppConstants.keyVirtualBalance, balanceNotifier.value);
    return true;
  }

  /// Bakiye sıfırlama / test amaçlı
  Future<void> resetBalance() async {
    balanceNotifier.value = AppConstants.initialDemoBalance;
    await LocalStorageService.instance.setDouble(AppConstants.keyVirtualBalance, AppConstants.initialDemoBalance);
  }
}
