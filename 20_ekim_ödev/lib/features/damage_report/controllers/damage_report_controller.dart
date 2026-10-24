<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: damage_report_controller.dart
// Görev: AraÇek hasar ve teslimat fotoğraf çekimi sürecinin durumunu yönetir.
// Açıklama: Aracın ön, arka, sol ve sağ açılardan fotoğraflanmasını simüle eder,
// teslim noktası ve hasar notlarını kayıt altına alır.
// ==============================================================================

import 'package:flutter/material.dart';
import '../models/damage_report_model.dart';
import '../../vehicles/controllers/vehicle_controller.dart';

/// [DamageReportController] sınıfı, teslimat ve hasar kaydı adımlarını reaktif olarak koordine eder.
class DamageReportController {
  static final DamageReportController instance =
      DamageReportController._internal();

  DamageReportController._internal();

  // ---------------------------------------------------------------------------
  // Reaktif Durumlar: 4 Köşe Fotoğraf Çekim Durumu
  // ---------------------------------------------------------------------------
  /// Ön cephe çekim bayrağı
  final ValueNotifier<bool> frontPhotoNotifier = ValueNotifier<bool>(false);

  /// Arka cephe çekim bayrağı
  final ValueNotifier<bool> rearPhotoNotifier = ValueNotifier<bool>(false);

  /// Sol yan cephe çekim bayrağı
  final ValueNotifier<bool> leftPhotoNotifier = ValueNotifier<bool>(false);

  /// Sağ yan cephe çekim bayrağı
  final ValueNotifier<bool> rightPhotoNotifier = ValueNotifier<bool>(false);

  /// İşlem tipi ('Teslim Alma' veya 'Teslim Etme')
  final ValueNotifier<String> reportTypeNotifier =
      ValueNotifier<String>('Teslim Alma');

  /// Seçili teslim lokasyonu
  final ValueNotifier<String> locationNotifier =
      ValueNotifier<String>('İstanbul Havalimanı (IST) - Kat P3');

  /// Kaydedilmiş geçmiş raporlar listesi
  final ValueNotifier<List<DamageReportModel>> savedReportsNotifier =
      ValueNotifier<List<DamageReportModel>>([]);

  // ---------------------------------------------------------------------------
  // Yardımcı Hesaplamalar
  // ---------------------------------------------------------------------------
  /// Toplam çekilen fotoğraf sayısı (0 - 4 arası)
  int get capturedCount {
    int count = 0;
    if (frontPhotoNotifier.value) count++;
    if (rearPhotoNotifier.value) count++;
    if (leftPhotoNotifier.value) count++;
    if (rightPhotoNotifier.value) count++;
    return count;
  }

  /// Tüm 4 açının fotoğraflanıp fotoğraflanmadığını denetler
  bool get isAllCaptured => capturedCount == 4;

  // ---------------------------------------------------------------------------
  // Eylemler (Actions)
  // ---------------------------------------------------------------------------
  /// Belirli bir cephenin fotoğraf durumunu tersine çevirir veya çeker
  void capturePhoto(String side) {
    switch (side) {
      case 'front':
        frontPhotoNotifier.value = !frontPhotoNotifier.value;
        break;
      case 'rear':
        rearPhotoNotifier.value = !rearPhotoNotifier.value;
        break;
      case 'left':
        leftPhotoNotifier.value = !leftPhotoNotifier.value;
        break;
      case 'right':
        rightPhotoNotifier.value = !rightPhotoNotifier.value;
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
        break;
    }
  }

<<<<<<< Updated upstream
=======
<<<<<<< HEAD
  /// Tüm fotoğrafları tek dokunuşla çekilmiş olarak işaretler (Hızlı demo için)
  void captureAll() {
    frontPhotoNotifier.value = true;
    rearPhotoNotifier.value = true;
    leftPhotoNotifier.value = true;
    rightPhotoNotifier.value = true;
  }

  /// Fotoğraf durumlarını sıfırlar
  void resetPhotos() {
    frontPhotoNotifier.value = false;
    rearPhotoNotifier.value = false;
    leftPhotoNotifier.value = false;
    rightPhotoNotifier.value = false;
  }

  /// Raporu kaydeder ve gerekirse aktif kiralanan aracı teslim edildi olarak günceller
  DamageReportModel saveReport({
    required String vehicleName,
    required String notes,
  }) {
    final report = DamageReportModel(
      id: 'REP_${DateTime.now().millisecondsSinceEpoch}',
      vehicleName: vehicleName,
      reportType: reportTypeNotifier.value,
      frontCaptured: frontPhotoNotifier.value,
      rearCaptured: rearPhotoNotifier.value,
      leftCaptured: leftPhotoNotifier.value,
      rightCaptured: rightPhotoNotifier.value,
      notes: notes,
      location: locationNotifier.value,
      createdAt: DateTime.now(),
    );

    // Listeye ekle
    final currentList = List<DamageReportModel>.from(savedReportsNotifier.value);
    currentList.insert(0, report);
    savedReportsNotifier.value = currentList;

    // Eğer işlem 'Teslim Etme' ise aktif aracı iade et
    if (reportTypeNotifier.value.contains('Etme') ||
        reportTypeNotifier.value.contains('Drop Off')) {
      VehicleController.instance.returnActiveVehicle();
    }

    return report;
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
  }
}
