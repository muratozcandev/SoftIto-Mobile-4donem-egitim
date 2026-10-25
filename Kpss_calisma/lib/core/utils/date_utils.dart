import 'package:intl/intl.dart'; // Tarih ve saat formatlama işlemleri için uluslararasılaştırma (intl) paketini içeri aktarır

/// Uygulama genelinde tarih ve saatlerin formatlanmasını ve karşılaştırılmasını sağlayan yardımcı araç sınıfı
class AppDateUtils {
  // --- Tarih ve Saat Biçimlendiricileri (Formatters) ---
  static final DateFormat _dateFormat = DateFormat('dd.MM.yyyy'); // Standart gün.ay.yıl biçimlendiricisi (Örn: 25.10.2026)
  static final DateFormat _dayMonthFormat = DateFormat('d MMM'); // Gün ve kısa ay biçimlendiricisi (Örn: 25 Eki)
  static final DateFormat _dayNameFormat = DateFormat('EEEE'); // Günün tam adını veren biçimlendirici (Örn: Pazar)
  static final DateFormat _timeFormat = DateFormat('HH:mm'); // 24 saatlik saat:dakika biçimlendiricisi (Örn: 14:30)

  /// Verilen DateTime nesnesini "gün.ay.yıl" (Örn: 25.10.2026) metin formatına çevirir
  static String formatDate(DateTime date) {
    return _dateFormat.format(date); // Formatlanmış metni döndürür
  }

  /// Verilen DateTime nesnesini "gün ve kısa ay" (Örn: 25 Eki) formatına çevirir (Grafik etiketleri için ideal)
  static String formatDayMonth(DateTime date) {
    return _dayMonthFormat.format(date); // Formatlanmış kısa metni döndürür
  }

  /// Verilen DateTime nesnesine ait günün tam adını döndürür (Örn: Pazartesi)
  static String formatDayName(DateTime date) {
    return _dayNameFormat.format(date); // Gün adını döndürür
  }

  /// Verilen DateTime nesnesinin saat ve dakikasını "HH:mm" formatında döndürür (Örn: 09:45)
  static String formatTime(DateTime date) {
    return _timeFormat.format(date); // Formatlanmış saat metnini döndürür
  }

  /// Dakika cinsinden verilen çalışma süresini okunabilir "saat ve dakika" metnine dönüştürür (Örn: 90 dk -> 1 sa 30 dk)
  static String formatDuration(int minutes) {
    // Süre 1 saatten (60 dakikadan) az ise doğrudan dakika olarak yazdır
    if (minutes < 60) {
      return '$minutes dk'; // Örn: "45 dk"
    }
    
    final hours = minutes ~/ 60; // Tam bölme işlemi ile saat kısmını hesaplar (Örn: 130 ~/ 60 = 2)
    final remainingMinutes = minutes % 60; // Mod alma ile kalan dakika kısmını hesaplar (Örn: 130 % 60 = 10)
    
    // Eğer kalan dakika sıfır ise sadece saat kısmını yazdır
    if (remainingMinutes == 0) {
      return '$hours sa'; // Örn: "2 sa"
    }
    
    // Hem saat hem de dakika varsa birleşik olarak yazdır
    return '$hours sa $remainingMinutes dk'; // Örn: "2 sa 10 dk"
  }

  /// Verilen tarihi bugüne göre göreceli bir ifadeye çevirir (Bugün, Dün, Yarın veya tarih formatı)
  static String getRelativeDay(DateTime date) {
    final now = DateTime.now(); // Şimdiki zamanı alır
    final today = DateTime(now.year, now.month, now.day); // Bugünkü tarihi saat-dakikadan arındırarak gün başlangıcına eşitler
    final target = DateTime(date.year, date.month, date.day); // Hedef tarihi gün başlangıcına eşitler
    final difference = today.difference(target).inDays; // İki tarih arasındaki gün farkını hesaplar

    if (difference == 0) return 'Bugün'; // Gün farkı 0 ise "Bugün" yaz
    if (difference == 1) return 'Dün'; // Gün farkı 1 ise "Dün" yaz
    if (difference == -1) return 'Yarın'; // Gün farkı -1 ise "Yarın" yaz
    return formatDate(date); // Fark daha büyükse standart tarih (25.10.2026) döndür
  }
}
