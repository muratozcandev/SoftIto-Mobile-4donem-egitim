import 'package:flutter_test/flutter_test.dart';
import 'package:giriselim/controllers/app_controller.dart';
import 'package:giriselim/main.dart';

void main() {
  setUp(() {
    AppController.instance.resetDemoData();
  });

  group('AppController Birim Testleri', () {
    test('Başlangıç sanal bakiyesi 100.000 TL (10.000.000 Kuruş) olmalıdır', () {
      expect(AppController.instance.balance.value, 10000000);
      expect(AppController.instance.formattedBalance, '100.000 ₺');
    });

    test('Para ekleme işlemi bakiyeyi artırmalı ve işlem kaydı oluşturmalıdır', () {
      final initialBalance = AppController.instance.balance.value;
      final success = AppController.instance.addMoney(2500000); // 25.000 TL

      expect(success, isTrue);
      expect(AppController.instance.balance.value, initialBalance + 2500000);
      expect(AppController.instance.transactions.value.first.title, 'Bakiye Yükleme');
    });

    test('Transfer işlemi bakiye yeterliyse düşmeli, yetersizse reddetmelidir', () {
      // Yetersiz bakiye testi
      final failedTransfer = AppController.instance.transferMoney(
        999999999, // Çok yüksek tutar
        'Ahmet',
        'Not',
      );
      expect(failedTransfer, isFalse);

      // Başarılı transfer
      final beforeBalance = AppController.instance.balance.value;
      final success = AppController.instance.transferMoney(
        1000000, // 10.000 TL
        'Zeynep Kaya',
        'Demo Transfer',
      );
      expect(success, isTrue);
      expect(AppController.instance.balance.value, beforeBalance - 1000000);
    });

    test('Yatırım yapıldığında bakiye düşmeli ve yatırım listesine eklenmelidir', () {
      final idea = AppController.instance.businessIdeas.value.first;
      final beforeBalance = AppController.instance.balance.value;

      final success = AppController.instance.makeInvestment(idea);
      expect(success, isTrue);
      expect(AppController.instance.balance.value, beforeBalance - idea.investmentAmount);
      expect(AppController.instance.investments.value.length, 1);
      expect(AppController.instance.investments.value.first.businessIdeaId, idea.id);
    });
  });

  group('GiriselimApp Widget Testi', () {
    testWidgets('Uygulama başarıyla render edilmeli', (WidgetTester tester) async {
      await tester.pumpWidget(const GiriselimApp());
      await tester.pumpAndSettle();

      // Ana ekran öğelerinin varlığını doğrula
      expect(find.text('Sanal Portföy Bakiyesi'), findsOneWidget);
      expect(find.text('100.000 ₺'), findsOneWidget);
    });
  });
}
