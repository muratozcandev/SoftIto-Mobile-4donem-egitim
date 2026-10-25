import 'package:flutter/material.dart'; // Flutter Material UI kütüphanesi
import 'package:provider/provider.dart'; // Provider durum erişimi
import '../../core/constants/app_colors.dart'; // Renk sabitleri
import '../../core/utils/date_utils.dart'; // Tarih ve saat biçimlendirici
import '../../providers/question_provider.dart'; // Bugünün çalışma seanslarını göstermek için provider
import '../../providers/timer_provider.dart'; // Zamanlayıcı (Pomodoro/Kronometre) durum yöneticisi
import 'widgets/save_session_dialog.dart'; // Seansı kaydetme iletişim kutusu

/// Pomodoro tekniği, kısa mola ve serbest kronometre modlarını içeren Çalışma Sayacı ekranı
class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TimerProvider ve QuestionProvider verilerini izler
    final timerProv = context.watch<TimerProvider>();
    final questionProv = context.watch<QuestionProvider>();
    final theme = Theme.of(context);

    // Eğer Pomodoro geri sayımı sıfıra ulaşıp bittiyse otomatik olarak seansı kaydetme diyaloğunu tetikler
    if (timerProv.isFinished) {
      // Ekran çizimi tamamlandıktan hemen sonra çalıştırmak için postFrameCallback kullanılır
      WidgetsBinding.instance.addPostFrameCallback((_) {
        SaveSessionDialog.show(
          context,
          durationMinutes: timerProv.elapsedStudyMinutes, // Çalışılan süreyi aktarır
          sessionType: 'pomodoro',
        );
        timerProv.resetTimer(); // Sayacı başlangıç değerine sıfırlar
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Çalışma Sayacı'), // Sayfa başlığı
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            // --- 1. Çalışma Modu Seçici Buton Grubu (Pomodoro, Mola, Kronometre) ---
            SegmentedButton<StudyTimerMode>(
              segments: const [
                // 1. Segment: Pomodoro
                ButtonSegment(
                  value: StudyTimerMode.pomodoro,
                  label: Text('Pomodoro (25dk)'),
                  icon: Icon(Icons.alarm),
                ),
                // 2. Segment: Kısa Mola
                ButtonSegment(
                  value: StudyTimerMode.shortBreak,
                  label: Text('Mola (5dk)'),
                  icon: Icon(Icons.coffee),
                ),
                // 3. Segment: Kronometre
                ButtonSegment(
                  value: StudyTimerMode.stopwatch,
                  label: Text('Kronometre'),
                  icon: Icon(Icons.timer),
                ),
              ],
              selected: {timerProv.mode}, // O an aktif olan modu seçili gösterir
              onSelectionChanged: (set) {
                timerProv.switchMode(set.first); // Kullanıcı farklı moda tıkladığında modu değiştirir
              },
            ),
            const SizedBox(height: 36),

            // --- 2. Büyük Dairesel İlerleme Göstergesi ve Sayaç Metni ---
            Center(
              child: Stack(
                alignment: Alignment.center, // Kalan süreyi dairenin tam merkezine koyar
                children: [
                  // Dairesel İlerleme Çubuğu (Büyük Halka)
                  SizedBox(
                    width: 250, // Halka genişliği
                    height: 250, // Halka yüksekliği
                    child: CircularProgressIndicator(
                      // Kronometrede çalışıyorsa döner, diğer modlarda kalan süre oranında doluluk gösterir
                      value: timerProv.mode == StudyTimerMode.stopwatch
                          ? (timerProv.isRunning ? null : 1.0)
                          : timerProv.progress,
                      strokeWidth: 12, // Çizgi kalınlığı (12px)
                      backgroundColor: theme.brightness == Brightness.dark
                          ? const Color(0xFF334155) // Koyu mod arka plan çizgisi
                          : const Color(0xFFE2E8F0), // Açık mod arka plan çizgisi
                      valueColor: AlwaysStoppedAnimation<Color>(
                        // Mola modundaysa yeşil, diğer modlarda ana tema rengi (indigo)
                        timerProv.mode == StudyTimerMode.shortBreak
                            ? AppColors.completed
                            : AppColors.primary,
                      ),
                      strokeCap: StrokeCap.round, // Halka uçlarını yuvarlatır
                    ),
                  ),
                  // Dairenin İçindeki Süre ve Durum Metinleri
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Büyük Dijital Sayaç Metni (Örn: '24:59')
                      Text(
                        timerProv.formattedTime,
                        style: const TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Sayaç Alt Bilgilendirme Başlığı
                      Text(
                        timerProv.mode == StudyTimerMode.pomodoro
                            ? (timerProv.isRunning ? 'Odaklanma Zamanı' : 'Pomodoro Hazır')
                            : (timerProv.mode == StudyTimerMode.shortBreak
                                ? 'Dinlenme Zamanı'
                                : 'Serbest Sayaç'),
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // --- 3. Sayaç Kontrol Butonları (Sıfırla, Başlat/Duraklat, Kaydet) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Sıfırlama Butonu (Yenileme simgesi)
                IconButton.filledTonal(
                  onPressed: timerProv.resetTimer, // Sayacı sıfırla
                  icon: const Icon(Icons.refresh),
                  iconSize: 28,
                  tooltip: 'Sıfırla',
                  style: IconButton.styleFrom(padding: const EdgeInsets.all(16)),
                ),
                const SizedBox(width: 20),

                // Ana Başlat / Duraklat Butonu (Büyük Yuvarlak Buton)
                ElevatedButton(
                  onPressed: timerProv.isRunning ? timerProv.pauseTimer : timerProv.startTimer,
                  style: ElevatedButton.styleFrom(
                    // Çalışıyorsa duraklatma için kırmızı, duruyorsa başlatmak için ana renk
                    backgroundColor: timerProv.isRunning ? AppColors.wrong : AppColors.primary,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(24),
                  ),
                  child: Icon(
                    timerProv.isRunning ? Icons.pause : Icons.play_arrow, // Duruma göre oynat/duraklat ikonu
                    size: 36,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),

                // Bitir ve Kaydet Butonu (Kaydetme simgesi)
                IconButton.filledTonal(
                  onPressed: () {
                    timerProv.pauseTimer(); // Sayacı duraklat
                    final mins = timerProv.elapsedStudyMinutes; // Çalışılan dakikayı hesapla
                    SaveSessionDialog.show(
                      context,
                      durationMinutes: mins,
                      sessionType: timerProv.mode == StudyTimerMode.stopwatch
                          ? 'stopwatch'
                          : 'pomodoro',
                    );
                  },
                  icon: const Icon(Icons.bookmark_add_outlined),
                  iconSize: 28,
                  tooltip: 'Bitir ve Kaydet',
                  style: IconButton.styleFrom(padding: const EdgeInsets.all(16)),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // --- 4. Bugün Tamamlanan Çalışma Oturumları Listesi ---
            if (questionProv.sessions.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Bugünkü Çalışma Oturumları',
                  style: theme.textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 12),
              // Son 4 çalışma oturumunu listeler
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: questionProv.sessions.take(4).length,
                itemBuilder: (context, index) {
                  final session = questionProv.sessions[index];
                  final color = AppColors.getCourseColor(session.courseId);
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
                        // Ders rengi noktası
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 10),
                        // Ders adı
                        Expanded(
                          child: Text(
                            session.courseId.toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                        ),
                        // Çalışılan süre
                        Text(
                          AppDateUtils.formatDuration(session.durationInMinutes),
                          style: TextStyle(fontWeight: FontWeight.w700, color: color),
                        ),
                        const SizedBox(width: 10),
                        // Çalışmanın yapıldığı saat (Örn: 14:30)
                        Text(
                          AppDateUtils.formatTime(session.date),
                          style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
