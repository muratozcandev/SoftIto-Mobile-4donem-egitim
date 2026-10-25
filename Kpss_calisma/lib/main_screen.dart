import 'package:flutter/material.dart'; // Flutter Material bileşenleri
import 'core/constants/app_colors.dart'; // Renk sabitleri
import 'features/curriculum/curriculum_screen.dart'; // Konular (Müfredat) ekranı
import 'features/dashboard/dashboard_screen.dart'; // Ana Sayfa (Dashboard) ekranı
import 'features/mock_exams/mock_exams_screen.dart'; // Deneme Sınavları ekranı
import 'features/question_tracker/widgets/add_question_sheet.dart'; // Hızlı soru ekleme alt sayfası (BottomSheet)
import 'features/statistics/statistics_screen.dart'; // İstatistikler ve analizler ekranı
import 'features/timer/timer_screen.dart'; // Çalışma sayacı (Pomodoro / Kronometre) ekranı

/// Uygulamanın ana iskeletini ve alt gezinme çubuğunu (Bottom Navigation) barındıran ekran
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // Seçili olan aktif sekmenin dizin numarası (0: Ana Sayfa, 1: Konular, 2: Sayaç, 3: İstatistik)

  /// Kullanıcı alt menüdeki bir sekmeye tıkladığında veya içeriden sekme yönlendirmesi yapıldığında çağrılır
  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index; // Aktif sekme numarasını günceller ve arayüzü yeniden çizer
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack: Sekmeler arasında geçiş yapıldığında ekranların durumunu (scroll pozisyonu, sayaç vb.) korur
      body: IndexedStack(
        index: _currentIndex, // Şu an gösterilecek ekranın indeksi
        children: [
          // 0. İndeks: Gösterge Paneli / Ana Sayfa
          DashboardScreen(
            onNavigateToCurriculum: () => _onTabSelected(1), // Konular sekmesine yönlendirme fonksiyonu
            onNavigateToTimer: () => _onTabSelected(2), // Sayaç sekmesine yönlendirme fonksiyonu
            onOpenAddQuestion: () => AddQuestionSheet.show(context), // Hızlı soru ekleme penceresini açar
            onOpenMockExams: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MockExamsScreen()), // Deneme sınavları sayfasına geçiş yapar
            ),
          ),
          // 1. İndeks: KPSS Konuları ve İlerleme Takibi Ekranı
          const CurriculumScreen(),
          // 2. İndeks: Pomodoro ve Kronometre Sayacı Ekranı
          const TimerScreen(),
          // 3. İndeks: Detaylı Başarı ve Çözülen Soru İstatistikleri Ekranı
          const StatisticsScreen(),
        ],
      ),
      // Sağ altta yer alan hızlı Soru Ekleme Yüzen Butonu (FloatingActionButton)
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddQuestionSheet.show(context), // Tıklandığında soru ekleme formunu alttan açar
        backgroundColor: AppColors.primary, // Buton arka plan rengi (İndigo)
        foregroundColor: Colors.white, // Artı simgesi rengi (Beyaz)
        tooltip: 'Soru Ekle', // Uzun basıldığında görünen açıklama ipucu
        child: const Icon(Icons.add, size: 28), // Artı simgesi
      ),
      // Ekranın altındaki modern Material 3 Gezinme Çubuğu (NavigationBar)
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex, // Hangi sekmenin seçili olduğunu belirtir
        onDestinationSelected: _onTabSelected, // Sekmeye tıklandığında çalışacak fonksiyon
        destinations: const [
          // Ana Sayfa Sekmesi
          NavigationDestination(
            icon: Icon(Icons.home_outlined), // Pasif iken çizgi simge
            selectedIcon: Icon(Icons.home), // Seçili iken dolu simge
            label: 'Ana Sayfa', // Sekme başlığı
          ),
          // Konular Sekmesi
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Konular',
          ),
          // Sayaç Sekmesi
          NavigationDestination(
            icon: Icon(Icons.timer_outlined),
            selectedIcon: Icon(Icons.timer),
            label: 'Sayaç',
          ),
          // İstatistik Sekmesi
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'İstatistik',
          ),
        ],
      ),
    );
  }
}
