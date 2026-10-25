import 'package:flutter/material.dart'; // Flutter Material UI kütüphanesi
import 'package:provider/provider.dart'; // Provider durum erişimi
import '../../core/constants/app_colors.dart'; // Renk sabitleri
import '../../core/constants/app_constants.dart'; // Logo ve başlık sabitleri
import '../../providers/settings_provider.dart'; // Tema değiştirme işlemi için
import 'widgets/daily_goal_card.dart'; // Günlük hedef kartı bileşeni
import 'widgets/quick_course_progress.dart'; // Hızlı ders ilerlemeleri bileşeni
import 'widgets/today_stats_grid.dart'; // Bugünün istatistik kutuları bileşeni

/// Uygulamanın ana sayfası (Dashboard) - Kullanıcının çalışma durumunu ve kısayolları özetler
class DashboardScreen extends StatelessWidget {
  final VoidCallback onNavigateToCurriculum; // Müfredat sekmesine geçiş fonksiyonu
  final VoidCallback onNavigateToTimer; // Sayaç sekmesine geçiş fonksiyonu
  final VoidCallback onOpenAddQuestion; // Soru ekleme formunu açan fonksiyon
  final VoidCallback onOpenMockExams; // Deneme sınavları sayfasını açan fonksiyon

  const DashboardScreen({
    super.key,
    required this.onNavigateToCurriculum,
    required this.onNavigateToTimer,
    required this.onOpenAddQuestion,
    required this.onOpenMockExams,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Üst Başlık Çubuğu: Logo, uygulama ismi ve hızlı işlem butonları
      appBar: AppBar(
        titleSpacing: 16,
        title: Row(
          children: [
            // Sol tarafta uygulama logosu
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                AppConstants.assetLogo,
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                // Görsel yüklenemezse okul simgeli yedek kutu göster
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.school, color: Colors.white, size: 22),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Logo yanındaki başlık ve alt slogan
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppConstants.appName, // 'KPSS'
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  AppConstants.appSubtitle, // 'Çalışma Koçu'
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Açık / Koyu tema geçiş butonu
          IconButton(
            onPressed: () => context.read<SettingsProvider>().toggleTheme(), // Temayı değiştirir
            icon: Icon(
              context.watch<SettingsProvider>().isDarkTheme
                  ? Icons.light_mode_outlined // Koyu moddaysa güneş ikonu göster
                  : Icons.dark_mode_outlined, // Açık moddaysa ay ikonu göster
            ),
            tooltip: 'Tema Değiştir',
          ),
          // Deneme Sınavları sayfasına yönlendiren buton
          IconButton(
            onPressed: onOpenMockExams,
            icon: const Icon(Icons.assignment_outlined), // Sınav belgesi ikonu
            tooltip: 'Deneme Sınavları',
          ),
        ],
      ),
      // Sayfa Gövdesi: Dikeyde kaydırılabilir ana içerik akışı
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        physics: const BouncingScrollPhysics(), // iOS tarzı esnek kaydırma efekti
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Günlük Soru Hedefi Kartı (Büyük renkli kart)
            const DailyGoalCard(),
            const SizedBox(height: 20),

            // 2. Hızlı İşlem Butonları (Soru Ekle, Sayaç Başlat, Denemeler)
            _buildQuickActions(context),
            const SizedBox(height: 24),

            // 3. Bugünün İstatistikleri Özeti (Net, Süre, Başarı vb. 4'lü kart)
            const TodayStatsGrid(),
            const SizedBox(height: 24),

            // 4. KPSS Dersleri Genel İlerleme Özeti
            QuickCourseProgress(
              onNavigateToCurriculum: onNavigateToCurriculum,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  /// 3 adet hızlı eylem butonunu (Soru Ekle, Sayaç, Denemeler) yan yana oluşturan yardımcı widget
  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        // Soru Ekle Hızlı Butonu
        Expanded(
          child: _buildActionButton(
            context,
            title: 'Soru Ekle',
            icon: Icons.add_circle_outline,
            color: AppColors.primary,
            onTap: onOpenAddQuestion,
          ),
        ),
        const SizedBox(width: 12),
        // Sayaç Başlat Hızlı Butonu
        Expanded(
          child: _buildActionButton(
            context,
            title: 'Sayaç Başlat',
            icon: Icons.timer_outlined,
            color: AppColors.secondary,
            onTap: onNavigateToTimer,
          ),
        ),
        const SizedBox(width: 12),
        // Denemeler Hızlı Butonu
        Expanded(
          child: _buildActionButton(
            context,
            title: 'Denemeler',
            icon: Icons.assignment_outlined,
            color: AppColors.accentGold,
            onTap: onOpenMockExams,
          ),
        ),
      ],
    );
  }

  /// Tek bir hızlı işlem butonunun tasarımını oluşturan yardımcı fonksiyon
  Widget _buildActionButton(
    BuildContext context, {
    required String title, // Buton altındaki metin
    required IconData icon, // Buton simgesi
    required Color color, // Butonun tema ve vurgu rengi
    required VoidCallback onTap, // Tıklandığında çalışacak fonksiyon
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap, // Tıklama eylemi
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1), // Buton renginin %10 saydam dolgusu
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.25)), // İnce renkli çerçeve
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24), // Renkli ikon
            const SizedBox(height: 6),
            Text(
              title, // Başlık
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
