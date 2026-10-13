/*

Future<void> fetchDashboardData() async {
  try {
    final result = await Future.wait([
      fetchUserProfile(),
      fetchAccountBalance(),
      fetchNotification(),
    ], eagerError: true);

    print("Tüm veriler geldi $result");
  } catch (e) {
    print("İsteklerden Biri başarısız oldu $e");
  }
} */

// Future : tek bir veri çekileceği zaman kullanılır. ya hata ya da değer dönüp bitirilir.
// Stream : bir boru hattı şeklinde çalışır (pipe) zaman içinde 1 10 100 ya da sonsuuz sayıda veri akılı sağlanabilir.
// borsa fiyatları, gps konum güncelleme firebase canlı dinleme

import 'dart:async';

void main () {
  final controller = StreamController<int>(); // controller oluşturma
  final subscription = controller.stream.listen((data) => print("yeni veri: $data"),
  onError: (err) => print("Hata oluştu: $err"),
  onDone: () => print("yayın tamamlandı"),
  );
  controller.sink.add(10);
  controller.sink.add(20);
  controller.sink.add(30);

  final broadcastStream = controller.stream.asBroadcastStream(); // birden fazla dinleyici eklenebilir
  broadcastStream.listen((d) => print("UI Ekranı: $d"));
  broadcastStream.listen((d) => print("Analitik servisi ekranı: $d"));

  controller.close();

}

