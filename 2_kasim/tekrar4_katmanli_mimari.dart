import 'dart:convert';

import 'package:http/http.dart' as http;

class UrunModel {
  final int id;
  final String baslik;
  final double fiyat;
  final String resimUrl;
  final String kategori;

  const UrunModel({
    required this.id,
    required this.baslik,
    required this.fiyat,
    required this.resimUrl,
    required this.kategori,
  });

  factory UrunModel.fromJson(Map<String, dynamic> json) {
    return UrunModel(
      id: json['id'] as int? ?? 0,
      baslik: json['title'] as String? ?? 'İsimsiz Ürün',
      fiyat: (json['price'] as num?)?.toDouble() ?? 0.0,
      resimUrl: json['image'] as String? ?? 'https://via.placeholder.com/150',
      kategori: json['category'] as String? ?? 'Genel',
    );
  }
}

abstract class IUrunServisi {
  Future<List<UrunModel>> urunleriGetir();
}

class CanliApiUrunServisi implements IUrunServisi {
  static const String _baseurl = "https://fakestoreapi.com/products";
  @override
  Future<List<UrunModel>> urunleriGetir() async {
    try {
      final yanit = await http
          .get(Uri.parse(_baseurl))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception('Ağ zaman aşımına uğradı');
            },
          );

      if (yanit.statusCode == 200) {
        final List<dynamic> hamListe = jsonDecode(yanit.body) as List<dynamic>;

        return hamListe.map((item) => UrunModel.fromJson(item)).toList();
      } else {
        throw Exception('Sunucu hatası: ${yanit.statusCode}');
      }
    } catch (e) {
      print('Ağ hatası: $e');
      rethrow;
    }
  }
}

void main(List<String> args) async {
  print("Uygulama başladı, veriler çekiliyor...");

  // 1. Servisi başlattık
  CanliApiUrunServisi servis = CanliApiUrunServisi();

  try {
    // 2. İnternetten ürünleri istedik
    List<UrunModel> urunler = await servis.urunleriGetir();

    print("\n--- Başarılı! Toplam ${urunler.length} ürün getirildi ---\n");

    // 3. Gelen ürünlerden ilk 3 tanesini terminale yazdırdık
    for (var i = 0; i < urunler.length && i < 3; i++) {
      print(
        "Ürün ${i + 1}: ${urunler[i].baslik} - Fiyat: ${urunler[i].fiyat} TL",
      );
    }
  } catch (e) {
    print("Ana programda hata yakalandı: $e");
  }
}
