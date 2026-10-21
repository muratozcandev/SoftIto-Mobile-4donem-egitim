import 'package:flutter_test/flutter_test.dart';
import 'package:aracek/main.dart';
import 'package:aracek/features/authentication/views/login_view.dart';

/// AraÇek temel duman testi (smoke test)
void main() {
  testWidgets('AraÇek uygulaması açılış testi', (WidgetTester tester) async {
    // Uygulamayı derle ve bir kare tetikle
    await tester.pumpWidget(const AraCekApp());

    // LoginView ekranının yüklendiğini doğrula
    expect(find.byType(LoginView), findsOneWidget);
  });
}
