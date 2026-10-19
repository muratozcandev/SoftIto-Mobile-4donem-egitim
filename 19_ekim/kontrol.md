# Kurallar
1. Projenin Kimliği & Vizyonu
Uygulama nedir kime hitap eder hedef platformlar (iOS, Android, Web)

2. Mimari desen & Dizin haritası
Dosyalar nereye kurulur (lib/core, lib/features) vb.

3. İzin verilen ve yasaklı paketler:
Hangi kütüphaneler serbest ve hangileri yasak ya da kesinlikle yasak 

4. Kırmızı çizgiler (kesinlikle uyulması gerekenler)
- Asla setState ile büyük ağaç tetikleme 
- const zorunluluğu 
- BuildContext'i async ile güvensiz kullanmamak vs.

5. Terminal ve çalıştırma komutları 
Test koşma, lint kontrolleri, build alma vb. komutlar

6. Ajan davranışı ve çıktı standartları 
Kodları nasıl sunmalı (tam dosya mı, diff mi, Türkçe mi, farklı dilde açıklama yapmak mı vb.)
