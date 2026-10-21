import '../models/auxiliary_models.dart';

/// Günün Bülteni için demo futbol haberleri
abstract class DemoNews {
  static const List<NewsItem> news = [
    NewsItem(
      id: 'news_1',
      title: 'Beşiktaş Liderliğini Sürdürüyor: Zirvede Muhteşem Seri',
      summary: 'Süper Lig\'de fırtına gibi esen siyah-beyazlılar, ligin 24. haftasında en yakın takipçisinin önünde namağlup liderliğini koruyor.',
      category: 'Süper Lig',
      date: 'Bugün 18:45',
      badgeText: 'FLAŞ GELİŞME',
    ),
    NewsItem(
      id: 'news_2',
      title: 'Haftanın Kupon Analizi: Hafta Sonu Maçlarında Sürpriz İpuçları',
      summary: 'Avrupa liglerinde haftanın en kritik maçları yaklaşıyor. Oran analistleri ve uzmanlar olası gollü maçları listeledi.',
      category: 'Kupon Analiz',
      date: 'Bugün 15:20',
      badgeText: 'ÖNE ÇIKAN',
    ),
    NewsItem(
      id: 'news_3',
      title: 'Şampiyonlar Ligi\'nde Dev Gece: Çeyrek Finale Giden Yol',
      summary: 'Avrupa\'nın 1 numaralı kupasında 36 takımlı yeni lig etabında heyecan dorukta. Bu akşam nefesler tutulacak.',
      category: 'UEFA',
      date: 'Dün 21:00',
      badgeText: 'CANLI BÜLTEN',
    ),
    NewsItem(
      id: 'news_4',
      title: 'Premier Lig\'de Zirve Karıştı: Lider Deplasmanda Puan Kaybetti',
      summary: 'İngiltere Premier Ligi\'nde haftanın açılış maçında favori takım beklemediği bir beraberlikle sahadan ayrıldı.',
      category: 'Premier Lig',
      date: 'Dün 16:30',
      badgeText: 'DÜNYADAN',
    ),
  ];
}
