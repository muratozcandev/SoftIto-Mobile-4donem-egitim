import 'dart:convert'; // JSON verilerini çözümlemek (decode) için dönüştürücü kütüphane
import 'package:flutter/material.dart'; // UI bildirimleri ve ChangeNotifier sınıfı için kütüphane
import 'package:flutter/services.dart'; // Yerel dosyalardan (rootBundle) JSON okumak için kütüphane
import '../core/constants/app_constants.dart'; // Sabit dosya yolları ve durum kodları için
import '../core/services/hive_service.dart'; // Konu durumlarını yerel veritabanında saklamak için Hive
import '../models/topic.dart'; // Course ve Topic modelleri

/// KPSS müfredatını (dersler ve alt konuları) yöneten ve tamamlanma durumlarını takip eden Provider
class CurriculumProvider with ChangeNotifier {
  List<Course> _courses = []; // Müfredattaki derslerin listesi
  final Map<String, int> _topicStatuses = {}; // Konu ID'si -> Durum Kodu (0: Başlanmadı, 1: Tekrar Edilmeli, 2: Tamamlandı)
  bool _isLoading = true; // Müfredat yüklenirken gösterilecek yükleniyor bayrağı

  /// Kurucu metot: Sınıf ilk çağrıldığında müfredatı otomatik yükler
  CurriculumProvider() {
    loadCurriculum(); // JSON dosyasından ve veritabanından müfredat bilgilerini yükler
  }

  // --- Dışarıya Açık Getter Değerleri ---
  List<Course> get courses => _courses; // Dersler listesini dışarıya sunar
  bool get isLoading => _isLoading; // Yüklenme durumunu dışarıya sunar
  Map<String, int> get topicStatuses => _topicStatuses; // Konu durum haritasını sunar

  /// assets/kpss_topics.json dosyasından dersleri ve Hive'dan tamamlanma durumlarını yükleyen metot
  Future<void> loadCurriculum() async {
    _isLoading = true; // Yüklenme başladı
    notifyListeners(); // Ekranı yükleniyor durumuna geçir

    try {
      // 1. JSON dosyasını yerel varlıklardan (assets) metin olarak oku
      final jsonString = await rootBundle.loadString(AppConstants.assetTopicsJson);
      // 2. Okunan metni JSON Map yapısına dönüştür
      final Map<String, dynamic> data = json.decode(jsonString);
      // 3. Ham dersler listesini al
      final coursesRaw = data['courses'] as List<dynamic>? ?? [];
      // 4. Her bir dersi Course modeline dönüştürerek listeye ata
      _courses = coursesRaw.map((c) => Course.fromMap(Map<String, dynamic>.from(c as Map))).toList();

      // 5. Hive veritabanından daha önce kaydedilmiş konu tamamlama durumlarını çek
      final box = HiveService.topicStatusBox;
      for (final key in box.keys) {
        final val = box.get(key);
        if (val is int) {
          _topicStatuses[key.toString()] = val; // Konu ID'sini ve durumunu haritaya aktar
        }
      }
    } catch (e) {
      // Hata durumunda konsola bilgilendirme yazdır
      debugPrint('Müfredat yüklenirken hata oluştu: $e');
    } finally {
      _isLoading = false; // Yüklenme bitti
      notifyListeners(); // Ekranı yeni verilerle güncelle
    }
  }

  /// Verilen konu kimliğinin (topicId) çalışma durumunu döndürür (Varsayılan: 0 - Başlanmadı)
  int getTopicStatus(String topicId) {
    return _topicStatuses[topicId] ?? AppConstants.statusNotStarted;
  }

  /// Bir konunun çalışma durumunu (0, 1 veya 2) günceller ve Hive'a kalıcı olarak kaydeder
  Future<void> setTopicStatus(String topicId, int status) async {
    _topicStatuses[topicId] = status; // Yerel haritayı güncelle
    await HiveService.topicStatusBox.put(topicId, status); // Veritabanına yaz
    notifyListeners(); // İlerleme çubukları ve simgelerin anında güncellenmesi için uyar
  }

  /// Belirli bir derse ait tamamlanmış (status == 2) konu sayısını hesaplar
  int getCourseCompletedTopics(String courseId) {
    // İlgili dersi bul
    final course = _courses.firstWhere(
      (c) => c.id == courseId,
      orElse: () => Course(
        id: '',
        title: '',
        category: '',
        colorHex: 0,
        iconName: '',
        questionCount: 0,
        topics: [],
      ),
    );
    if (course.topics.isEmpty) return 0; // Konu yoksa 0 döndür
    // Tamamlandı (statusCompleted = 2) olarak işaretlenmiş konuların adedini say
    return course.topics.where((t) => getTopicStatus(t.id) == AppConstants.statusCompleted).length;
  }

  /// Belirli bir dersin tamamlanma yüzdesini (0.0 ile 1.0 arasında) hesaplar
  double getCourseProgress(String courseId) {
    final course = _courses.firstWhere(
      (c) => c.id == courseId,
      orElse: () => Course(
        id: '',
        title: '',
        category: '',
        colorHex: 0,
        iconName: '',
        questionCount: 0,
        topics: [],
      ),
    );
    if (course.topics.isEmpty) return 0.0;
    final completed = getCourseCompletedTopics(courseId); // Tamamlanan konu sayısı
    return completed / course.topics.length; // Tamamlanan / Toplam oranını döndürür
  }

  /// Tüm KPSS müfredatının genel tamamlanma oranını (0.0 - 1.0) hesaplar
  double get overallProgress {
    int totalTopics = 0; // Tüm derslerdeki toplam konu sayısı
    int completedTopics = 0; // Tüm derslerde bitirilen konu sayısı

    for (final course in _courses) {
      totalTopics += course.topics.length; // Toplam konulara ekle
      completedTopics += getCourseCompletedTopics(course.id); // Tamamlanan konulara ekle
    }

    if (totalTopics == 0) return 0.0;
    return completedTopics / totalTopics; // Genel ilerleme oranını döndür
  }

  /// Tüm dersler genelinde bitirilmiş toplam konu sayısını döndürür
  int get totalCompletedTopics {
    int count = 0;
    for (final course in _courses) {
      count += getCourseCompletedTopics(course.id);
    }
    return count;
  }

  /// Tüm müfredatta var olan toplam konu sayısını döndürür
  int get totalTopicsCount {
    int count = 0;
    for (final course in _courses) {
      count += course.topics.length;
    }
    return count;
  }
}
