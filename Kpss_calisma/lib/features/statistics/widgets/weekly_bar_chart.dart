import 'package:fl_chart/fl_chart.dart'; // Çubuk grafik (BarChart) çizimi için fl_chart kütüphanesi
import 'package:flutter/material.dart'; // Flutter Material UI kütüphanesi
import '../../../core/constants/app_colors.dart'; // Renk sabitleri
import '../../../core/utils/date_utils.dart'; // Tarih etiketleri için biçimlendirici

/// Kullanıcının son 7 günde çözdüğü soru sayılarını sütun grafik (Bar Chart) olarak görselleştiren bileşen
class WeeklyBarChart extends StatelessWidget {
  final Map<DateTime, int> last7DaysData; // Son 7 günün normalize tarihleri ve çözülen soru sayıları haritası

  const WeeklyBarChart({super.key, required this.last7DaysData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entries = last7DaysData.entries.toList(); // Haritayı listeye çevirir

    // Grafiğin Y ekseni tepe noktasını belirlemek için son 7 gün içindeki en yüksek soru sayısını bulur
    int maxCount = 10;
    for (final e in entries) {
      if (e.value > maxCount) maxCount = e.value;
    }
    // Grafiğin tepesinde ferah bir pay bırakmak için bir sonraki onluğa yuvarlar
    final maxY = ((maxCount + 10) ~/ 10) * 10.0;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      decoration: BoxDecoration(
        color: theme.cardTheme.color, // Kart rengi
        borderRadius: BorderRadius.circular(16), // Kart köşe ovalliği
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? const Color(0xFF334155) // Koyu tema çerçevesi
              : const Color(0xFFE2E8F0), // Açık tema çerçevesi
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Grafik Başlığı ve İkonu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Son 7 Gün Soru Dağılımı',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              Icon(Icons.bar_chart, color: AppColors.primary, size: 20),
            ],
          ),
          const SizedBox(height: 24),
          
          // Çubuk Grafiğin Çizildiği Alan
          SizedBox(
            height: 180, // Grafik sabit yüksekliği
            child: BarChart(
              BarChartData(
                maxY: maxY, // Y ekseni maksimum değeri
                // Sütuna dokunulduğunda çıkan ipucu balonu (Tooltip)
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final day = entries[groupIndex].key; // Dokunulan günün tarihi
                      return BarTooltipItem(
                        '${AppDateUtils.formatDayMonth(day)}\n${rod.toY.toInt()} Soru', // Tarih ve soru adedi
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
                // Eksen Başlıkları ve Etiketleri
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)), // Üst etiketleri kapat
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)), // Sağ etiketleri kapat
                  // Sol Eksen Sayı Değerleri
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        // Sadece sıfır, tepe ve orta değerleri yazarak kalabalığı önler
                        if (value == 0 || value == maxY || value == maxY / 2) {
                          return Text(
                            value.toInt().toString(),
                            style: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  // Alt Eksen Gün Etiketleri (Örn: 24 Eki, 25 Eki)
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < entries.length) {
                          final day = entries[index].key;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              AppDateUtils.formatDayMonth(day), // Gün ve kısa ay formatı
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                // Yatay Kılavuz Çizgileri
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false, // Dikey çizgileri çizme
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withValues(alpha: 0.15), // Saydam gri yatay çizgiler
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false), // Dış çerçeve çizgisini kaldırır
                // 7 Güne ait sütun gruplarını (BarGroups) oluşturur
                barGroups: List.generate(entries.length, (index) {
                  final count = entries[index].value.toDouble(); // O günkü soru sayısı
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: count, // Sütun yüksekliği
                        // Aşağıdan yukarıya doğru şık renk gradyanı
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryLight],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        width: 16, // Sütun genişliği
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)), // Sütun tepesine ovallik
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
