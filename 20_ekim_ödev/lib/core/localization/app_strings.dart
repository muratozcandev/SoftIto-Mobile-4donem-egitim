import 'locale_controller.dart';

/// [AppStrings] sınıfı, AraÇek uygulamasındaki tüm metinleri, başlıkları ve
/// bildirim mesajlarını Türkçe ve İngilizce olarak depolar.
/// [LocaleController] ile senkronize çalışarak aktif dile göre metin döndürür.
class AppStrings {
  const AppStrings._();

  /// Aktif dile göre anahtara karşılık gelen metni getiren yardımcı fonksiyon
  static String get(String key) {
    final isTr = LocaleController.instance.isTurkish;
    final dict = isTr ? _tr : _en;
    return dict[key] ?? key;
  }

  // ==========================================
  // TÜRKÇE SÖZLÜK (TR)
  // ==========================================
  static const Map<String, String> _tr = {
    // Uygulama & Karşılama
    'app_name': 'AraÇek',
    'app_slogan': 'Kirala & Güvenle Çek',
    'welcome_back': 'Tekrar Hoş Geldiniz',
    'find_ideal_car': 'Hayalindeki Aracı Bul & Kirala',

    // Giriş & Kayıt
    'login': 'Giriş Yap',
    'register': 'Kayıt Ol',
    'logout': 'Çıkış Yap',
    'email_or_phone': 'E-posta veya Telefon Numarası',
    'password': 'Şifre',
    'full_name': 'Ad Soyad',
    'phone_number': 'Telefon Numarası',
    'driving_license_age': 'Ehliyet Süresi (Yıl)',
    'dont_have_account': 'Hesabınız yok mu? Kayıt Olun',
    'already_have_account': 'Zaten hesabınız var mı? Giriş Yapın',
    'required_field': 'Bu alan zorunludur',
    'invalid_email_or_phone': 'Geçerli bir e-posta veya telefon giriniz',
    'password_min_length': 'Şifre en az 6 karakter olmalıdır',

    // Ana Sayfa & Navigasyon
    'nav_home': 'Keşfet',
    'nav_rentals': 'Kiralamalarım',
    'nav_aracek': 'AraÇek (Foto)',
    'nav_profile': 'Profil',
    'search_car_hint': 'Marka veya model ara (örn: Tesla, Clio)...',
    'all_categories': 'Tümü',
    'category_sedan': 'Sedan',
    'category_suv': 'SUV',
    'category_electric': 'Elektrikli',
    'category_sport': 'Spor',
    'all_transmissions': 'Tüm Vitesler',
    'manual': 'Manuel',
    'automatic': 'Otomatik',
    'price_low_high': 'Fiyat: Artan',
    'price_high_low': 'Fiyat: Azalan',
    'filter_and_sort': 'Filtrele & Sırala',
    'daily_rate': 'Günlük',
    'currency': '₺',
    'rent_now': 'Hemen Kirala',
    'active_rental_title': 'Aktif Kiralamanız Var',
    'remaining_days': 'Kalan Gün',
    'deliver_car': 'Aracı Teslim Et',

    // Araç Detayı & Kiralama
    'vehicle_details': 'Araç Detayları',
    'specs': 'Teknik Özellikler',
    'fuel_type': 'Yakıt',
    'transmission': 'Vites',
    'seats': 'Koltuk',
    'horsepower': 'Motor Gücü',
    'acceleration': '0-100 km/s',
    'range': 'Menzil',
    'select_rental_period': 'Kiralama Süresini Seçin',
    'days_count': 'Gün',
    'total_amount': 'Toplam Tutar',
    'insurance_included': 'Tam Kapsamlı Güvence Dahil',
    'proceed_to_payment': 'Ödemeye İlerle',

    // Ödeme Simülasyonu
    'payment_title': 'Ödeme ve Kiralama Onayı',
    'card_holder': 'Kart Üzerindeki İsim',
    'card_number': 'Kart Numarası',
    'expiry_date': 'Son Kullanma Tarihi (AA/YY)',
    'cvv': 'CVV',
    'promo_code': 'Kupon Kodu (Opsiyonel)',
    'apply_code': 'Uygula',
    'confirm_and_rent': 'Onayla ve Kirala',
    'payment_success': 'Kiralama İşlemi Başarılı!',
    'payment_success_desc':
        'Aracınız teslimata hazır. Teslim alırken AraÇek ile fotoğraf çekmeyi unutmayın!',

    // AraÇek Fotoğraf & Hasar Modülü
    'aracek_title': 'AraÇek - Teslim & Hasar Kontrolü',
    'aracek_subtitle':
        'Aracı teslim alırken ve iade ederken 4 cepheden fotoğraf çekerek güvenliğinizi sağlayın.',
    'front_view': 'Ön Cephe',
    'back_view': 'Arka Cephe',
    'left_side': 'Sol Yan',
    'right_side': 'Sağ Yan',
    'damage_point': 'Hasar / Çizik Noktası',
    'take_photo_sim': 'Fotoğraf Çek / Simüle Et',
    'photo_captured': 'Fotoğraf Kaydedildi',
    'add_damage_note': 'Hasar Notu ve Açıklama',
    'damage_note_hint': 'Varsa tampon çiziği, taş izi vb. açıklayınız...',
    'select_location': 'Teslimat / Bırakma Konumu',
    'save_report': 'Hasar Raporunu Kaydet',
    'report_saved_success': 'AraÇek teslimat ve hasar raporu başarıyla kaydedildi!',

    // Profil & Ayarlar
    'profile_title': 'Hesabım & Profil',
    'driver_status': 'Ehliyet Durumu: Onaylı',
    'membership_type': 'Gold Üyelik',
    'my_cards': 'Kayıtlı Kartlarım (Demo)',
    'settings': 'Ayarlar',
    'theme_dark': 'Karanlık Mod',
    'theme_light': 'Aydınlık Mod',
    'language': 'Uygulama Dili',
    'faq_title': 'Sıkça Sorulan Sorular (SSS)',
    'reset_data': 'Demo Verilerini Sıfırla',
    'support': '7/24 Canlı Destek',
  };

  // ==========================================
  // İNGİLİZCE SÖZLÜK (EN)
  // ==========================================
  static const Map<String, String> _en = {
    // App & Welcome
    'app_name': 'AraÇek',
    'app_slogan': 'Rent & Capture Safely',
    'welcome_back': 'Welcome Back',
    'find_ideal_car': 'Find & Rent Your Dream Car',

    // Auth
    'login': 'Log In',
    'register': 'Sign Up',
    'logout': 'Log Out',
    'email_or_phone': 'Email or Phone Number',
    'password': 'Password',
    'full_name': 'Full Name',
    'phone_number': 'Phone Number',
    'driving_license_age': 'Driving License (Years)',
    'dont_have_account': "Don't have an account? Sign Up",
    'already_have_account': 'Already have an account? Log In',
    'required_field': 'This field is required',
    'invalid_email_or_phone': 'Enter a valid email or phone',
    'password_min_length': 'Password must be at least 6 characters',

    // Home & Nav
    'nav_home': 'Discover',
    'nav_rentals': 'My Rentals',
    'nav_aracek': 'AraÇek (Cam)',
    'nav_profile': 'Profile',
    'search_car_hint': 'Search brand or model (e.g. Tesla, Clio)...',
    'all_categories': 'All',
    'category_sedan': 'Sedan',
    'category_suv': 'SUV',
    'category_electric': 'Electric',
    'category_sport': 'Sport',
    'all_transmissions': 'All Transmissions',
    'manual': 'Manual',
    'automatic': 'Automatic',
    'price_low_high': 'Price: Low to High',
    'price_high_low': 'Price: High to Low',
    'filter_and_sort': 'Filter & Sort',
    'daily_rate': 'Daily',
    'currency': '₺',
    'rent_now': 'Rent Now',
    'active_rental_title': 'You Have An Active Rental',
    'remaining_days': 'Days Left',
    'deliver_car': 'Deliver Car',

    // Vehicle Detail & Rental
    'vehicle_details': 'Vehicle Details',
    'specs': 'Specifications',
    'fuel_type': 'Fuel',
    'transmission': 'Transmission',
    'seats': 'Seats',
    'horsepower': 'Power',
    'acceleration': '0-100 km/h',
    'range': 'Range',
    'select_rental_period': 'Select Rental Period',
    'days_count': 'Days',
    'total_amount': 'Total Amount',
    'insurance_included': 'Comprehensive Insurance Included',
    'proceed_to_payment': 'Proceed to Payment',

    // Payment Simulation
    'payment_title': 'Payment & Rental Confirmation',
    'card_holder': 'Cardholder Name',
    'card_number': 'Card Number',
    'expiry_date': 'Expiry Date (MM/YY)',
    'cvv': 'CVV',
    'promo_code': 'Promo Code (Optional)',
    'apply_code': 'Apply',
    'confirm_and_rent': 'Confirm & Rent',
    'payment_success': 'Rental Completed Successfully!',
    'payment_success_desc':
        'Your car is ready. Remember to take photos with AraÇek upon delivery!',

    // AraÇek Camera & Damage Module
    'aracek_title': 'AraÇek - Delivery & Inspection',
    'aracek_subtitle':
        'Take photos from 4 angles upon delivery and return to guarantee your safety.',
    'front_view': 'Front View',
    'back_view': 'Rear View',
    'left_side': 'Left Side',
    'right_side': 'Right Side',
    'damage_point': 'Damage / Scratch Area',
    'take_photo_sim': 'Capture / Simulate Photo',
    'photo_captured': 'Photo Captured',
    'add_damage_note': 'Damage Notes & Description',
    'damage_note_hint': 'Describe bumper scratches, chips, etc...',
    'select_location': 'Delivery / Drop-off Location',
    'save_report': 'Save Inspection Report',
    'report_saved_success': 'Inspection report saved successfully!',

    // Profile & Settings
    'profile_title': 'My Account & Profile',
    'driver_status': 'License Status: Verified',
    'membership_type': 'Gold Member',
    'my_cards': 'Saved Cards (Demo)',
    'settings': 'Settings',
    'theme_dark': 'Dark Mode',
    'theme_light': 'Light Mode',
    'language': 'Language',
    'faq_title': 'Frequently Asked Questions',
    'reset_data': 'Reset Demo Data',
    'support': '24/7 Live Support',
  };
}
