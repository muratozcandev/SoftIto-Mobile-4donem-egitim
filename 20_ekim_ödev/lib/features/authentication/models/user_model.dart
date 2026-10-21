/// [User] sınıfı, AraÇek uygulamasında oturum açmış kullanıcı profilini
/// temsil eden in-memory modeldir.
class User {
  /// Kullanıcının tam adı ve soyadı
  final String fullName;

  /// Kullanıcının e-posta adresi
  final String email;

  /// Kullanıcının cep telefonu numarası
  final String phone;

  /// Ehliyet sahiplik süresi (Yıl)
  final int licenseYears;

  /// Kullanıcının üyelik seviyesi (Örn: Gold Üye, VIP)
  final String memberLevel;

  /// Kullanıcının sanal cüzdan/kredi bakiyesi
  final int virtualBalance;

  /// Kurucu metod: Kullanıcı nesnesini başlatır
  const User({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.licenseYears,
    this.memberLevel = 'Gold Üye',
    this.virtualBalance = 25000,
  });

  /// Varsayılan örnek kullanıcı (Demo oturumlar için)
  static const User demoUser = User(
    fullName: 'Ahmet Yılmaz',
    email: 'ahmet.yilmaz@aracek.com',
    phone: '+90 532 555 44 33',
    licenseYears: 6,
    memberLevel: 'VIP Platinum',
    virtualBalance: 50000,
  );
}
