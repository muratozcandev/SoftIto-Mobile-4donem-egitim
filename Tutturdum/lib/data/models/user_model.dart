/// Demo kullanıcı modeli
class UserModel {
  final String id;
  final String fullName;
  final String tcNo;
  final String phone;
  final String email;
  final String passwordHash;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.tcNo,
    required this.phone,
    required this.email,
    required this.passwordHash,
    required this.createdAt,
  });

  UserModel copyWith({
    String? id,
    String? fullName,
    String? tcNo,
    String? phone,
    String? email,
    String? passwordHash,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      tcNo: tcNo ?? this.tcNo,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'tcNo': tcNo,
      'phone': phone,
      'email': email,
      'passwordHash': passwordHash,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      tcNo: json['tcNo'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      passwordHash: json['passwordHash'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  String get maskedTcNo {
    if (tcNo.length == 11) {
      return '${tcNo.substring(0, 3)}*****${tcNo.substring(8)}';
    }
    return tcNo;
  }

  String get maskedPhone {
    if (phone.length >= 10) {
      return '${phone.substring(0, 4)}*** **${phone.substring(phone.length - 2)}';
    }
    return phone;
  }
}
