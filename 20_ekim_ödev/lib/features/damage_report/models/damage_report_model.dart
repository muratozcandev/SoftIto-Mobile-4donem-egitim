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
}
