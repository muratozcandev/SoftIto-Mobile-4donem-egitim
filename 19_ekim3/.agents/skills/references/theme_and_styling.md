# Tema ve Tasarım Standartları (Material 3 & Dark Obsidian)

Bu doküman, projede kullanılan görsel tasarım dilini, renk paletlerini, tema geçiş mimarisini ve arayüz geliştirme standartlarını açıklar.

---

## 1. Tasarım Felsefesi ve Paletler

Uygulama, gece spor salonu ve modern fitness estetiğini yansıtan **Dark Obsidian & Neon** koyu teması ile ferah ve temiz **Fresh Arctic** aydınlık temasını destekler.

### A. Renk Tanımları (`AppColors`)

```dart
abstract final class AppColors {
  // --- Koyu Tema (Dark Obsidian) ---
  static const Color background = Color(0xFF0B0E14);
  static const Color surface = Color(0xFF151922);
  static const Color surfaceElevated = Color(0xFF1E2430);
  static const Color surfaceBorder = Color(0xFF2B3344);

  // Neon Vurgu Renkleri
  static const Color neonCyan = Color(0xFF00F0FF);   // Su ve Hidrasyon
  static const Color neonGreen = Color(0xFF10E775);  // Egzersiz, Hedef ve Başarı
  static const Color neonOrange = Color(0xFFFF6B00); // Kalori ve Enerji
  static const Color neonPurple = Color(0xFF9D00FF); // Özel Aktiviteler
  static const Color neonBlue = Color(0xFF0070F3);

  // Koyu Tema Metin Renkleri
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // --- Aydınlık Tema (Fresh Arctic) ---
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF1F5F9);
  static const Color lightSurfaceBorder = Color(0xFFE2E8F0);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextMuted = Color(0xFF94A3B8);

  // Fonksiyonel
  static const Color error = Color(0xFFFF3B30);
  static const Color success = Color(0xFF10E775);
}
```

---

## 2. Reaktif Tema Yönetimi (`ThemeController`)

Tema modu, harici paket kullanmadan saf `ValueNotifier<ThemeMode>` ile yönetilir:

```dart
import 'package:flutter/material.dart';

class ThemeController {
  final ValueNotifier<ThemeMode> themeMode = ValueNotifier<ThemeMode>(ThemeMode.dark);

  bool get isDarkMode => themeMode.value == ThemeMode.dark;

  void toggleTheme() {
    themeMode.value = isDarkMode ? ThemeMode.light : ThemeMode.dark;
  }

  void setThemeMode(ThemeMode mode) {
    themeMode.value = mode;
  }

  void dispose() {
    themeMode.dispose();
  }
}
```

`main.dart` içinde dinleme:

```dart
ValueListenableBuilder<ThemeMode>(
  valueListenable: themeController.themeMode,
  builder: (context, currentMode, _) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Susadım v1',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: currentMode,
      home: WaterTrackerView(
        controller: waterTrackerController,
        themeController: themeController,
      ),
    );
  },
);
```

---

## 3. `ContextExtension` Yardımcı Metotları

Tema değerlerine ve ekran ölçülerine doğrudan `context` üzerinden pratik erişim sağlanmalıdır:

```dart
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Size get screenSize => MediaQuery.sizeOf(this);
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}
```

**Kullanım Örneği:**
```dart
// YERİNE:
// Color primary = Theme.of(context).colorScheme.primary;

// DOĞRU VE PRATİK:
Color primary = context.colorScheme.primary;
```

---

## 4. Kart ve Tipografi Kuralları

1. **Köşe Yuvarlama (Border Radius):** Kart ve butonlarda modern bir görünüm için `BorderRadius.circular(16)` veya `circular(20)` tercih edilir.
2. **Kart Kenarlıkları (Subtle Borders):** Koyu temada derinlik hissi için `1px` kalınlığında `AppColors.surfaceBorder` kullanılır.
3. **Piksel Değerleri Sabit Kodlanmaz:** Renk ve metin boyutları doğrudan temadan türetilir.
