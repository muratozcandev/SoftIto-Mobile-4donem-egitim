import 'package:flutter_test/flutter_test.dart';
import 'package:sirdasim/main.dart';

void main() {
  testWidgets('Sırdaşım uygulaması temel bileşenleri yükler', (WidgetTester tester) async {
    await tester.pumpWidget(const SirdasimApp());
    await tester.pumpAndSettle();

    // Uygulama başlığı ve rozet kontrolü
    expect(find.text('Sırdaşım'), findsOneWidget);
    expect(find.text('Akıllı Günlük'), findsOneWidget);

    // Gezinme ve bugün butonu kontrolü
    expect(find.text('Bugün'), findsOneWidget);

    // Günlük editörü ve kaydet butonu kontrolü
    expect(find.text('Kaydet'), findsOneWidget);
    expect(find.text('Ruh Hali:'), findsOneWidget);
  });
}
