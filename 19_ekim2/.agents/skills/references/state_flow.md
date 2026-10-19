# Reaktif State Akış Mimarisi (ValueNotifier)

Bu projede state yönetimi doğrudan Flutter'ın yerel `ValueNotifier` ve `ValueListenableBuilder` bileşenleri ile yönetilir.

```mermaid
graph TD
    A[View: ValueListenableBuilder] -->|Dinler| B[Controller: ValueNotifier]
    C[Kullanıcı Aksiyonu: onTap/onPressed] -->|Metot Çağırır| D[Controller: İş Mantığı]
    D -->|Yeni Değeri Atar| B
    B -->|Sadece İlgili Widget'ı Tetikler| A
```

### Avantajları:
1. Sayfanın tamamının (`setState` gibi) gereksiz yere baştan çizilmesini önler.
2. Harici ağır paket bağımlılığını sıfıra indirir.
3. Test edilebilirliği ve kod ayrışımını (Separation of Concerns) artırır.
