class UserModel {
  final String id;
  final String name;
  final String email;
  final String title;
  final String avatarInitials;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.title = 'Girişimci & Melek Yatırımcı',
    required this.avatarInitials,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? title,
    String? avatarInitials,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      title: title ?? this.title,
      avatarInitials: avatarInitials ?? this.avatarInitials,
    );
  }
}
