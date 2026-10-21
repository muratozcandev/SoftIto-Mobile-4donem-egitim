import 'package:flutter/material.dart';
import '../models/business_idea_model.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';

class DemoData {
  static const UserModel initialUser = UserModel(
    id: 'user_1',
    name: 'Deniz Arda',
    email: 'deniz.arda@giriselim.com',
    title: 'Girişimci & Melek Yatırımcı',
    avatarInitials: 'DA',
  );

  static const List<String> demoRecipients = [
    'Ahmet Yılmaz (Tohum Fonu Yöneticisi)',
    'Zeynep Kaya (BioTech AR-GE Kurucusu)',
    'Mehmet Demir (Yapay Zeka Laboratuvarı)',
    'Elif Çelik (Temiz Enerji Kooperatifi)',
    'Burak Şahin (Mikro-Mobilite Girişimi)',
  ];

  static List<BusinessIdeaModel> get initialBusinessIdeas => [
        const BusinessIdeaModel(
          id: 'idea_1',
          title: 'TarımTek: Akıllı Sulama & IoT',
          category: 'AgriTech & IoT',
          shortDescription:
              'Toprak nemini ve hava tahminlerini yapay zeka ile işleyerek su tasarrufu sağlayan otonom sulama istasyonları.',
          fullDescription:
              'TarımTek, tarla bazında yerleştirilen düşük maliyetli sensör ağları ve uydu verileriyle entegre çalışan akıllı tarım çözümüdür. Çiftçilere mobil uygulama üzerinden gerçek zamanlı sulama ve gübreleme reçeteleri sunar; su tüketimini %42 oranında azaltırken rekolteyi %25 artırır.',
          businessModel:
              'Cihaz donanım satışı + Dönüm bazlı aylık SaaS abonelik modeli.',
          targetAudience:
              'Endüstriyel tarım işletmeleri, kooperatifler ve modern sera üreticileri.',
          investmentAmount: 7500000, // 75.000 TL
          icon: Icons.eco_rounded,
          founderName: 'Selin Yıldız (Ziraat Müh.)',
          fundingPercentage: 0.65,
        ),
        const BusinessIdeaModel(
          id: 'idea_2',
          title: 'HızlıKurye: Yeşil Mikro Lojistik',
          category: 'Lojistik & Çevre',
          shortDescription:
              'Şehir içi son kilometre teslimatlarını sıfır karbon emisyonlu elektrikli kargo bisikletleriyle sağlayan ağ.',
          fullDescription:
              'HızlıKurye, metropollerde kurye trafiğini ve hava kirliliğini azaltmak amacıyla kurulmuş mikro lojistik platformudur. Kompakt kargo merkezlerinden (hub) çıkan elektrikli araçlarla 60 dakikada adrese teslimat garantisi sunar.',
          businessModel:
              'Teslimat başı komisyon ve e-ticaret markaları ile B2B kurumsal entegrasyon.',
          targetAudience:
              'Hızlı ticaret (q-commerce) firmaları, yerel butikler ve e-ticaret satıcıları.',
          investmentAmount: 4000000, // 40.000 TL
          icon: Icons.electric_bike_rounded,
          founderName: 'Caner Özkan (Lojistik Uzm.)',
          fundingPercentage: 0.40,
        ),
        const BusinessIdeaModel(
          id: 'idea_3',
          title: 'SağlıkAsistan: AI Triyaj & Teletıp',
          category: 'HealthTech & AI',
          shortDescription:
              'Semptom analizi yapan medikal yapay zeka asistanı ve 10 dakikada doktor randevu platformu.',
          fullDescription:
              'SağlıkAsistan, onaylı klinik veri setleriyle eğitilmiş yapay zeka algoritması ile hastaların ön değerlendirmesini yapar. Acil olmayan vakalarda doğrudan ilgili branş hekimiyle güvenli görüntülü görüşme başlatır.',
          businessModel:
              'Görüşme başına servis bedeli ve özel sağlık sigortaları ile kurumsal anlaşmalar.',
          targetAudience:
              'Zaman kısıtı olan bireyler, kronik hastalar ve uzaktan sağlık desteği arayanlar.',
          investmentAmount: 6000000, // 60.000 TL
          icon: Icons.health_and_safety_rounded,
          founderName: 'Dr. Zeynep Erdem',
          fundingPercentage: 0.80,
        ),
        const BusinessIdeaModel(
          id: 'idea_4',
          title: 'KodOyun: Çocuklar İçin EdTech',
          category: 'EdTech & Gamification',
          shortDescription:
              '7-14 yaş grubu çocuklara oyun oynayarak algoritma ve kodlama öğreten interaktif macera evreni.',
          fullDescription:
              'KodOyun, blok tabanlı ve metin tabanlı programlama prensiplerini sürükleyici bir RPG oyun hikayesine dönüştürür. Çocuklar bulmacaları çözmek için kod yazar, öğretmenler ve veliler ise detaylı gelişim raporlarını izler.',
          businessModel:
              'Freemium model: Aylık/yıllık aile abonelik paketleri ve okullara özel kurumsal lisanslama.',
          targetAudience:
              'K12 okulları, 7-14 yaş grubu öğrenciler ve teknolojiye duyarlı veliler.',
          investmentAmount: 3000000, // 30.000 TL
          icon: Icons.sports_esports_rounded,
          founderName: 'Alperen Çetin (Yazılım Müh.)',
          fundingPercentage: 0.25,
        ),
        const BusinessIdeaModel(
          id: 'idea_5',
          title: 'AkıllıAtık: Geri Dönüşüm Noktaları',
          category: 'CleanTech & Sürdürülebilirlik',
          shortDescription:
              'Geri dönüştürülebilir atıkları tanıyan ve vatandaşa ödül puanı kazandıran akıllı otomat ağı.',
          fullDescription:
              'AkıllıAtık, optik sensörler ve yapay görme ile pet şişe, cam ve alüminyum kutuları ayrıştıran tersine satış otomatıdır (RVM). Kullanıcılar bıraktıkları her atık için belediye ulaşım kartlarına veya kahve zincirlerine puan kazanır.',
          businessModel:
              'Hammadde geri dönüşüm gelirleri, otomat ekranlarındaki dijital reklamlar ve belediye sözleşmeleri.',
          targetAudience:
              'Yerel belediyeler, üniversite kampüsleri, alışveriş merkezleri ve çevreye duyarlı vatandaşlar.',
          investmentAmount: 5000000, // 50.000 TL
          icon: Icons.recycling_rounded,
          founderName: 'Mert Aksoy (Çevre Müh.)',
          fundingPercentage: 0.50,
        ),
      ];

  static List<TransactionModel> get initialTransactions => [
        TransactionModel(
          id: 'tx_init_1',
          type: TransactionType.deposit,
          title: 'Sanal Başlangıç Sermayesi',
          description: 'Girişelim demo hesabı açılış bakiyesi',
          amount: 10000000, // 100.000 TL
          date: DateTime.now().subtract(const Duration(days: 2)),
          isPositive: true,
        ),
      ];
}
