/// KPSS sınavı hesaplamaları ve tarih normalizasyonu işlemlerini gerçekleştiren yardımcı sınıf
class KpssCalculator {
  /// ÖSYM / KPSS standardı olan "4 Yanlış 1 Doğruyu Götürür" kuralına göre net hesaplar
  /// Formül: Net = Doğru Sayısı - (Yanlış Sayısı / 4)
  static double calculateNet(int correct, int wrong) {
    return correct - (wrong / 4.0); // Doğrulardan yanlışların dörtte birini çıkarıp net sayısını döndürür
  }

  /// Çözülen toplam soru içindeki doğru başarı yüzdesini hesaplar (Sıfıra bölünme hatasını engeller)
  /// Formül: Başarı Oranı = (Doğru Sayısı / Toplam Soru) * 100
  static double calculateAccuracy(int correct, int total) {
    if (total <= 0) return 0.0; // Hiç soru çözülmemişse yüzdeyi sıfır olarak döndürür
    final accuracy = (correct / total) * 100.0; // Yüzdelik başarı oranını hesaplar
    
    // Yüzdenin mantıksal olarak 0 ile 100 arasında kalmasını güvence altına alır
    return accuracy > 100.0 ? 100.0 : (accuracy < 0.0 ? 0.0 : accuracy);
  }

  /// Verilen tarihin saat, dakika, saniye ve milisaniye kısımlarını sıfırlayarak sadece gün bazında tarih üretir
  /// Günlük filtrelemelerde ve veri gruplamalarında saat farklarından kaynaklı hataları önler
  static DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day); // Sadece yıl, ay ve gün değerlerini alıp döndürür
  }

  /// İki farklı DateTime nesnesinin aynı takvim gününe ait olup olmadığını kontrol eder
  static bool isSameDay(DateTime a, DateTime b) {
    // İki tarihin yıl, ay ve günleri birebir aynıysa true döndürür
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
