import 'package:flutter/material.dart';
import '../controllers/app_controller.dart';
import '../core/constants/app_colors.dart';
import '../models/business_idea_model.dart';
import '../widgets/app_button.dart';
import '../widgets/business_card.dart';
import 'business_detail_screen.dart';

class MyIdeasScreen extends StatefulWidget {
  const MyIdeasScreen({super.key});

  @override
  State<MyIdeasScreen> createState() => _MyIdeasScreenState();
}

class _MyIdeasScreenState extends State<MyIdeasScreen> {
  void _showAddIdeaModal() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final titleController = TextEditingController();
    final categoryController = TextEditingController(text: 'FinTech & AI');
    final shortDescController = TextEditingController();
    final fullDescController = TextEditingController();
    final businessModelController = TextEditingController();
    final targetAudienceController = TextEditingController();
    final amountController = TextEditingController(text: '50000');
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.darkCard : AppColors.lightCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Yeni İş Fikri Oluştur',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Başlık
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Girişim / Fikir Başlığı',
                      hintText: 'Örn: RoboGarson Otonom Servis',
                    ),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Başlık zorunludur' : null,
                  ),
                  const SizedBox(height: 12),

                  // Kategori
                  TextFormField(
                    controller: categoryController,
                    decoration: const InputDecoration(
                      labelText: 'Kategori',
                      hintText: 'Örn: Robotik & AI',
                    ),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Kategori zorunludur' : null,
                  ),
                  const SizedBox(height: 12),

                  // Hedef Yatırım (TL)
                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Hedef Yatırım Tutarı (TL)',
                      hintText: '50000',
                      prefixText: '₺ ',
                    ),
                    validator: (v) {
                      final val = double.tryParse(v ?? '');
                      if (val == null || val <= 0) return 'Geçerli bir tutar girin';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Kısa Açıklama
                  TextFormField(
                    controller: shortDescController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Kısa Tanıtım (Kart Görünümü İçin)',
                      hintText: 'Fikrinizin 1-2 cümlelik vurucu özeti...',
                    ),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Kısa açıklama giriniz' : null,
                  ),
                  const SizedBox(height: 12),

                  // Detaylı Açıklama
                  TextFormField(
                    controller: fullDescController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Detaylı Girişim Açıklaması',
                      hintText: 'Sorun nedir ve bu girişim nasıl çözüyor?',
                    ),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Detay giriniz' : null,
                  ),
                  const SizedBox(height: 12),

                  // İş Modeli
                  TextFormField(
                    controller: businessModelController,
                    decoration: const InputDecoration(
                      labelText: 'Gelir Modeli',
                      hintText: 'Örn: Aylık SaaS aboneliği ve komisyon',
                    ),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'İş modeli giriniz' : null,
                  ),
                  const SizedBox(height: 12),

                  // Hedef Kitle
                  TextFormField(
                    controller: targetAudienceController,
                    decoration: const InputDecoration(
                      labelText: 'Hedef Kitle',
                      hintText: 'Örn: Restoranlar, kafeler ve oteller',
                    ),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Hedef kitle giriniz' : null,
                  ),
                  const SizedBox(height: 24),

                  AppButton(
                    text: 'Fikri Yayınla & Fonlamaya Aç',
                    icon: Icons.rocket_launch_rounded,
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        final double amountTl =
                            double.parse(amountController.text.trim());
                        final int amountKurus = (amountTl * 100).round();

                        AppController.instance.addMyIdea(
                          title: titleController.text.trim(),
                          category: categoryController.text.trim(),
                          shortDescription: shortDescController.text.trim(),
                          fullDescription: fullDescController.text.trim(),
                          businessModel: businessModelController.text.trim(),
                          targetAudience: targetAudienceController.text.trim(),
                          investmentAmountInKurus: amountKurus,
                          icon: Icons.lightbulb_rounded,
                        );

                        Navigator.of(context).pop();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '"${titleController.text.trim()}" fikriniz başarıyla oluşturuldu ve vitrine eklendi!',
                            ),
                            backgroundColor: AppColors.primaryEmerald,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kendi İş Fikirlerim'),
        actions: [
          IconButton(
            onPressed: _showAddIdeaModal,
            icon: const Icon(Icons.add_circle_outline_rounded),
            tooltip: 'Yeni Fikir Ekle',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder<List<BusinessIdeaModel>>(
          valueListenable: AppController.instance.myIdeas,
          builder: (context, myIdeas, _) {
            if (myIdeas.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.darkCard : AppColors.lightCard,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.lightbulb_outline_rounded,
                          size: 54,
                          color: isDark
                              ? AppColors.primaryMint
                              : AppColors.primaryEmerald,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Henüz İş Fikri Eklenmedi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Aklınızdaki yenilikçi fikri ekleyip yatırımcıların beğenisine sunun.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      AppButton(
                        text: 'Yeni İş Fikri Ekle',
                        icon: Icons.add_rounded,
                        isFullWidth: false,
                        onPressed: _showAddIdeaModal,
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: myIdeas.length,
              separatorBuilder: (context, index) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final idea = myIdeas[index];
                return BusinessCard(
                  idea: idea,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BusinessDetailScreen(idea: idea),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddIdeaModal,
        backgroundColor:
            isDark ? AppColors.primaryMint : AppColors.primaryEmerald,
        foregroundColor: isDark ? AppColors.darkBackground : Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Yeni Fikir Ekle',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
