<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: widget_test.dart
// Görev: AraÇek uygulamasının temel widget derleme ve duman (smoke) testleri.
// Açıklama: AraCekApp ana widget'ının hatasız başlatıldığını doğrular.
// ==============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:aracek/main.dart';

void main() {
  testWidgets('AraCekApp başlatma testi', (WidgetTester tester) async {
    // Uygulama widget ağacını derle
    await tester.pumpWidget(const AraCekApp());
    await tester.pumpAndSettle();

    // Uygulama başlığı veya karşılama metninin varlığını doğrula
    expect(find.textContaining('AraÇek'), findsWidgets);
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
  });
}
