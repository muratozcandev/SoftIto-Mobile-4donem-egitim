
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_magaza/main.dart';

void main() {
  testWidgets('Mini Mağaza uygulaması açılır', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MiniMagazaUygulamasi());

    expect(find.text('Mini Mağaza'), findsOneWidget);
  });
}
