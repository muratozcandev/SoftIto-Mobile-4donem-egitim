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
      ),
    );
  }
}
