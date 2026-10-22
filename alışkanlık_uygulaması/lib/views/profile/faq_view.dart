import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class FaqView extends StatelessWidget {
  const FaqView({super.key});

  final List<Map<String, String>> faqs = const [
    {
      'question': 'Alışkanlık Takibi uygulaması nasıl çalışır?',
      'answer':
          'Günlük kalori, su, adım ve uyku hedeflerinizi belirleyebilir, gün içinde gerçekleşen değerlerinizi ekleyerek hedefinizi tamamlayabilirsiniz.',
    },
    {
      'question': 'Başarı rozetlerini nasıl kazanırım?',
      'answer':
          'Belirlediğiniz herhangi bir hedefi %100 veya üzeri tamamladığınızda sistem otomatik olarak ilgili başarı rozetini profilinize ekler.',
    },
    {
      'question': 'Verilerim nerede saklanıyor?',
      'answer':
          'Uygulama yerel prototip modunda çalışmakta olup harici bir sunucu veya üçüncü taraf veri tabanı gerektirmeden cihazınızın yerel hafızasında anlık olarak tutulur.',
    },
    {
      'question': 'Karanlık modu nasıl açabilirim?',
      'answer':
          'Profil ve Ayarlar menüsünden "Görsel Tema" seçeneğine tıklayarak Açık, Koyu veya Sistem Varsayılanı temalarından birini seçebilirsiniz.',
    },
    {
      'question': 'Hedeflerimi sonradan değiştirebilir miyim?',
      'answer':
          'Evet! Alt menüdeki "Ekle" sekmesinden veya ana ekrandaki kartlara tıklayarak dilediğiniz zaman yeni hedef belirleyebilir veya gerçekleşen değerleri güncelleyebilirsiniz.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sıkça Sorulan Sorular (S.S.S.)'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: isDark ? 2 : 1,
            child: Theme(
              data: theme.copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                iconColor: AppColors.primary,
                collapsedIconColor: isDark ? Colors.white60 : Colors.grey.shade600,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.help_outline_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                title: Text(
                  faq['question']!,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      faq['answer']!,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
