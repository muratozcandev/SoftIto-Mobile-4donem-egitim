import 'package:flutter/foundation.dart';
import '../models/damage_report_model.dart';
import '../../../core/constants/app_assets.dart';

/// [DamageReportController] sınıfı, AraÇek uygulamasının en kritik özelliklerinden biri olan
/// araç teslim alma / bırakma esnasında 4 cepheden fotoğraf çekme simülasyonunu,
/// hasar açıklamalarını ve teslimat konumlarını yönetir.
class DamageReportController {
  // Singleton deseni
  DamageReportController._internal();
  static final DamageReportController instance =
      DamageReportController._internal();

  /// Ön cephe fotoğrafı durumu (null ise henüz çekilmedi)
  final ValueNotifier<String?> frontPhotoNotifier =
      ValueNotifier<String?>(null);

  /// Arka cephe fotoğrafı durumu
  final ValueNotifier<String?> rearPhotoNotifier = ValueNotifier<String?>(null);

  /// Sol yan cephe fotoğrafı durumu
  final ValueNotifier<String?> leftPhotoNotifier = ValueNotifier<String?>(null);

  /// Sağ yan cephe fotoğrafı durumu
  final ValueNotifier<String?> rightPhotoNotifier =
      ValueNotifier<String?>(null);

  /// Seçili teslim / çekim lokasyonu
  final ValueNotifier<String> selectedLocationNotifier =
      ValueNotifier<String>('İstanbul Havalimanı (IST) - Otopark Katı');

  /// Hasar notu ve açıklaması
  final ValueNotifier<String> damageNoteNotifier = ValueNotifier<String>('');

  /// Kaydedilmiş teslimat ve hasar raporları listesi
  final ValueNotifier<List<DamageReport>> reportsNotifier =
      ValueNotifier<List<DamageReport>>([]);

  /// Belirli bir cephenin fotoğraf çekimini simüle eden metod
  /// [angle]: 'front', 'rear', 'left', 'right'
  void simulateCapture(String angle) {
    // Demo simülasyonu için yerel araç görsellerinden birini atar
    const simulatedImage = AppAssets.carSedan;

    switch (angle) {
      case 'front':
        frontPhotoNotifier.value = simulatedImage;
        break;
      case 'rear':
        rearPhotoNotifier.value = simulatedImage;
        break;
      case 'left':
        leftPhotoNotifier.value = simulatedImage;
        break;
      case 'right':
        rightPhotoNotifier.value = simulatedImage;
        break;
    }
  }

  /// Tüm 4 açının tek tıkla otomatik çekilmesini sağlayan hızlı demo metodu
  void captureAllAngles() {
    frontPhotoNotifier.value = AppAssets.carSedan;
    rearPhotoNotifier.value = AppAssets.carSedan;
    leftPhotoNotifier.value = AppAssets.carSedan;
    rightPhotoNotifier.value = AppAssets.carSedan;
  }

  /// Hasar notunu güncelleyen metod
  void setDamageNote(String note) {
    damageNoteNotifier.value = note;
  }

  /// Teslim lokasyonunu güncelleyen metod
  void setLocation(String location) {
    selectedLocationNotifier.value = location;
  }

  /// Tamamlanan AraÇek raporunu sisteme kaydeden metod
  DamageReport saveReport({required String vehicleName}) {
    final now = DateTime.now();
    final newReport = DamageReport(
      id: 'REP-${now.millisecondsSinceEpoch.toString().substring(7)}',
      vehicleName: vehicleName,
      frontPhoto: frontPhotoNotifier.value,
      rearPhoto: rearPhotoNotifier.value,
      leftPhoto: leftPhotoNotifier.value,
      rightPhoto: rightPhotoNotifier.value,
      damageNotes: damageNoteNotifier.value.isEmpty
          ? 'Hasar veya çizik tespit edilmedi. Araç temiz teslim alındı.'
          : damageNoteNotifier.value,
      location: selectedLocationNotifier.value,
      createdAt: now,
      reportType: 'Teslim & İnceleme',
    );

    // Listeye ekle
    final updatedList = List<DamageReport>.from(reportsNotifier.value)
      ..insert(0, newReport);
    reportsNotifier.value = updatedList;

    return newReport;
  }

  /// Form alanlarını yeni bir inceleme için sıfırlayan metod
  void resetForm() {
    frontPhotoNotifier.value = null;
    rearPhotoNotifier.value = null;
    leftPhotoNotifier.value = null;
    rightPhotoNotifier.value = null;
    damageNoteNotifier.value = '';
  }
}
