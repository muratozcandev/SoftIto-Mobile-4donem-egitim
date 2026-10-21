import 'package:flutter/foundation.dart';
import '../../../data/models/coupon_models.dart';
import '../../../data/repositories/wallet_repository.dart';
import '../../../data/repositories/coupon_repository.dart';
import '../../../core/utils/id_generator.dart';
import '../../../core/constants/app_constants.dart';

/// Kupon Sepeti ve Bahis Hesaplama Yöneticisi (Merkezi Durum)
class CouponCartController extends ChangeNotifier {
  static final CouponCartController instance = CouponCartController._internal();
  CouponCartController._internal();

  final List<CouponSelection> _selections = [];
  double _stake = AppConstants.minBetAmount; // Varsayılan 50 ₺

  List<CouponSelection> get selections => List.unmodifiable(_selections);
  int get itemCount => _selections.length;
  bool get isEmpty => _selections.isEmpty;
  double get stake => _stake;

  /// Toplam Oran Hesaplaması (Bütün oranların çarpımı)
  double get totalOdds {
    if (_selections.isEmpty) return 0.0;
    double odds = 1.0;
    for (final s in _selections) {
      odds *= s.odds;
    }
    return double.parse(odds.toStringAsFixed(2));
  }

  /// Olası Brüt Dönüş (Bahis Tutarı x Toplam Oran)
  double get possibleWin {
    if (_selections.isEmpty) return 0.0;
    final win = _stake * totalOdds;
    return double.parse(win.toStringAsFixed(2));
  }

  /// Olası Net Kazanç (Brüt Dönüş - Bahis Tutarı)
  double get possibleNetProfit {
    if (_selections.isEmpty) return 0.0;
    final net = possibleWin - _stake;
    return double.parse(net.clamp(0, double.infinity).toStringAsFixed(2));
  }

  /// Bahis tutarını güncelle
  void setStake(double amount) {
    _stake = amount;
    notifyListeners();
  }

  /// Seçimin sepette olup olmadığını kontrol eder
  bool isSelected(String matchId, String marketName, String selectionName) {
    return _selections.any((s) =>
        s.matchId == matchId &&
        s.marketName == marketName &&
        s.selectionName == selectionName);
  }

  /// Sepete oran ekle / varsa kaldır (Toggle)
  void toggleSelection(CouponSelection selection) {
    final existingIndex = _selections.indexWhere((s) =>
        s.matchId == selection.matchId &&
        s.marketName == selection.marketName &&
        s.selectionName == selection.selectionName);

    if (existingIndex != -1) {
      _selections.removeAt(existingIndex);
    } else {
      // Aynı maçın aynı pazarındaki diğer seçimi güncelle (Örn: MS 1 varken MS 2 seçilirse değiştir)
      _selections.removeWhere((s) =>
          s.matchId == selection.matchId && s.marketName == selection.marketName);
      _selections.add(selection);
    }
    notifyListeners();
  }

  /// Tekil seçimi sepetten kaldır
  void removeSelection(String selectionId) {
    _selections.removeWhere((s) => s.id == selectionId);
    notifyListeners();
  }

  /// Sepeti tamamen temizle
  void clearCart() {
    _selections.clear();
    _stake = AppConstants.minBetAmount;
    notifyListeners();
  }

  /// Kuponu Oyna İşlemi
  Future<CouponModel> playCoupon() async {
    if (_selections.isEmpty) {
      throw Exception('Sepetinizde maç bulunmuyor.');
    }
    if (_stake < AppConstants.minBetAmount) {
      throw Exception('Minimum bahis tutarı ${AppConstants.minBetAmount.toStringAsFixed(0)} ₺ olmalıdır.');
    }

    final currentBalance = WalletRepository.instance.balance;
    if (currentBalance < _stake) {
      throw Exception('Yetersiz sanal bakiye! Mevcut: ${currentBalance.toStringAsFixed(2)} ₺');
    }

    // Bakiyeden düş
    final deducted = await WalletRepository.instance.deduct(_stake);
    if (!deducted) {
      throw Exception('Bakiye düşümü sırasında bir hata oluştu.');
    }

    // Yeni kupon oluştur
    final coupon = CouponModel(
      id: IdGenerator.generateCouponId(),
      createdAt: DateTime.now(),
      selections: List.from(_selections),
      totalOdds: totalOdds,
      stake: _stake,
      possibleWin: possibleWin,
      status: 'Simülasyon',
    );

    // Geçmişe kaydet
    await CouponRepository.instance.saveCoupon(coupon);

    // Sepeti temizle
    clearCart();

    return coupon;
  }
}
