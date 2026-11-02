// Mülakat için önemli: Sınıflar dışarıdan extends edilmez. Switch içinde tüm alt sınıflar tüketilmek zorundadır.

sealed class OdemeDurumu {}

class OdemeBasarili extends OdemeDurumu {
  final ({String referansKodu, double tutar}) veri;
  OdemeBasarili(this.veri);
}

class OdemeBasarisiz extends OdemeDurumu {
  final String hataNedeni;
  OdemeBasarisiz(this.hataNedeni);
}

abstract class IBankaServisi {
  Future<OdemeDurumu> odeme({required double miktar});
}

mixin GuvenlikDenetimiMixin {
  bool tokenGecerliMi(String token) {
    return token.isNotEmpty && token.length >= 32;
  }
}

mixin AuiditLogMixin {
  void islemKaydet(String mesaj) {
    final zaman = DateTime.now().toIso8601String();
    print('Log - $zaman: $mesaj');
  }
}

class GarantiBankasiServisi
    with GuvenlikDenetimiMixin, AuiditLogMixin
    implements IBankaServisi {
  final String apiAnahtari;

  GarantiBankasiServisi({required this.apiAnahtari});

  @override
  Future<OdemeDurumu> odeme({required double miktar}) async {
    if (!tokenGecerliMi(apiAnahtari)) {
      islemKaydet('Ödeme Reddedildi.Geçersiz Api Anahtarı');
      return OdemeBasarisiz('Yetkilendirme hatası : Geçersiz Token');
    }

    await Future.delayed(const Duration(milliseconds: 1000));

    islemKaydet(
      '$miktar tutarındaki ödeme Garanti Bankası tarafından ONAYLANDI',
    );
    return OdemeBasarili((
      referansKodu: 'GRNT-${DateTime.now().millisecondsSinceEpoch}',
      tutar: miktar,
    ));
  }
}

void odemeSonucunuEkranaBas(OdemeDurumu durum) {
  final mesaj = switch (durum) {
    OdemeBasarili b =>
      'Ödeme Başarılı. Ref: ${b.veri.referansKodu}, Tutar: ${b.veri.tutar} TL',
    OdemeBasarisiz h => 'Ödeme Başarısız. Gerekçe: ${h.hataNedeni}',
  };
  print(mesaj);
}

Future<void> main() async {
  final banka = GarantiBankasiServisi(
    apiAnahtari: '12345678901234567890123456789012',
  );
  final sonuc = await banka.odeme(miktar: 1500);
  odemeSonucunuEkranaBas(sonuc);
}
