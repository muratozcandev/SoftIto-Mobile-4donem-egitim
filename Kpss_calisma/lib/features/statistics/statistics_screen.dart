import 'package:flutter/material.dart'; // Flutter Material UI kütüphanesi
import 'package:provider/provider.dart'; // Provider durum erişimi
import '../../core/constants/app_colors.dart'; // Renk sabitleri
import '../../core/utils/date_utils.dart'; // Tarih ve süre formatlayıcı
import '../../providers/curriculum_provider.dart'; // Müfredat bilgileri
import '../../providers/question_provider.dart'; // Soru ve çalışma istatistikleri
import '../question_tracker/widgets/add_question_sheet.dart'; // Soru ekleme formu
import 'widgets/course_pie_chart.dart'; // Ders bazlı pasta grafik
import 'widgets/weekly_bar_chart.dart'; // 7 günlük çubuk grafik

/// Kullanıcının çözdüğü soruların, çalışma sürelerinin ve ders performanslarının kapsamlı analizini sunan İstatistik ekranı
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Soru ve müfredat verilerini izler
    final questionProv = context.watch<QuestionProvider>();
    final curriculumProv = context.watch<CurriculumProvider>();
    final theme = Theme.of(context);

    // Kümülatif metrikler
    final totalQuestions = questionProv.totalAllQuestions; // Çözülen toplam soru sayısı
    final totalNet = questionProv.totalAllNetScore; // Toplam net puan
    final accuracy = questionProv.overallAccuracyRate; // Genel doğruluk yüzdesi
    final totalStudyMinutes = questionProv.totalAllStudyMinutes; // Toplam çalışılan süre (dk)
    final courseStats = questionProv.getCourseStats(); // Ders bazlı istatistik dökümü
    final last7Days = questionProv.getLast7DaysQuestionCounts(); // Son 7 günün soru sayıları

    return Scaffold(
      appBar: AppBar(
        title: const Text('İstatistik ve Analiz'), // Sayfa başlığı
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Genel Özet Metrik Kutuları (2x2 Düzen) ---
            Row(
              children: [
                // Toplam Net Kutusu
                Expanded(
                  child: _buildMetricTile(
                    context,
                    title: 'Toplam Net',
                    value: totalNet.toStringAsFixed(2),
                    icon: Icons.trending_up,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                // Toplam Soru Kutusu
                Expanded(
                  child: _buildMetricTile(
                    context,
                    title: 'Toplam Soru',
                    value: totalQuestions.toString(),
                    icon: Icons.checklist_outlined,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // Genel Başarı Yüzdesi Kutusu
                Expanded(
                  child: _buildMetricTile(
                    context,
                    title: 'Genel Başarı',
                    value: '%${accuracy.toInt()}',
                    icon: Icons.verified_outlined,
                    color: AppColors.completed,
                  ),
                ),
                const SizedBox(width: 12),
                // Toplam Çalışma Süresi Kutusu
                Expanded(
                  child: _buildMetricTile(
                    context,
                    title: 'Toplam Süre',
                    value: AppDateUtils.formatDuration(totalStudyMinutes),
                    icon: Icons.access_time_outlined,
                    color: AppColors.accentGold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Eğer henüz hiç soru girilmemişse boş durum kartı gösterir, veri varsa grafikleri çizer
            if (totalQuestions == 0)
              _buildEmptyStateCard(context) // Boş durum yönlendirmesi
            else ...[
              // --- 2. Son 7 Günlük Soru Çubuk Grafiği ---
              WeeklyBarChart(last7DaysData: last7Days),
              const SizedBox(height: 20),

              // --- 3. Ders Bazlı Soru Dağılımı Pasta Grafiği ---
              CoursePieChart(
                courseStats: courseStats,
                curriculumProv: curriculumProv,
              ),
              const SizedBox(height: 24),

              // --- 4. Ders Bazlı Başarı Karnesi Tablosu ---
              Text(
                'Ders Bazlı Başarı Karnesi',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              _buildCourseBreakdown(context, curriculumProv, courseStats),
              const SizedBox(height: 24),

              // --- 5. Son Soru Çözüm Geçmişi Listesi ---
              Text(
                'Son Soru Çözüm Kayıtları',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              _buildLogsList(context, questionProv),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  /// Hiç veri girilmediğinde kullanıcıyı ilk soru kaydını eklemeye teşvik eden kart
  Widget _buildEmptyStateCard(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? const Color(0xFF334155)
              : const Color(0xFFE2E8F0),
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.query_stats,
                size: 40,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Henüz veri girişi yapılmadı',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Grafiklerin ve analizlerin oluşması için ilk soru kaydını ekle!',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 20),
            // İlk Soru Kaydını Ekleme Butonu
            ElevatedButton.icon(
              onPressed: () => AddQuestionSheet.show(context),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('İlk Soru Kaydını Ekle'),
            ),
          ],
        ),
      ),
    );
  }

  /// Üst kısımdaki özet metrik kutusunu oluşturan yardımcı widget
  Widget _buildMetricTile(
    BuildContext context, {
    required String title, // Küçük başlık
    required String value, // Büyük değer (Örn: '120.50')
    required IconData icon, // İkon
    required Color color, // Vurgu rengi
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? const Color(0xFF334155)
              : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Tüm derslerin tek tek toplam soru, doğru/yanlış, net ve başarı oranını gösteren karne kartları
  Widget _buildCourseBreakdown(
    BuildContext context,
    CurriculumProvider curriculumProv,
    Map<String, CourseStats> courseStats,
  ) {
    final theme = Theme.of(context);
    return Column(
      children: curriculumProv.courses.map((course) {
        final stat = courseStats[course.id];
        final color = AppColors.getCourseColor(course.id);
        final solved = stat?.totalQuestions ?? 0;
        final correct = stat?.totalCorrect ?? 0;
        final wrong = stat?.totalWrong ?? 0;
        final net = stat?.netScore ?? 0.0;
        final accuracy = stat?.accuracyRate ?? 0.0;

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: theme.brightness == Brightness.dark
                  ? const Color(0xFF334155)
                  : const Color(0xFFE2E8F0),
            ),
          ),
          child: Column(
            children: [
              // Ders Adı ve Net Skoru
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        course.title,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                    ],
                  ),
                  Text(
                    'Net: ${net.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.w800, color: color, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Çözülen Soru Dökümü ve Başarı Yüzdesi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$solved Soru ($correct D • $wrong Y)',
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
                  ),
                  Text(
                    'Başarı: %${accuracy.toInt()}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      // Başarı %70 üstüyse yeşil, altındaysa sarı/amber renk
                      color: accuracy >= 70 ? AppColors.completed : AppColors.needsReview,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Son çözülen 6 soru kaydını listeleyen ve silme imkanı tanıyan bileşen
  Widget _buildLogsList(BuildContext context, QuestionProvider questionProv) {
    final theme = Theme.of(context);
    final logs = questionProv.logs.take(6).toList(); // Son 6 kaydı al

    return Column(
      children: logs.map((log) {
        final color = AppColors.getCourseColor(log.courseId);
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.brightness == Brightness.dark
                  ? const Color(0xFF334155)
                  : const Color(0xFFE2E8F0),
            ),
          ),
          child: Row(
            children: [
              // Sol renkli çizgi
              Container(
                width: 4,
                height: 36,
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(width: 10),
              // Ders Adı ve Doğru/Yanlış/Tarih Bilgisi
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      log.courseId.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${log.correct} D • ${log.wrong} Y • ${log.empty} B  (${AppDateUtils.getRelativeDay(log.date)})',
                      style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
              // Net ve Toplam Soru Sayısı
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${log.netScore.toStringAsFixed(2)} Net',
                    style: TextStyle(fontWeight: FontWeight.w800, color: color, fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${log.totalQuestions} Soru',
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              // Kaydı Silme Butonu
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 18, color: Colors.grey),
                onPressed: () => questionProv.deleteQuestionLog(log.id), // Kaydı sil
                tooltip: 'Kaydı Sil',
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
