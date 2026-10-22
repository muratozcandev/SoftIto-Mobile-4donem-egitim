class UserProfile {
  final String fullName;
  final String emailOrPhone;
  final String level;
  final int streakDays;
  final String joinDate;

  const UserProfile({
    required this.fullName,
    required this.emailOrPhone,
    required this.level,
    required this.streakDays,
    required this.joinDate,
  });

  UserProfile copyWith({
    String? fullName,
    String? emailOrPhone,
    String? level,
    int? streakDays,
    String? joinDate,
  }) {
    return UserProfile(
      fullName: fullName ?? this.fullName,
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
      level: level ?? this.level,
      streakDays: streakDays ?? this.streakDays,
      joinDate: joinDate ?? this.joinDate,
    );
  }

  static UserProfile defaultUser() {
    return const UserProfile(
      fullName: 'Ahmet Yılmaz',
      emailOrPhone: 'ahmet.yilmaz@ornek.com',
      level: 'Alışkanlık Ustası (Seviye 4)',
      streakDays: 5,
      joinDate: 'Ekim 2026',
    );
  }
}
