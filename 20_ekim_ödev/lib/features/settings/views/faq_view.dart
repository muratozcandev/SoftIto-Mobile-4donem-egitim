<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: faq_view.dart
// Görev: Sıkça Sorulan Sorular (SSS) ve yardım kılavuzu ekranı.
// Açıklama: AraÇek hasar tespit mantığını, kiralama kurallarını ve ödeme güvencesini açıklar.
// ==============================================================================

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/localization/locale_controller.dart';

/// [FaqView] widget'ı, kullanıcının aklına gelebilecek soruları yanıtlayan akordeon yapılı ekrandır.
class FaqView extends StatelessWidget {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    final isEn = LocaleController.instance.isEnglish;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final faqItems = [
      {
        'q': isEn
            ? 'How does the AraÇek Photo Inspection system work?'
            : 'AraÇek Fotoğraf Çekim & Hasar Tespit sistemi nasıl çalışır?',
        'a': isEn
            ? 'Before taking delivery and when returning the car, you take clear photos of all 4 sides (Front, Rear, Left, Right). Photos are cryptographically timestamped and saved to protect you against false damage claims.'
            : 'Aracı teslim alırken ve teslim ederken 4 cephesinin (Ön, Arka, Sol, Sağ) fotoğraflarını çekersiniz. Çekilen fotoğraflar zaman damgası ve konum bilgisiyle tutanağa işlenir; haksız hasar taleplerinden korunursunuz.',
      },
      {
        'q': isEn
            ? 'What is the maximum rental duration?'
            : 'Kiralama süresi en az ve en fazla kaç gün olabilir?',
        'a': isEn
            ? 'You can rent any vehicle dynamically from 1 to 31 days. Discounts are automatically calculated for prolonged reservations.'
            : 'Kiralama süresi 1 ile 31 gün arasında dinamik olarak seçilebilir. Uzun süreli kiralamalarda kupon indirimleri uygulanabilir.',
      },
      {
        'q': isEn
            ? 'What does the Full Coverage Insurance include?'
            : 'Tam Kasko ve Güvence Paketi neleri kapsar?',
        'a': isEn
            ? 'It includes zero-deductible accident protection, windshield/tire coverage, and 24/7 roadside assistance nationwide.'
            : 'Muafiyetsiz kasko güvencesi, cam-far-lastik hasar teminatı ve 7/24 kesintisiz yol yardım hizmetini kapsar.',
      },
      {
        'q': isEn
            ? 'Where can I return the vehicle?'
            : 'Aracı hangi noktalarda teslim edebilirim?',
        'a': isEn
            ? 'Vehicles can be returned at designated airport terminals, city hub stations, and partner parking garages across Turkey.'
            : 'Anlaşmalı havalimanı otopark katlarında (IST, SAW, ESB, ADB) veya şehir merkezi AraÇek teslimat noktalarında teslim edebilirsiniz.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.helpFaq(isEn)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 550),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    isEn
                        ? 'Frequently Asked Questions'
                        : 'Sıkça Sorulan Sorular',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // SSS Akordeon Kartları
                  ...faqItems.map((item) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ExpansionTile(
                        iconColor: AppColors.primary,
                        collapsedIconColor: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                        title: Text(
                          item['q']!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Text(
                              item['a']!,
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.5,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
=======
>>>>>>> Stashed changes
import 'package:flutter/material.dart';

/// [FaqView] ekranı, kullanıcıların araç kiralama şartları, AraÇek fotoğraf
/// ve hasar güvencesi hakkında en çok merak ettiği soruları ve yanıtlarını sunar.
class FaqView extends StatelessWidget {
  const FaqView({super.key});

  static const List<Map<String, String>> faqs = [
    {
      'question': 'AraÇek teslimat ve fotoğraf kontrolü nasıl çalışır?',
      'answer':
          'Aracı teslim alırken ve teslim ederken AraÇek sekmesinden aracın 4 cephesinin (Ön, Arka, Sol, Sağ) fotoğrafını çekersiniz. Bu fotoğraflar sistemimizde zaman damgasıyla saklanarak teslim anındaki mevcut durumu belgeler ve haksız hasar masraflarından korunmanızı sağlar.',
    },
    {
      'question': 'Kiralama süresi en az ve en çok kaç gün olabilir?',
      'answer':
          'AraÇek üzerinden kiralama süresi minimum 1 gün, maksimum 31 gün olarak seçilebilir. 31 günden uzun kiralamalar için aylık kurumsal filo seçeneklerimiz mevcuttur.',
    },
    {
      'question': 'Kasko ve sigorta neleri kapsar?',
      'answer':
          'Tüm araçlarımızda tam kapsamlı kasko ve 7/24 çekici/yol yardım hizmeti ücretsiz olarak kiralama bedeline dahildir.',
    },
    {
      'question': 'Kimler araç kiralayabilir?',
      'answer':
          'En az 1 yıllık geçerli sürücü belgesine sahip olan ve 21 yaşını doldurmuş tüm sürücüler araç kiralayabilir. Spor ve süper lüks kategoriler için 25 yaş ve üzeri aranmaktadır.',
    },
    {
      'question': 'İptal ve iade koşulları nelerdir?',
      'answer':
          'Kiralama başlama saatine 24 saat kalana kadar yapılan tüm rezervasyon iptallerinde kesintisiz %100 ücret iadesi yapılır.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sıkça Sorulan Sorular'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: faqs.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = faqs[index];
          return Card(
            child: ExpansionTile(
              shape: const Border(),
              title: Text(
                item['question']!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    item['answer']!,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
      ),
    );
  }
}
