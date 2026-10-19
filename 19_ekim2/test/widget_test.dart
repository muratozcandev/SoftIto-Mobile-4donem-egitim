import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:susadim/main.dart';

void main() {
  testWidgets('Susadım v1 arayüz ve su takip testi', (WidgetTester tester) async {
    // Uygulamayı başlat
    await tester.pumpWidget(const SusadimApp());
    await tester.pumpAndSettle();

    // Başlık ve başlangıç kontrolleri
    expect(find.text('Susadım v1'), findsOneWidget);
    expect(find.text('+250 ml'), findsOneWidget);
    expect(find.text('+500 ml'), findsOneWidget);
    expect(find.text('Sıfırla'), findsOneWidget);

    // Sıfırla butonuna basma testi
    await tester.tap(find.text('Sıfırla'));
    await tester.pumpAndSettle();

    // Sıfırlandıktan sonra 0 ml görmeliyiz
    expect(find.text('0'), findsOneWidget);

    // 250 ml su ekle
    await tester.tap(find.text('+250 ml'));
    await tester.pumpAndSettle();

    // 250 ml güncellendiğini doğrula
    expect(find.text('250'), findsOneWidget);

    // Karanlık/Aydınlık Tema Değiştirme Testi
    // Başlangıçta koyu mod ikonunu kontrol et
    expect(find.byIcon(Icons.light_mode), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode), findsNothing);

    // Temayı aydınlık moda geçir
    await tester.tap(find.byIcon(Icons.light_mode));
    await tester.pumpAndSettle();

    // Aydınlık modda koyu mod ikonunun belirdiğini doğrula
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    expect(find.byIcon(Icons.light_mode), findsNothing);
  });
}
