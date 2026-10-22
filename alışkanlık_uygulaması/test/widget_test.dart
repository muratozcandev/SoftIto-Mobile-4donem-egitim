import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aliskanlik_takibi/main.dart';
import 'package:aliskanlik_takibi/controllers/auth_controller.dart';

void main() {
  testWidgets('Uygulama açılış testi ve tabbar doğrulaması', (WidgetTester tester) async {
    // Oturum açık olarak başlat
    AuthController.instance.login(identifier: 'test@ornek.com', password: 'password123');

    await tester.pumpWidget(const AliskanlikTakibiApp());
    await tester.pumpAndSettle();

    // Üst barda başlık
    expect(find.text('Alışkanlık Takibi'), findsWidgets);

    // Alt navigasyonda 4 sekme (NavigationDestination)
    expect(find.widgetWithText(NavigationDestination, 'Hedeflerim'), findsOneWidget);
    expect(find.widgetWithText(NavigationDestination, 'Ekle'), findsOneWidget);
    expect(find.widgetWithText(NavigationDestination, 'Takvim'), findsOneWidget);
    expect(find.widgetWithText(NavigationDestination, 'Analiz'), findsOneWidget);

    // Günlük Özet Kartı
    expect(find.text('GÜNLÜK ÖZET'), findsOneWidget);
  });
}
