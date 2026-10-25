import 'package:flutter/material.dart'; // Flutter Material UI kütüphanesi
import 'package:provider/provider.dart'; // Provider durum yönetimi
import '../../../core/constants/app_colors.dart'; // Ders renkleri
import '../../../providers/curriculum_provider.dart'; // Müfredat ilerleme verileri

/// Ana sayfada KPSS derslerinin tamamlanma oranlarını hızlıca özetleyen ve müfredata yönlendiren bileşen
class QuickCourseProgress extends StatelessWidget {
  final VoidCallback onNavigateToCurriculum; // 'Tümünü Gör'e tıklandığında Konular sekmesini açan fonksiyon

  const QuickCourseProgress({
    super.key,
    required this.onNavigateToCurriculum,
  });

  @override
  Widget build(BuildContext context) {
    // CurriculumProvider'ı izler (konu bitirildiğinde burası anında güncellenir)
    final curriculumProv = context.watch<CurriculumProvider>();
    final courses = curriculumProv.courses; // Yüklenen derslerin listesi
    final theme = Theme.of(context); // Aktif tema renkleri

    // Dersler henüz yüklenmediyse yer kaplamaz
    if (curriculumProv.isLoading || courses.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Başlık ve 'Tümünü Gör' Butonu Satırı ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Ders İlerlemeleri',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
              onPressed: onNavigateToCurriculum, // Konular sekmesine yönlendir
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Row(
                children: [
                  Text('Tümünü Gör'),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, size: 12),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        // --- Ders İlerleme Çubuklarının Yer Aldığı Kart ---
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardTheme.color, // Tema kart rengi
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.brightness == Brightness.dark
                  ? const Color(0xFF334155) // Koyu tema kenarlık rengi
                  : const Color(0xFFE2E8F0), // Açık tema kenarlık rengi
            ),
          ),
          child: Column(
            // Tüm dersleri alt alta ilerleme çubuğuyla listeler
            children: courses.map((course) {
              final progress = curriculumProv.getCourseProgress(course.id); // Ders tamamlama oranı (0.0 - 1.0)
              final completed = curriculumProv.getCourseCompletedTopics(course.id); // Tamamlanan konu sayısı
              final total = course.topics.length; // Toplam konu sayısı
              final courseColor = AppColors.getCourseColor(course.id); // Derse özel renk

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    // Ders Adı ve Yüzdelik Bilgi Satırı
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Sol taraf: Renkli nokta ve ders adı
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: courseColor, // Dersi temsil eden renk
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              course.title, // Ders adı (Örn: Türkçe, Tarih)
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // Sağ taraf: Bitirilen/Toplam konu adedi ve yüzde
                        Text(
                          '$completed / $total (%${(progress * 100).toInt()})',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: courseColor, // Ders renginde metin
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // İlerleme Çubuğu (LinearProgressIndicator)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: progress, // İlerleme değeri
                        minHeight: 8, // Çubuk kalınlığı
                        backgroundColor: courseColor.withValues(alpha: 0.15), // Arka plan açık tonu
                        valueColor: AlwaysStoppedAnimation<Color>(courseColor), // Doluluk rengi
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
