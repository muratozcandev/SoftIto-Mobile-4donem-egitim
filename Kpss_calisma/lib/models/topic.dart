import 'package:flutter/material.dart'; // Renk ve arayüz nesnelerine (Color) erişim için Flutter Material kütüphanesini içeri aktarır

/// Bir derse ait alt konuyu temsil eden veri modeli sınıfı
class Topic {
  final String id; // Konunun benzersiz kimlik kodu (Örn: 'tr_1', 'mat_sozcuk')
  final String title; // Konunun adı / başlığı (Örn: 'Sözcükte Anlam', 'Temel Kavramlar')

  /// Topic kurucu metodu (Constructor) - Tüm alanların verilmesini zorunlu tutar
  Topic({
    required this.id, // Konu kimliği zorunludur
    required this.title, // Konu başlığı zorunludur
  });

  /// JSON veya Map formatındaki veriyi Topic nesnesine dönüştüren fabrika (factory) metodu
  factory Topic.fromMap(Map<String, dynamic> map) {
    return Topic(
      id: map['id'] as String? ?? '', // Map içindeki 'id' değerini alır, yoksa boş metin atar
      title: map['title'] as String? ?? '', // Map içindeki 'title' değerini alır, yoksa boş metin atar
    );
  }

  /// Topic nesnesini JSON'a veya veritabanına yazılabilmesi için Map (anahtar-değer) yapısına çevirir
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Konu kimliğini haritaya ekler
      'title': title, // Konu başlığını haritaya ekler
    };
  }
}

/// KPSS kapsamındaki ana dersleri (Türkçe, Matematik, Tarih vb.) ve alt konularını temsil eden model sınıfı
class Course {
  final String id; // Dersin benzersiz kimlik kodu (Örn: 'turkce', 'matematik')
  final String title; // Dersin ekranda görünen tam adı (Örn: 'Türkçe', 'Genel Matematik')
  final String category; // Dersin kategorisi (Örn: 'Genel Yetenek' veya 'Genel Kültür')
  final int colorHex; // Dersin renk kodu (Onaltılık sayı formatında, Örn: 0xFF2196F3)
  final String iconName; // Ders için gösterilecek ikonun adı (Örn: 'menu_book', 'calculate')
  final int questionCount; // Gerçek KPSS sınavında bu dersten çıkan soru sayısı (Örn: 30 veya 27)
  final List<Topic> topics; // Bu derse ait alt konuların listesi

  /// Course kurucu metodu (Constructor)
  Course({
    required this.id, // Ders kimliği zorunludur
    required this.title, // Ders başlığı zorunludur
    required this.category, // Ders kategorisi zorunludur
    required this.colorHex, // Renk onaltılık kodu zorunludur
    required this.iconName, // İkon adı zorunludur
    required this.questionCount, // Soru sayısı zorunludur
    required this.topics, // Alt konular listesi zorunludur
  });

  /// Sayısal colorHex değerini Flutter'ın kullanabileceği Color nesnesine dönüştüren yardımcı getter
  Color get color => Color(colorHex);

  /// JSON / Map verisini Course nesnesine dönüştüren fabrika metodu
  factory Course.fromMap(Map<String, dynamic> map) {
    // JSON içerisindeki alt konu listesini güvenli bir şekilde ham liste olarak çeker
    final topicsRaw = map['topics'] as List<dynamic>? ?? [];
    
    return Course(
      id: map['id'] as String? ?? '', // Ders kimliği
      title: map['title'] as String? ?? '', // Ders adı
      category: map['category'] as String? ?? 'Genel Yetenek', // Kategori (Varsayılan: Genel Yetenek)
      // Renk verisi string olarak geldiyse tam sayıya dönüştürür, hata olursa varsayılan mavi rengi kullanır
      colorHex: int.tryParse(map['color']?.toString() ?? '0xFF2196F3') ?? 0xFF2196F3,
      iconName: map['icon'] as String? ?? 'book', // İkon adı
      questionCount: map['questionCount'] as int? ?? 30, // Sınavdaki soru sayısı
      // Ham liste elemanlarını tek tek Topic.fromMap ile Topic nesnelerine dönüştürür
      topics: topicsRaw.map((t) => Topic.fromMap(Map<String, dynamic>.from(t as Map))).toList(),
    );
  }

  /// Course nesnesini harita (Map) yapısına çevirerek JSON olarak kaydedilmesini sağlar
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Ders ID
      'title': title, // Ders adı
      'category': category, // Kategori
      // Renk kodunu '0xFF...' formatında onaltılık stringe dönüştürür
      'color': '0x${colorHex.toRadixString(16).padLeft(8, '0').toUpperCase()}',
      'icon': iconName, // İkon adı
      'questionCount': questionCount, // Soru sayısı
      // Alt konular listesini tek tek toMap çağrısıyla harita listesine dönüştürür
      'topics': topics.map((t) => t.toMap()).toList(),
    };
  }
}
