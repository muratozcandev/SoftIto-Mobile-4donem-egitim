import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/theme_controller.dart';
import '../controllers/damage_report_controller.dart';
import '../models/damage_report_model.dart';

/// [DamageReportView] ekranı, uygulamanın ana odak noktası olan **AraÇek** modülüdür.
/// Aracın teslim alınması ve bırakılması sırasında 4 cepheden (Ön, Arka, Sol, Sağ)
/// fotoğraf çekilmesini, varsa hasar ve çizik notlarının girilmesini ve
/// güvenli teslimat raporu oluşturulmasını simüle eder.
class DamageReportView extends StatefulWidget {
  /// Eğer belirli bir kiralık araç üzerinden gelindiyse araç adı
  final String? prefilledVehicleName;

  const DamageReportView({
    super.key,
    this.prefilledVehicleName,
  });

  @override
  State<DamageReportView> createState() => _DamageReportViewState();
}

class _DamageReportViewState extends State<DamageReportView> {
  final _damageNoteController = TextEditingController();
  late String _vehicleName;

  final List<String> _sampleVehiclesNames = [
    'Tesla Model S Plaid',
    'Jaguar F-Pace SVR Carbon',
    'Ferrari 720S Spider Performance',
    'Volkswagen ID.3 Neo Edition',
    'Renault Clio V E-Tech',
    'Porsche Taycan 4S Cross',
  ];

  @override
  void initState() {
    super.initState();
    _vehicleName = widget.prefilledVehicleName ?? _sampleVehiclesNames.first;
    DamageReportController.instance.resetForm();
  }

  @override
  void dispose() {
    _damageNoteController.dispose();
    super.dispose();
  }

  /// Fotoğraf çekme simülasyonu
  void _triggerPhotoCapture(String angle, String angleName) async {
    // Kamera deklanşör hissi için kısa gecikme
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('📸 $angleName fotoğrafı çekiliyor...'),
        duration: const Duration(milliseconds: 700),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 500));
    DamageReportController.instance.simulateCapture(angle);

    if (mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ $angleName başarıyla kaydedildi!'),
          backgroundColor: AppColors.success,
          duration: const Duration(milliseconds: 900),
        ),
      );
    }
  }

  /// Raporu tamamlama ve kaydetme
  void _saveReport() {
    DamageReportController.instance.setDamageNote(_damageNoteController.text);
    final report = DamageReportController.instance.saveReport(
      vehicleName: _vehicleName,
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.verified_rounded, color: AppColors.success, size: 28),
            SizedBox(width: 8),
            Text('AraÇek Raporu Hazır'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rapor Takip No: ${report.id}'),
            const SizedBox(height: 6),
            Text('Araç: ${report.vehicleName}'),
            const SizedBox(height: 6),
            Text('Çekilen Fotoğraf: ${report.photosCount} / 4'),
            const SizedBox(height: 6),
            Text('Konum: ${report.location}'),
            const SizedBox(height: 12),
            const Text(
              'Teslimat ve hasar durumu başarıyla mühürlendi. Güvenle yola çıkabilirsiniz.',
              style: TextStyle(fontSize: 13, color: AppColors.darkTextSecondary),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {});
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeController.instance.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AraÇek - Teslim & Hasar'),
        actions: [
          // Tüm açıları tek tıkla çekme demo kısayolu
          TextButton.icon(
            onPressed: () {
              DamageReportController.instance.captureAllAngles();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('📸 Tüm 4 cephe simüle edilerek çekildi!'),
                  backgroundColor: AppColors.primaryDark,
                ),
              );
            },
            icon: const Icon(Icons.auto_fix_high_rounded, size: 16),
            label: const Text('Hızlı Çek'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Bilgilendirici Başlık Kartı
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withAlpha(isDark ? 35 : 20),
                      AppColors.accent.withAlpha(isDark ? 35 : 20),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.primary.withAlpha(80)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_rounded, color: Colors.black, size: 28),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AraÇek Güvencesi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Aracınızı teslim alırken ve iade ederken 4 cepheden çekim yapın, sürpriz masraflardan korunun.',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 2. İlgili Araç Seçimi
              const Text(
                'İncelenen Araç',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _vehicleName,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.directions_car_rounded),
                ),
                items: _sampleVehiclesNames.map((name) {
                  return DropdownMenuItem<String>(
                    value: name,
                    child: Text(name, style: const TextStyle(fontSize: 14)),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _vehicleName = val);
                },
              ),
              const SizedBox(height: 22),

              // 3. 4 Cephe Fotoğraf Çekim Alanı
              const Text(
                '4 Cephe Fotoğraf Kontrolü',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.15,
                children: [
                  // Ön Cephe
                  ValueListenableBuilder<String?>(
                    valueListenable: DamageReportController.instance.frontPhotoNotifier,
                    builder: (_, photo, _) => _buildPhotoTile(
                      'Ön Cephe',
                      Icons.front_hand_rounded,
                      photo,
                      () => _triggerPhotoCapture('front', 'Ön Cephe'),
                      isDark,
                    ),
                  ),
                  // Arka Cephe
                  ValueListenableBuilder<String?>(
                    valueListenable: DamageReportController.instance.rearPhotoNotifier,
                    builder: (_, photo, _) => _buildPhotoTile(
                      'Arka Cephe',
                      Icons.back_hand_rounded,
                      photo,
                      () => _triggerPhotoCapture('rear', 'Arka Cephe'),
                      isDark,
                    ),
                  ),
                  // Sol Yan
                  ValueListenableBuilder<String?>(
                    valueListenable: DamageReportController.instance.leftPhotoNotifier,
                    builder: (_, photo, _) => _buildPhotoTile(
                      'Sol Yan',
                      Icons.arrow_back_rounded,
                      photo,
                      () => _triggerPhotoCapture('left', 'Sol Yan'),
                      isDark,
                    ),
                  ),
                  // Sağ Yan
                  ValueListenableBuilder<String?>(
                    valueListenable: DamageReportController.instance.rightPhotoNotifier,
                    builder: (_, photo, _) => _buildPhotoTile(
                      'Sağ Yan',
                      Icons.arrow_forward_rounded,
                      photo,
                      () => _triggerPhotoCapture('right', 'Sağ Yan'),
                      isDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // 4. Hasar Notu ve Açıklama Alanı
              const Text(
                'Hasar Notu ve Açıklama',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _damageNoteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Varsa tampon çiziği, jant sürtmesi, taş izi vb. açıklayınız...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 40.0),
                    child: Icon(Icons.edit_note_rounded),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 5. Raporu Kaydet Butonu
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _saveReport,
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  label: const Text(
                    'AraÇek Raporunu Kaydet',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // 6. Kayıtlı Önceki AraÇek Raporları
              ValueListenableBuilder<List<DamageReport>>(
                valueListenable: DamageReportController.instance.reportsNotifier,
                builder: (context, reports, _) {
                  if (reports.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kaydedilen Son AraÇek Raporları',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 12),
                      ...reports.map((rep) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.success.withAlpha(30),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.task_alt_rounded, color: AppColors.success),
                            ),
                            title: Text(rep.vehicleName, style: const TextStyle(fontWeight: FontWeight.w700)),
                            subtitle: Text('${rep.id} • ${rep.location}\nNot: ${rep.damageNotes}'),
                            isThreeLine: true,
                          ),
                        );
                      }),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Fotoğraf kutucuğu oluşturucu yardımcı widget
  Widget _buildPhotoTile(
    String title,
    IconData icon,
    String? photoPath,
    VoidCallback onTap,
    bool isDark,
  ) {
    final hasPhoto = photoPath != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: hasPhoto
              ? AppColors.primary.withAlpha(isDark ? 30 : 20)
              : (isDark ? AppColors.darkSurface : AppColors.lightSurface),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasPhoto
                ? AppColors.primary
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: hasPhoto ? 1.8 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  hasPhoto ? Icons.check_circle_rounded : Icons.add_a_photo_outlined,
                  size: 36,
                  color: hasPhoto ? AppColors.primary : AppColors.darkTextSecondary,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: hasPhoto
                    ? AppColors.primary
                    : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              hasPhoto ? 'Fotoğraf Çekildi' : 'Dokun ve Çek',
              style: TextStyle(
                fontSize: 11,
                color: hasPhoto
                    ? AppColors.success
                    : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
