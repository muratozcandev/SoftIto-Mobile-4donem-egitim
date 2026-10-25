import 'package:fl_chart/fl_chart.dart'; // Modern grafikler (Pasta grafik / PieChart) çizmek için grafik kütüphanesi
import 'package:flutter/material.dart'; // Flutter Material UI kütüphanesi
import '../../../core/constants/app_colors.dart'; // Ders renk sabitleri
import '../../../providers/curriculum_provider.dart'; // Ders adlarını almak için müfredat provider
import '../../../providers/question_provider.dart'; // Ders istatistikleri veri modeli (CourseStats)

/// Kullanıcının çözdüğü soruların derslere göre oransal dağılımını gösteren dairesel pasta grafik (Pie Chart) bileşeni
class CoursePieChart extends StatelessWidget {
  final Map<String, CourseStats> courseStats; // Ders ID'si -> Ders istatistikleri haritası
  final CurriculumProvider curriculumProv; // Derslerin başlık ve bilgilerine erişim sağlayan sağlayıcı

  const CoursePieChart({
    super.key,
    required this.courseStats,
    required this.curriculumProv,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Sadece en az 1 soru çözülmüş olan dersleri filtreler (0 soruluk dersler grafikte yer kaplamaz)
    final activeEntries = courseStats.entries.where((e) => e.value.totalQuestions > 0).toList();

    // Hiç soru çözülmemişse bileşeni tamamen gizler (boş boşuna çizilmez)
    if (activeEntries.isEmpty) {
      return const SizedBox.shrink();
    }

    // Aktif derslerin toplam soru sayısını hesaplar (yüzdelik dilim hesaplaması için payda)
    final total = activeEntries.fold(0, (sum, e) => sum + e.value.totalQuestions);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color, // Kart arka plan rengi
        borderRadius: BorderRadius.circular(16), // Köşe ovalliği
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? const Color(0xFF334155) // Koyu mod çerçevesi
              : const Color(0xFFE2E8F0), // Açık mod çerçevesi
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Grafik Başlığı
          const Text(
            'Ders Bazlı Soru Dağılımı',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 18),
          
          // Grafik ve Açıklama Listesini Yan Yana Tutan Satır
          Row(
            children: [
              // Sol Taraf: Donut (Halka) Şeklinde Pasta Grafik
              SizedBox(
                width: 140, // Grafik genişliği
                height: 140, // Grafik yüksekliği
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 3, // Dilimler arasındaki ince boşluk
                    centerSpaceRadius: 36, // Halkanın ortasındaki boşluğun yarıçapı (Donut efekti)
                    // Her bir ders için dilim verisi üretir
                    sections: activeEntries.map((e) {
                      final color = AppColors.getCourseColor(e.key); // Ders rengi
                      final percentage = (e.value.totalQuestions / total) * 100; // Yüzdelik oran
                      return PieChartSectionData(
                        color: color, // Dilim dolgu rengi
                        value: e.value.totalQuestions.toDouble(), // Dilimin sayısal değeri
                        title: '%${percentage.toInt()}', // Dilimin üstünde yazan yüzde metni
                        radius: 36, // Dilim kalınlığı
                        titleStyle: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              
              // Sağ Taraf: Renkli Ders İsimleri ve Soru Sayısı Lejantı (Açıklama Listesi)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: activeEntries.map((e) {
                    final color = AppColors.getCourseColor(e.key);
                    // Ders kimliğinden dersin adını bulur (Örn: 'turkce' -> 'Türkçe')
                    final courseTitle = curriculumProv.courses
                        .firstWhere((c) => c.id == e.key, orElse: () => curriculumProv.courses.first)
                        .title;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          // Ders rengini gösteren küçük yuvarlak nokta
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 8),
                          // Dersin adı
                          Expanded(
                            child: Text(
                              courseTitle,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Çözülen soru sayısı etiketi (Örn: '150 s')
                          Text(
                            '${e.value.totalQuestions} s',
                            style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
