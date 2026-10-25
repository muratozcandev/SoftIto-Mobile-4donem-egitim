import 'package:flutter/material.dart'; // Flutter Material UI kütüphanesi
import 'package:provider/provider.dart'; // Provider durum yönetimi
import '../../../core/constants/app_colors.dart'; // Renk sabitleri
import '../../../core/utils/date_utils.dart'; // Süre formatlama yardımcısı (formatDuration)
import '../../../providers/curriculum_provider.dart'; // Müfredat ilerleme oranları
import '../../../providers/question_provider.dart'; // Bugünkü soru ve çalışma istatistikleri

/// Ana sayfada günün özet metriklerini (Net, Çalışma Süresi, Doğruluk Oranı, Müfredat) 2x2 grid düzeninde gösteren bileşen
class TodayStatsGrid extends StatelessWidget {
  const TodayStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Soru ve müfredat provider'larını izler
    final questionProv = context.watch<QuestionProvider>();
    final curriculumProv = context.watch<CurriculumProvider>();

    // Günlük hesaplanan değerler
    final todayNet = questionProv.todayNetScore; // Bugünkü net puan
    final todayCorrect = questionProv.todayTotalCorrect; // Bugünkü doğru sayısı
    final todayWrong = questionProv.todayTotalWrong; // Bugünkü yanlış sayısı
    final todayEmpty = questionProv.todayTotalEmpty; // Bugünkü boş sayısı
    final studyMinutes = questionProv.todayStudyDurationMinutes; // Bugün çalışılan toplam dakika
    final curriculumProgress = (curriculumProv.overallProgress * 100).toInt(); // Genel müfredat ilerleme yüzdesi

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bölüm Başlığı
        const Text(
          'Bugünün Özeti',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        
        // --- 1. Satır: Bugünkü Net & Çalışma Süresi Kartları ---
        Row(
          children: [
            // Bugünkü Net Kartı
            Expanded(
              child: _buildMetricCard(
                context,
                title: 'Bugünkü Net',
                value: todayNet.toStringAsFixed(2), // Virgülden sonra 2 basamak (Örn: 42.50)
                subtitle: '$todayCorrect D • $todayWrong Y • $todayEmpty B', // Doğru/Yanlış/Boş dökümü
                icon: Icons.auto_awesome,
                iconColor: AppColors.primary,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              ),
            ),
            const SizedBox(width: 12),
            // Çalışma Süresi Kartı
            Expanded(
              child: _buildMetricCard(
                context,
                title: 'Çalışma Süresi',
                value: AppDateUtils.formatDuration(studyMinutes), // Dakikayı 'X sa Y dk' metnine çevirir
                subtitle: studyMinutes > 0 ? 'Aktif odaklanma' : 'Sayaç başlatılmadı',
                icon: Icons.timer_outlined,
                iconColor: AppColors.secondary,
                backgroundColor: AppColors.secondary.withValues(alpha: 0.1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        // --- 2. Satır: Doğruluk Oranı & Müfredat İlerleme Kartları ---
        Row(
          children: [
            // Doğruluk / Başarı Oranı Kartı
            Expanded(
              child: _buildMetricCard(
                context,
                title: 'Doğruluk Oranı',
                // Soru yoksa %0, varsa (Doğru / Toplam Soru) * 100
                value: '%${(questionProv.todayTotalQuestions == 0 ? 0 : (todayCorrect / questionProv.todayTotalQuestions * 100)).toInt()}',
                subtitle: 'Başarı yüzdesi',
                icon: Icons.verified_outlined,
                iconColor: AppColors.completed,
                backgroundColor: AppColors.completed.withValues(alpha: 0.1),
              ),
            ),
            const SizedBox(width: 12),
            // Müfredat İlerleme Kartı
            Expanded(
              child: _buildMetricCard(
                context,
                title: 'Müfredat İlerleme',
                value: '%$curriculumProgress',
                subtitle: '${curriculumProv.totalCompletedTopics}/${curriculumProv.totalTopicsCount} konu bitti',
                icon: Icons.menu_book_outlined,
                iconColor: AppColors.courseMatematik,
                backgroundColor: AppColors.courseMatematik.withValues(alpha: 0.1),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Tek bir metrik kartını inşa eden yardımcı widget fonksiyonu
  Widget _buildMetricCard(
    BuildContext context, {
    required String title, // Kartın küçük başlığı (Örn: 'Bugünkü Net')
    required String value, // Kartın büyük ana değeri (Örn: '45.00')
    required String subtitle, // Kartın altındaki açıklayıcı detay metni
    required IconData icon, // İkon sembolü
    required Color iconColor, // İkon rengi
    required Color backgroundColor, // İkonun arkasındaki saydam renkli zemin
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color, // Tema kart yüzey rengi
        borderRadius: BorderRadius.circular(16), // Köşe ovalliği
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? const Color(0xFF334155) // Koyu mod kenarlık
              : const Color(0xFFE2E8F0), // Açık mod kenarlık
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // İkon ve Başlık Satırı
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Sığmazsa üç nokta koy
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Ana Değer Metni (Büyük punto)
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          // Alt Detay Metni (Küçük punto)
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
