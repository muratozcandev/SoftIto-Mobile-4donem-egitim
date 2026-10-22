import 'package:flutter_test/flutter_test.dart';
import 'package:aliskanlik_takibi/controllers/app_controller.dart';
import 'package:aliskanlik_takibi/controllers/auth_controller.dart';
import 'package:aliskanlik_takibi/models/habit_goal.dart';

void main() {
  group('AppController ve İş Mantığı Testleri', () {
    late AppController controller;

    setUp(() {
      controller = AppController.instance;
    });

    test('Hedef ve gerçekleşen değerler doğru hesaplanır ve %100 ile sınırlandırılır', () {
      // Su hedefini aşırı doldur (3000 / 2500 -> %120 olmamalı, %100 olmalı)
      controller.updateHabit(
        id: 'water',
        newTarget: 2500,
        newCurrent: 3000,
      );

      final waterHabit = controller.habits.firstWhere((h) => h.id == 'water');
      expect(waterHabit.percentage, 100.0);
      expect(waterHabit.isCompleted, true);
    });

    test('Hedef tamamlandığında ilgili başarı rozeti kazanılır', () {
      // Kalori hedefini tamamla
      controller.updateHabit(
        id: 'calorie',
        newTarget: 2000,
        newCurrent: 2000,
      );

      final calorieBadge = controller.badges.firstWhere(
        (b) => b.targetCategory == HabitCategory.calorie,
      );

      expect(calorieBadge.isUnlocked, true);
      expect(calorieBadge.unlockedAt, isNotNull);
    });

    test('Aynı hedef için aynı rozet tekrar tekrar verilmez', () {
      final initialBadgeCount = controller.unlockedBadgeCount;

      // Zaten tamamlanmış bir hedefi tekrar güncelle
      controller.updateHabit(
        id: 'calorie',
        newCurrent: 2500,
      );

      // Kilitli rozet sayısında mükerrer artış olmamalı
      expect(controller.unlockedBadgeCount, initialBadgeCount);
    });

    test('Hızlı değer artırma (quickAddValue) doğru çalışır', () {
      final stepHabitBefore = controller.habits.firstWhere((h) => h.id == 'step');
      final beforeCurrent = stepHabitBefore.currentValue;

      controller.quickAddValue('step', 500);

      final stepHabitAfter = controller.habits.firstWhere((h) => h.id == 'step');
      expect(stepHabitAfter.currentValue, beforeCurrent + 500);
    });
  });

  group('AuthController Doğrulama Testleri', () {
    late AuthController auth;

    setUp(() {
      auth = AuthController.instance;
    });

    test('Geçersiz e-posta/şifre ile giriş hata mesajı döndürür', () {
      final emptyResult = auth.login(identifier: '', password: '');
      expect(emptyResult, isNotNull);

      final shortPassResult = auth.login(identifier: 'test@ornek.com', password: '12');
      expect(shortPassResult, contains('4 karakter'));
    });

    test('KVKK veya sözleşme onaylanmadan kayıt tamamlanamaz', () {
      final termsError = auth.register(
        fullName: 'Ali Veli',
        identifier: 'ali@ornek.com',
        password: 'password123',
        termsAccepted: false,
        kvkkAccepted: true,
      );
      expect(termsError, contains('Sözleşme'));

      final kvkkError = auth.register(
        fullName: 'Ali Veli',
        identifier: 'ali@ornek.com',
        password: 'password123',
        termsAccepted: true,
        kvkkAccepted: false,
      );
      expect(kvkkError, contains('KVKK'));
    });
  });
}
