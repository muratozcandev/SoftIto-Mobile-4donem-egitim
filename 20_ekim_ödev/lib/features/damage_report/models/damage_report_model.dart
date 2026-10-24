<<<<<<< Updated upstream
=======
<<<<<<< HEAD
// ==============================================================================
// Dosya: damage_report_model.dart
// Görev: AraÇek uygulamasının hasar tespit ve teslimat tutanağı veri modelini tanımlar.
// Açıklama: Aracın 4 köşesinden çekilen fotoğrafların durumunu, teslimat lokasyonunu,
// hasar açıklamalarını ve zaman damgasını barındırır.
// ==============================================================================

import 'package:flutter/foundation.dart';

/// [DamageReportModel] sınıfı, teslimat esnasında kaydedilen rapor kaydını temsil eder.
@immutable
class DamageReportModel {
  /// Rapor kimlik kodu
  final String id;

  /// Raporlanan araç bilgisi
  final String vehicleName;

  /// İşlem türü ('Teslim Alma' veya 'Teslim Etme')
  final String reportType;

  /// Ön cephe fotoğrafı çekildi mi
  final bool frontCaptured;

  /// Arka cephe fotoğrafı çekildi mi
  final bool rearCaptured;

  /// Sol yan cephe fotoğrafı çekildi mi
  final bool leftCaptured;

  /// Sağ yan cephe fotoğrafı çekildi mi
  final bool rightCaptured;

  /// Kullanıcının eklediği hasar, çizik veya temizlik notları
  final String notes;

  /// Teslim alınan / bırakılan otopark veya ofis noktası
  final String location;

  /// Raporun oluşturulduğu tarih ve saat bilgisi
  final DateTime createdAt;

  const DamageReportModel({
    required this.id,
    required this.vehicleName,
    required this.reportType,
    required this.frontCaptured,
    required this.rearCaptured,
    required this.leftCaptured,
    required this.rightCaptured,
    required this.notes,
    required this.location,
    required this.createdAt,
  });

  /// 4 tarafın tamamının fotoğraflanıp fotoğraflanmadığını kontrol eder
  bool get isComplete =>
      frontCaptured && rearCaptured && leftCaptured && rightCaptured;
=======
>>>>>>> Stashed changes
/// [DamageReport] sınıfı, AraÇek özelliğinde teslim alma ve iade anında
/// aracın 4 cephesinden çekilen fotoğrafları, varsa hasar açıklamalarını ve
/// teslimat konumunu belgeleyen veri modelidir.
class DamageReport {
  /// Benzersiz rapor takip numarası
  final String id;

  /// İlgili aracın adı veya plakası
  final String vehicleName;

  /// Ön cephe fotoğrafının kaydedilme durumu / yolu
  final String? frontPhoto;

  /// Arka cephe fotoğrafının kaydedilme durumu / yolu
  final String? rearPhoto;

  /// Sol yan cephe fotoğrafının kaydedilme durumu / yolu
  final String? leftPhoto;

  /// Sağ yan cephe fotoğrafının kaydedilme durumu / yolu
  final String? rightPhoto;

  /// Varsa tespit edilen çizik, ezik veya hasar notu
  final String damageNotes;

  /// Teslim veya çekim yapılan konum adı
  final String location;

  /// Raporun oluşturulma zaman damgası
  final DateTime createdAt;

  /// Raporun teslim alma anında mı (Pick-up) yoksa iade anında mı (Return) oluşturulduğu
  final String reportType;

  /// Kurucu metod: Hasar ve fotoğraf raporu parametrelerini başlatır
  DamageReport({
    required this.id,
    required this.vehicleName,
    this.frontPhoto,
    this.rearPhoto,
    this.leftPhoto,
    this.rightPhoto,
    required this.damageNotes,
    required this.location,
    required this.createdAt,
    this.reportType = 'Teslim Alma',
  });

  /// 4 cephenin kaç tanesinin çekildiğini sayan yardımcı getter
  int get photosCount {
    int count = 0;
    if (frontPhoto != null) count++;
    if (rearPhoto != null) count++;
    if (leftPhoto != null) count++;
    if (rightPhoto != null) count++;
    return count;
  }

  /// Tüm cephelerin eksiksiz çekilip çekilmediğini bildiren kontrol
  bool get isComplete => photosCount >= 4;
<<<<<<< Updated upstream
=======
>>>>>>> d4ded119675a6099138e37283240a788d3a435d7
>>>>>>> Stashed changes
}
