<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: damage_report_view.dart
// Görev: AraÇek hasar tespit, fotoğraf çekimi ve teslimat raporlama ana ekranı.
// Açıklama: Aracın 4 köşesinin fotoğraflanmasını, teslim lokasyonu seçimini,
// hasar notlarını ve teslim tutanağı onayını yönetir.
// ==============================================================================

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/localization/locale_controller.dart';
import '../../vehicles/controllers/vehicle_controller.dart';
import '../controllers/damage_report_controller.dart';
import '../widgets/damage_photo_slot.dart';

/// [DamageReportView] widget'ı, AraÇek fotoğraf çekim ve teslimat ekranıdır.
class DamageReportView extends StatefulWidget {
  const DamageReportView({super.key});
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes

  @override
  State<DamageReportView> createState() => _DamageReportViewState();
}

class _DamageReportViewState extends State<DamageReportView> {
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
  final _reportController = DamageReportController.instance;
  final _notesController = TextEditingController();

  /// Desteklenen teslimat konumları
  final List<String> _locations = [
    'İstanbul Havalimanı (IST) - Kat P3',
    'Sabiha Gökçen Havalimanı (SAW) - Gelen Yolcu',
    'Kadıköy Rıhtım Ofisi',
    'Levent Kanyon AVM Otopark',
    'Ankara Esenboğa Havalimanı (ESB)',
    'İzmir Adnan Menderes Havalimanı (ADB)',
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  /// Raporu kaydetme işlemi
  void _submitReport() {
    final isEn = LocaleController.instance.isEnglish;
    final activeVehicle =
        VehicleController.instance.activeRentalVehicleNotifier.value;
    final vehicleTitle =
        activeVehicle != null ? activeVehicle.fullName : 'Tesla Model Y Long Range';

    final report = _reportController.saveReport(
      vehicleName: vehicleTitle,
      notes: _notesController.text.trim().isEmpty
          ? (isEn ? 'No noticeable damages.' : 'Gözle görülür hasar tespit edilmedi.')
          : _notesController.text.trim(),
    );

    // Başarılı onay modalı
=======
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.verified_rounded,
                size: 48,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isEn ? 'Inspection Complete' : 'AraÇek Tutanağı Onaylandı',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              '${report.reportType} - ${report.vehicleName}\n\n'
              '📍 ${report.location}\n'
              '📸 ${_reportController.capturedCount} / 4 Fotoğraf Kaydedildi\n'
              '🕒 ${report.createdAt.hour}:${report.createdAt.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 13, height: 1.4),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _reportController.resetPhotos();
                _notesController.clear();
                setState(() {});
              },
              child: Text(isEn ? 'Done' : 'Tamam'),
            ),
          ],
        ),
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
    final isEn = LocaleController.instance.isEnglish;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeVehicle =
        VehicleController.instance.activeRentalVehicleNotifier.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.damageReportTitle(isEn)),
        actions: [
          // Hızlı demo amaçlı tümünü çek butonu
          IconButton(
            tooltip: 'Tüm Açıları Otomatik Çek (Demo)',
            onPressed: () {
              _reportController.captureAll();
              setState(() {});
            },
            icon: const Icon(Icons.auto_fix_high_rounded),
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 550),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // -----------------------------------------------------------
                  // Açıklama ve Bilgilendirme Banner'ı
                  // -----------------------------------------------------------
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.15),
                          AppColors.secondary.withValues(alpha: 0.08),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.camera_alt_outlined,
                          size: 32,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activeVehicle != null
                                    ? activeVehicle.fullName
                                    : 'AraÇek Fotoğraf Sistemi',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                AppStrings.damageReportSubtitle(isEn),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // -----------------------------------------------------------
                  // İşlem Tipi Seçici: Teslim Alma vs Teslim Etme
                  // -----------------------------------------------------------
                  ValueListenableBuilder<String>(
                    valueListenable: _reportController.reportTypeNotifier,
                    builder: (context, reportType, _) {
                      return SegmentedButton<String>(
                        segments: [
                          ButtonSegment<String>(
                            value: 'Teslim Alma',
                            icon: const Icon(Icons.key_rounded, size: 16),
                            label: Text(isEn ? 'Pick Up' : 'Teslim Alma'),
                          ),
                          ButtonSegment<String>(
                            value: 'Teslim Etme',
                            icon: const Icon(Icons.assignment_return_rounded, size: 16),
                            label: Text(isEn ? 'Drop Off' : 'Teslim Etme'),
                          ),
                        ],
                        selected: {reportType},
                        onSelectionChanged: (newSelection) {
                          _reportController.reportTypeNotifier.value =
                              newSelection.first;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // -----------------------------------------------------------
                  // 4 Köşe Fotoğraf Çekim Alanı (2x2 Grid)
                  // -----------------------------------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isEn ? 'Vehicle 4 Angles' : 'Aracın 4 Cephesi',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      // İlerleme Durumu Rozeti
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _reportController.isAllCaptured
                              ? AppColors.success.withValues(alpha: 0.15)
                              : AppColors.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${_reportController.capturedCount} / 4 ${isEn ? 'Ready' : 'Hazır'}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: _reportController.isAllCaptured
                                ? AppColors.success
                                : AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // 4 Köşe Grid
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.25,
                    children: [
                      // Ön Cephe
                      ValueListenableBuilder<bool>(
                        valueListenable: _reportController.frontPhotoNotifier,
                        builder: (context, captured, _) {
                          return DamagePhotoSlot(
                            title: AppStrings.frontSide(isEn),
                            isCaptured: captured,
                            icon: Icons.directions_car_rounded,
                            onTap: () {
                              _reportController.capturePhoto('front');
                              setState(() {});
                            },
                          );
                        },
                      ),
                      // Arka Cephe
                      ValueListenableBuilder<bool>(
                        valueListenable: _reportController.rearPhotoNotifier,
                        builder: (context, captured, _) {
                          return DamagePhotoSlot(
                            title: AppStrings.backSide(isEn),
                            isCaptured: captured,
                            icon: Icons.car_crash_rounded,
                            onTap: () {
                              _reportController.capturePhoto('rear');
                              setState(() {});
                            },
                          );
                        },
                      ),
                      // Sol Cephe
                      ValueListenableBuilder<bool>(
                        valueListenable: _reportController.leftPhotoNotifier,
                        builder: (context, captured, _) {
                          return DamagePhotoSlot(
                            title: AppStrings.leftSide(isEn),
                            isCaptured: captured,
                            icon: Icons.swipe_left_rounded,
                            onTap: () {
                              _reportController.capturePhoto('left');
                              setState(() {});
                            },
                          );
                        },
                      ),
                      // Sağ Cephe
                      ValueListenableBuilder<bool>(
                        valueListenable: _reportController.rightPhotoNotifier,
                        builder: (context, captured, _) {
                          return DamagePhotoSlot(
                            title: AppStrings.rightSide(isEn),
                            isCaptured: captured,
                            icon: Icons.swipe_right_rounded,
                            onTap: () {
                              _reportController.capturePhoto('right');
                              setState(() {});
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // -----------------------------------------------------------
                  // Teslimat Lokasyonu Dropdown
                  // -----------------------------------------------------------
                  Text(
                    AppStrings.deliveryLocation(isEn),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ValueListenableBuilder<String>(
                    valueListenable: _reportController.locationNotifier,
                    builder: (context, currentLoc, _) {
                      return DropdownButtonFormField<String>(
                        initialValue: currentLoc,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.location_on_outlined),
                        ),
                        items: _locations.map((loc) {
                          return DropdownMenuItem(
                            value: loc,
                            child: Text(
                              loc,
                              style: const TextStyle(fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            _reportController.locationNotifier.value = val;
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 18),

                  // -----------------------------------------------------------
                  // Hasar & Çizik Notları Metin Alanı
                  // -----------------------------------------------------------
                  Text(
                    AppStrings.damageNotes(isEn),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: AppStrings.damageNotesHint(isEn),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // -----------------------------------------------------------
                  // Raporu Kaydet Butonu
                  // -----------------------------------------------------------
                  ElevatedButton.icon(
                    onPressed: _submitReport,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    icon: const Icon(Icons.save_alt_rounded, size: 20),
                    label: Text(
                      AppStrings.submitReport(isEn),
                      style: const TextStyle(fontSize: 16),
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
                    ),
                  ),
                ],
              ),
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
            ),
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
          ),
        ),
      ),
    );
  }
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
=======
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
}
