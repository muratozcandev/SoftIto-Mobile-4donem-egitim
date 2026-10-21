import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutturdum/app/app.dart';
import 'package:tutturdum/core/storage/local_storage_service.dart';
import 'package:tutturdum/data/repositories/user_repository.dart';
import 'package:tutturdum/data/repositories/wallet_repository.dart';
import 'package:tutturdum/data/repositories/coupon_repository.dart';
import 'package:tutturdum/data/repositories/notification_repository.dart';
import 'package:tutturdum/data/repositories/chat_repository.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('TutturdumApp temel yüklenme testi', (WidgetTester tester) async {
    await LocalStorageService.instance.init();
    await UserRepository.instance.init();
    await WalletRepository.instance.init();
    await CouponRepository.instance.init();
    NotificationRepository.instance.init();
    ChatRepository.instance.init();

    await tester.pumpWidget(const TutturdumApp());
    await tester.pump(const Duration(milliseconds: 100));

    // Giriş ekranı veya ana ekran açılmış olmalıdır
    expect(find.text('Tutturdum'), findsWidgets);
  });
}
