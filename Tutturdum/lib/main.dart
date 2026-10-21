import 'package:flutter/material.dart';
import 'app/app.dart';
import 'core/storage/local_storage_service.dart';
import 'core/theme/theme_controller.dart';
import 'data/repositories/user_repository.dart';
import 'data/repositories/wallet_repository.dart';
import 'data/repositories/coupon_repository.dart';
import 'data/repositories/notification_repository.dart';
import 'data/repositories/chat_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Yerel Depolamayı Başlat
  await LocalStorageService.instance.init();

  // 2. Tema Yöneticisini Başlat
  await ThemeController.instance.init();

  // 3. Kullanıcı Oturumunu Başlat
  await UserRepository.instance.init();

  // 4. Sanal Bakiye ve Kupon Depolarını Başlat
  await WalletRepository.instance.init();
  await CouponRepository.instance.init();

  // 5. Bildirim ve Sohbet Depolarını Başlat
  NotificationRepository.instance.init();
  ChatRepository.instance.init();

  runApp(const TutturdumApp());
}
