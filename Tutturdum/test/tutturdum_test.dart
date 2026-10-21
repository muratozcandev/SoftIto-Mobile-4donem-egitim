import 'package:flutter_test/flutter_test.dart';
import 'package:tutturdum/core/utils/input_validators.dart';
import 'package:tutturdum/data/demo/demo_leagues.dart';
import 'package:tutturdum/data/demo/demo_teams.dart';
import 'package:tutturdum/data/demo/demo_matches.dart';
import 'package:tutturdum/data/models/coupon_models.dart';
import 'package:tutturdum/data/repositories/wallet_repository.dart';
import 'package:tutturdum/data/repositories/coupon_repository.dart';
import 'package:tutturdum/features/coupon_cart/controllers/coupon_cart_controller.dart';

void main() {
  group('1. Form ve Doğrulama Testleri', () {
    test('Zorunlu alan doğrulayıcısı boş metni reddetmelidir', () {
      expect(InputValidators.validateRequired('', 'Ad'), isNotNull);
      expect(InputValidators.validateRequired('   ', 'Ad'), isNotNull);
      expect(InputValidators.validateRequired('Ahmet', 'Ad'), isNull);
    });

    test('TC Kimlik No doğrulayıcısı 11 haneli ve sıfırla başlamayan olmalıdır', () {
      expect(InputValidators.validateTcNo('12345'), isNotNull);
      expect(InputValidators.validateTcNo('01234567890'), isNotNull);
      expect(InputValidators.validateTcNo('12345678901'), isNull);
    });

    test('E-posta formatı doğru kontrol edilmelidir', () {
      expect(InputValidators.validateEmail('invalid-email'), isNotNull);
      expect(InputValidators.validateEmail('test@domain.com'), isNull);
    });

    test('Şifre minimum 6 karakter olmalıdır', () {
      expect(InputValidators.validatePassword('12345'), isNotNull);
      expect(InputValidators.validatePassword('123456'), isNull);
    });
  });

  group('2. Futbol ve Lig Veri Tutarlılığı Testleri', () {
    test('11 adet desteklenen lig tanımlı olmalıdır', () {
      expect(DemoLeagues.leagues.length, equals(11));
    });

    test('Süper Lig 18 takıma sahip olmalıdır', () {
      final teams = DemoTeams.getTeamsForLeague('super_lig');
      expect(teams.length, equals(18));
    });

    test('Süper Lig özel şartı: Beşiktaş 1. ve lider, Galatasaray 0 puanla son sırada olmalıdır', () {
      final teams = DemoTeams.getTeamsForLeague('super_lig');
      expect(teams.first.name, equals('Beşiktaş'));
      expect(teams.first.points, greaterThan(50));

      expect(teams.last.name, equals('Galatasaray'));
      expect(teams.last.points, equals(0));
    });

    test('Premier Lig 20 takıma sahip olmalıdır', () {
      final teams = DemoTeams.getTeamsForLeague('premier_league');
      expect(teams.length, equals(20));
    });

    test('18 takımlı ligde takım başına toplam 34 maç (17 ilk yarı, 17 ikinci yarı) olmalıdır', () {
      final bjkMatches = DemoMatches.getMatchesForTeam('tr_bjk');
      expect(bjkMatches.length, equals(34));

      final firstHalf = bjkMatches.where((m) => !m.isSecondHalf).length;
      final secondHalf = bjkMatches.where((m) => m.isSecondHalf).length;
      expect(firstHalf, equals(17));
      expect(secondHalf, equals(17));
    });

    test('20 takımlı ligde takım başına toplam 38 maç (19 ilk yarı, 19 ikinci yarı) olmalıdır', () {
      final plTeams = DemoTeams.getTeamsForLeague('premier_league');
      final firstPlTeamMatches = DemoMatches.getMatchesForTeam(plTeams.first.id);
      expect(firstPlTeamMatches.length, equals(38));

      final firstHalf = firstPlTeamMatches.where((m) => !m.isSecondHalf).length;
      final secondHalf = firstPlTeamMatches.where((m) => m.isSecondHalf).length;
      expect(firstHalf, equals(19));
      expect(secondHalf, equals(19));
    });
  });

  group('3. Kupon Sepeti ve Bahis Hesaplama Testleri', () {
    final cart = CouponCartController.instance;

    setUp(() {
      cart.clearCart();
    });

    test('Oran seçimleri sepete eklenmeli ve çıkarılabilmelidir', () {
      final sel = const CouponSelection(
        id: 'match1_ms1',
        matchId: 'match1',
        homeTeam: 'Beşiktaş',
        awayTeam: 'Trabzonspor',
        leagueName: 'Süper Lig',
        marketName: 'Maç Sonucu',
        selectionName: '1',
        odds: 1.80,
      );

      cart.toggleSelection(sel);
      expect(cart.itemCount, equals(1));
      expect(cart.isSelected('match1', 'Maç Sonucu', '1'), isTrue);

      cart.toggleSelection(sel);
      expect(cart.itemCount, equals(0));
      expect(cart.isSelected('match1', 'Maç Sonucu', '1'), isFalse);
    });

    test('Toplam oran bütün seçimlerin çarpımı olmalıdır (1.50 x 2.00 x 1.80 = 5.40)', () {
      cart.toggleSelection(const CouponSelection(
        id: 's1', matchId: 'm1', homeTeam: 'A', awayTeam: 'B', leagueName: 'L', marketName: 'M1', selectionName: '1', odds: 1.50,
      ));
      cart.toggleSelection(const CouponSelection(
        id: 's2', matchId: 'm2', homeTeam: 'C', awayTeam: 'D', leagueName: 'L', marketName: 'M2', selectionName: 'X', odds: 2.00,
      ));
      cart.toggleSelection(const CouponSelection(
        id: 's3', matchId: 'm3', homeTeam: 'E', awayTeam: 'F', leagueName: 'L', marketName: 'M3', selectionName: '2', odds: 1.80,
      ));

      expect(cart.totalOdds, equals(5.40));

      // 50 TL bahis ile olası dönüş: 50 * 5.40 = 270.00 TL
      cart.setStake(50.0);
      expect(cart.possibleWin, equals(270.00));
      expect(cart.possibleNetProfit, equals(220.00));
    });

    test('Minimum bahis tutarı 50 TL kuralı uygulanmalıdır', () async {
      cart.toggleSelection(const CouponSelection(
        id: 's1', matchId: 'm1', homeTeam: 'A', awayTeam: 'B', leagueName: 'L', marketName: 'M1', selectionName: '1', odds: 2.00,
      ));

      cart.setStake(30.0); // 50 TL'den az
      expect(() => cart.playCoupon(), throwsException);
    });

    test('Yetersiz sanal bakiye durumunda kupon oynanamamalıdır', () async {
      cart.toggleSelection(const CouponSelection(
        id: 's1', matchId: 'm1', homeTeam: 'A', awayTeam: 'B', leagueName: 'L', marketName: 'M1', selectionName: '1', odds: 2.00,
      ));

      // Mevcut bakiye 1000 TL iken 5000 TL bahis yapılması engellenmelidir
      cart.setStake(5000.0);
      expect(() => cart.playCoupon(), throwsException);
    });

    test('Başarılı kupon işleminde bakiye doğru eksilmeli ve kupon geçmişe kaydedilmelidir', () async {
      await WalletRepository.instance.resetBalance();
      final initialBalance = WalletRepository.instance.balance;

      cart.toggleSelection(const CouponSelection(
        id: 's1', matchId: 'm1', homeTeam: 'A', awayTeam: 'B', leagueName: 'L', marketName: 'M1', selectionName: '1', odds: 2.50,
      ));
      cart.setStake(100.0);

      final coupon = await cart.playCoupon();

      expect(coupon, isNotNull);
      expect(WalletRepository.instance.balance, equals(initialBalance - 100.0));
      expect(CouponRepository.instance.coupons.any((c) => c.id == coupon.id), isTrue);
      expect(cart.isEmpty, isTrue);
    });
  });
}
