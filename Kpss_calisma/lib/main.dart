import 'package:flutter/material.dart'; // Flutter Material arayüz kütüphanesini içeri aktarır
import 'package:provider/provider.dart'; // Uygulama genelinde durum (state) yönetimi sağlayan Provider paketini içeri aktarır
import 'core/constants/app_constants.dart'; // Uygulama adı ve genel sabitler
import 'core/services/hive_service.dart'; // Hive veritabanı başlatıcı servisi
import 'core/theme/app_theme.dart'; // Açık ve koyu tema yapılandırmaları
import 'main_screen.dart'; // Ana sekmeli gezinme ekranı
import 'providers/curriculum_provider.dart'; // KPSS müfredat durum yöneticisi
import 'providers/mock_exam_provider.dart'; // Deneme sınavı sonuçları durum yöneticisi
import 'providers/question_provider.dart'; // Soru ve çalışma seansları durum yöneticisi
import 'providers/settings_provider.dart'; // Ayarlar ve tema durum yöneticisi
import 'providers/timer_provider.dart'; // Pomodoro ve kronometre durum yöneticisi

/// Uygulamanın giriş noktası (Main fonksiyonu)
Future<void> main() async {
  // Flutter widget motorunun ve yerel kanalların başlatıldığından emin olur
  WidgetsFlutterBinding.ensureInitialized();
  
  // Hive yerel veritabanını ve gerekli kutuları (tabloları) asenkron olarak başlatır
  await HiveService.init();

  // Uygulamayı tüm ekranlardan erişilebilecek sağlayıcılar (Providers) ile sararak başlatır
  runApp(
    MultiProvider(
      providers: [
        // Kullanıcı ayarları ve tema durumunu sağlayan provider
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        // KPSS ders müfredatı ve konu tamamlama durumlarını sağlayan provider
        ChangeNotifierProvider(create: (_) => CurriculumProvider()),
        // Çözülen soruları ve çalışma istatistiklerini sağlayan provider
        ChangeNotifierProvider(create: (_) => QuestionProvider()),
        // Pomodoro ve kronometre sayacını yöneten provider
        ChangeNotifierProvider(create: (_) => TimerProvider()),
        // Deneme sınavı kayıtlarını yöneten provider
        ChangeNotifierProvider(create: (_) => MockExamProvider()),
      ],
      // Kök widget olarak KpssApp bileşenini başlatır
      child: const KpssApp(),
    ),
  );
}

/// Uygulamanın kök (root) MaterialApp bileşeni
class KpssApp extends StatelessWidget {
  const KpssApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SettingsProvider'ı dinleyerek tema değişikliklerinde (koyu/açık) uygulamanın anında yeniden çizilmesini sağlar
    final settingsProv = context.watch<SettingsProvider>();

    return MaterialApp(
      title: AppConstants.appName, // Uygulamanın başlığı ('KPSS')
      debugShowCheckedModeBanner: false, // Sağ üstteki 'DEBUG' bandını gizler
      theme: AppTheme.lightTheme, // Açık tema görsel ayarları
      darkTheme: AppTheme.darkTheme, // Koyu tema görsel ayarları
      // Kullanıcının ayarlardan seçtiği tema durumuna göre aktif modu belirler
      themeMode: settingsProv.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: const MainScreen(), // Uygulama açıldığında gösterilecek ana sayfa
    );
  }
}
