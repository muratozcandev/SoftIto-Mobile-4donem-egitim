import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigServisi {
  final FirebaseRemoteConfig _firebaseRemoteConfig =
      FirebaseRemoteConfig.instance;

  // Remote Config başlatma
  Future<void> baslat() async {
    // Config ayarları
    await _firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ),
    );

    // Varsayılan değerler
    await _firebaseRemoteConfig.setDefaults(const {
      'kampanya_aktif': true,
      'kampanya_metni': 'mobil mezuniyet indirimi',
      'kampanya_indirim_orani': 30,
      'zorunlu_guncelleme': false,
      'en_dusuk_surum': '1.0.0',
    });

    // Firebase'den güncel değerleri çek
    try {
      await _firebaseRemoteConfig.fetchAndActivate();
    } catch (_) {}
  }

  // Kampanya aktif mi?
  bool get kampanyaAktifMi => _firebaseRemoteConfig.getBool('kampanya_aktif');

  // Kampanya metni
  String get kampanyaMetni => _firebaseRemoteConfig.getString('kampanya_metni');

  // İndirim oranı
  int get indirimOrani =>
      _firebaseRemoteConfig.getInt('kampanya_indirim_orani');

  // Zorunlu güncelleme var mı?
  bool get zorunluGuncellemeMi =>
      _firebaseRemoteConfig.getBool('zorunlu_guncelleme');

  // En düşük uygulama sürümü
  String get enDusukSurum => _firebaseRemoteConfig.getString('en_dusuk_surum');
}
