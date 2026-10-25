import 'package:flutter/material.dart'; // Flutter Material arayüz bileşenleri
import '../../../core/constants/app_colors.dart'; // Durum ve ders renkleri
import '../../../core/constants/app_constants.dart'; // Durum kodları (Başlanmadı, Tekrar, Tamamlandı)
import '../../../models/topic.dart'; // Topic veri modeli

/// Müfredat listesindeki tek bir alt konuyu, durumunu ve durum değiştirme menüsünü gösteren kart bileşeni
class TopicItemTile extends StatelessWidget {
  final Topic topic; // Görüntülenecek alt konu nesnesi (id ve title)
  final int status; // Konunun mevcut durumu (0: Çalışılmadı, 1: Tekrar Edilecek, 2: Bitirildi)
  final Color courseColor; // Ait olduğu dersin kimlik rengi
  final ValueChanged<int> onStatusChanged; // Kullanıcı yeni durum seçtiğinde tetiklenecek geri çağırma (callback) fonksiyonu

  /// TopicItemTile kurucu metodu (Constructor)
  const TopicItemTile({
    super.key,
    required this.topic, // Konu nesnesi zorunlu
    required this.status, // Durum kodu zorunlu
    required this.courseColor, // Ders rengi zorunlu
    required this.onStatusChanged, // Durum değişimi fonksiyonu zorunlu
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Aktif temayı alır (açık veya koyu tema)
    final statusColor = _getStatusColor(status); // Duruma karşılık gelen rengi belirler
    final statusLabel = _getStatusLabel(status); // Duruma karşılık gelen metni alır
    final statusIcon = _getStatusIcon(status); // Duruma karşılık gelen simgeyi alır

    return Container(
      margin: const EdgeInsets.only(bottom: 10), // Kartlar arasına dikey 10px boşluk bırakır
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12), // Kart içi dolgusu
      decoration: BoxDecoration(
        color: theme.cardTheme.color, // Temaya uygun kart arka plan rengi
        borderRadius: BorderRadius.circular(14), // Kart köşelerine 14px ovallik
        border: Border.all(
          // Konu tamamlandıysa hafif yeşil kenarlık, değilse temaya uygun gri kenarlık verir
          color: status == AppConstants.statusCompleted
              ? AppColors.completed.withValues(alpha: 0.3)
              : (theme.brightness == Brightness.dark
                  ? const Color(0xFF334155)
                  : const Color(0xFFE2E8F0)),
        ),
      ),
      child: Row(
        children: [
          // Sol taraftaki renkli durum çubuğu göstergesi
          Container(
            width: 8, // Genişlik 8px
            height: 38, // Yükseklik 38px
            decoration: BoxDecoration(
              color: statusColor, // Durum rengi (Gri, Turuncu veya Yeşil)
              borderRadius: BorderRadius.circular(4), // Çubuk köşelerine hafif yuvarlaklık
            ),
          ),
          const SizedBox(width: 12), // Çubuk ile metin arası boşluk
          
          // Konu Başlığı ve Durum Metni Alanı
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Metinleri sola yaslar
              children: [
                // Konu başlığı
                Text(
                  topic.title,
                  style: TextStyle(
                    fontSize: 14, // Yazı boyutu
                    fontWeight: FontWeight.w600, // Yarı kalın font
                    decoration: status == AppConstants.statusCompleted
                        ? TextDecoration.none
                        : null,
                  ),
                ),
                const SizedBox(height: 4), // Başlık ile durum arası boşluk
                // Durum etiketi metni (Bitirildi, Tekrar Edilecek veya Çalışılmadı)
                Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor, // Durum renginde metin
                  ),
                ),
              ],
            ),
          ),
          
          // Sağ taraftaki açılır durum değiştirme menüsü (PopupMenuButton)
          PopupMenuButton<int>(
            initialValue: status, // Mevcut seçili durum
            onSelected: onStatusChanged, // Yeni durum seçildiğinde çalışır
            tooltip: 'Durumu Değiştir', // İpucu metni
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Açılır menü köşelerini yuvarlar
            itemBuilder: (context) => [
              // 1. Seçenek: Çalışılmadı
              _buildMenuItem(
                value: AppConstants.statusNotStarted,
                title: 'Çalışılmadı',
                icon: Icons.circle_outlined,
                color: AppColors.notStarted,
              ),
              // 2. Seçenek: Tekrar Edilecek
              _buildMenuItem(
                value: AppConstants.statusNeedsReview,
                title: 'Tekrar Edilecek',
                icon: Icons.sync,
                color: AppColors.needsReview,
              ),
              // 3. Seçenek: Bitirdim
              _buildMenuItem(
                value: AppConstants.statusCompleted,
                title: 'Bitirdim',
                icon: Icons.check_circle,
                color: AppColors.completed,
              ),
            ],
            // Menüyü tetikleyen şık durum butonu kapsülü
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12), // Durum renginin saydam arka planı
                borderRadius: BorderRadius.circular(10), // Buton ovalliği
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(statusIcon, color: statusColor, size: 16), // Durum simgesi
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey), // Aşağı ok simgesi
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Açılır menüdeki tek bir satırı inşa eden yardımcı fonksiyon
  PopupMenuItem<int> _buildMenuItem({
    required int value, // Durum tamsayı kodu
    required String title, // Ekranda görünecek durum adı
    required IconData icon, // Yanındaki ikon
    required Color color, // İkon ve metin rengi
  }) {
    return PopupMenuItem<int>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18), // Seçenek ikonu
          const SizedBox(width: 10), // İkon-yazı arası boşluk
          Text(
            title, // Durum metni
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// Durum koduna karşılık gelen rengi döndürür
  Color _getStatusColor(int status) {
    switch (status) {
      case AppConstants.statusCompleted:
        return AppColors.completed; // Yeşil
      case AppConstants.statusNeedsReview:
        return AppColors.needsReview; // Turuncu/Amber
      default:
        return AppColors.notStarted; // Gri
    }
  }

  /// Durum koduna karşılık gelen Türkçe açıklama metnini döndürür
  String _getStatusLabel(int status) {
    switch (status) {
      case AppConstants.statusCompleted:
        return 'Bitirildi';
      case AppConstants.statusNeedsReview:
        return 'Tekrar Edilecek';
      default:
        return 'Çalışılmadı';
    }
  }

  /// Durum koduna karşılık gelen ikon nesnesini döndürür
  IconData _getStatusIcon(int status) {
    switch (status) {
      case AppConstants.statusCompleted:
        return Icons.check_circle; // Onaylı dolu daire
      case AppConstants.statusNeedsReview:
        return Icons.sync; // Tekrar / senkronizasyon ikonu
      default:
        return Icons.radio_button_unchecked; // Boş çember ikonu
    }
  }
}
