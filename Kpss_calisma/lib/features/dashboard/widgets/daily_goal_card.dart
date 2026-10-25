import 'package:flutter/material.dart'; // Flutter Material UI kütüphanesi
import 'package:provider/provider.dart'; // Durum yönetimi için Provider
import '../../../providers/question_provider.dart'; // Bugün çözülen soruları getiren sağlayıcı
import '../../../providers/settings_provider.dart'; // Günlük soru hedefini getiren ve güncelleyen sağlayıcı

/// Ana sayfada en üstte yer alan, kullanıcının günlük soru hedefini, ilerleme dairesini ve kalan soru adedini gösteren kart bileşeni
class DailyGoalCard extends StatelessWidget {
  const DailyGoalCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Soru ve ayar sağlayıcılarını izler (değişiklik olduğunda anında yeniden çizilir)
    final questionProv = context.watch<QuestionProvider>();
    final settingsProv = context.watch<SettingsProvider>();

    final goal = settingsProv.dailyGoal; // Hedeflenen soru sayısı (Örn: 100)
    final solved = questionProv.todayTotalQuestions; // Bugün toplam çözülen soru sayısı
    // İlerleme yüzdesini 0.0 ile 1.0 arasına sıkıştırır (Sıfıra bölünme korumasıyla)
    final progress = (goal == 0 ? 0.0 : (solved / goal)).clamp(0.0, 1.0);
    final isGoalReached = solved >= goal; // Hedefe ulaşılıp ulaşılmadığı kontrolü
    final remaining = (goal - solved) > 0 ? (goal - solved) : 0; // Hedefe kalan soru sayısı

    return Container(
      padding: const EdgeInsets.all(20), // Kart içi kenar boşlukları
      decoration: BoxDecoration(
        // Hedefe ulaşıldıysa yeşil degrade (gradient), hedefe henüz ulaşılmadıysa mor/indigo degrade uygular
        gradient: LinearGradient(
          colors: isGoalReached
              ? [const Color(0xFF10B981), const Color(0xFF059669)] // Başarı Yeşili degrade tonları
              : [const Color(0xFF6366F1), const Color(0xFF4F46E5)], // İndigo / Mor degrade tonları
          begin: Alignment.topLeft, // Degrade başlangıç noktası: Sol üst
          end: Alignment.bottomRight, // Degrade bitiş noktası: Sağ alt
        ),
        borderRadius: BorderRadius.circular(20), // Kart köşelerine 20px ovallik verir
        boxShadow: [
          // Karta derinlik ve parlama hissi veren renkli yumuşak alt gölge
          BoxShadow(
            color: (isGoalReached ? const Color(0xFF10B981) : const Color(0xFF6366F1))
                .withValues(alpha: 0.35),
            blurRadius: 16, // Gölge yayılma yumuşaklığı
            offset: const Offset(0, 8), // Dikeyde 8px aşağı gölge
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Üst Başlık ve Hedef Değiştirme Butonu Satırı ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Sol taraftaki ikon ve başlık
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2), // Saydam beyaz yuvarlak zemin
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isGoalReached ? Icons.workspace_premium : Icons.track_changes, // Hedef bittiyse kupa/ödül ikonu
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    isGoalReached ? 'Hedef Tamamlandı! 🎉' : 'Günlük Soru Hedefi',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              // Sağ taraftaki hedef düzenleme butonu
              InkWell(
                onTap: () => _showGoalEditDialog(context, goal, settingsProv), // Tıklandığında hedef düzenleme dialoğu açılır
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2), // Saydam beyaz arka plan
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.edit, size: 14, color: Colors.white), // Düzenle kalemi ikonu
                      SizedBox(width: 4),
                      Text(
                        'Hedef',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          
          // --- Alt Bilgiler: Çözülen Soru Sayısı ve Dairesel İlerleme Göstergesi ---
          Row(
            children: [
              // Sol taraf: Çözülen / Hedef metinleri
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          // Büyük çözülen soru sayısı
                          TextSpan(
                            text: '$solved',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                            ),
                          ),
                          // Yanındaki hedef soru sayısı
                          TextSpan(
                            text: ' / $goal soru',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Motive edici durum açıklaması
                    Text(
                      isGoalReached
                          ? 'Harika! Bugün hedefini aştın.'
                          : 'Hedefe ulaşmak için son $remaining soru kaldı.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              
              // Sağ taraf: Dairesel İlerleme Göstergesi ve Ortasındaki Yüzdelik Değer
              Stack(
                alignment: Alignment.center, // Yüzde metnini dairenin tam ortasına konumlandırır
                children: [
                  SizedBox(
                    width: 64, // Daire çapı genişlik
                    height: 64, // Daire çapı yükseklik
                    child: CircularProgressIndicator(
                      value: progress, // 0.0 - 1.0 arası doluluk
                      strokeWidth: 6, // Halka kalınlığı
                      backgroundColor: Colors.white.withValues(alpha: 0.2), // Boş kısmın arka planı
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white), // Dolan kısmın beyaz rengi
                      strokeCap: StrokeCap.round, // Çizgi uçlarına ovallik verir
                    ),
                  ),
                  Text(
                    '%${(progress * 100).toInt()}', // Tam sayı yüzde değeri
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Kullanıcının yeni bir günlük soru hedefi girmesini sağlayan diyalog penceresi
  void _showGoalEditDialog(
    BuildContext context,
    int currentGoal,
    SettingsProvider settingsProv,
  ) {
    // Mevcut hedef değerini metin kutusuna varsayılan olarak yazar
    final controller = TextEditingController(text: currentGoal.toString());
    
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Günlük Hedefi Değiştir'), // Pencere başlığı
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number, // Sadece sayısal klavye açar
          autofocus: true, // Açılır açılmaz klavyeyi odaklar
          decoration: const InputDecoration(
            labelText: 'Günlük Hedef Soru Sayısı',
            suffixText: 'soru', // Kutunun sonundaki 'soru' eki
          ),
        ),
        actions: [
          // İptal butonu
          TextButton(
            onPressed: () => Navigator.pop(ctx), // Diyaloğu kapat
            child: const Text('İptal'),
          ),
          // Kaydet butonu
          ElevatedButton(
            onPressed: () {
              final val = int.tryParse(controller.text); // Girilen değeri tam sayıya çevir
              if (val != null && val > 0) {
                settingsProv.setDailyGoal(val); // Yeni hedefi ayarlar provider'ına kaydet
              }
              Navigator.pop(ctx); // Pencereyi kapat
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }
}
