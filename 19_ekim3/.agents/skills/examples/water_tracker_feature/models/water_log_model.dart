import 'package:flutter/foundation.dart';

/// Su tüketim günlüğü veri modeli
/// 
/// Tüm alanlar `final` tanımlanmış olup sınıf `@immutable` prensibine uygundur.
@immutable
class WaterLog {
  final String id;
  final int amountMl;
  final DateTime timestamp;

  const WaterLog({
    required this.id,
    required this.amountMl,
    required this.timestamp,
  });

  /// Değişmez nesnenin belirli alanlarını güncelleyerek yeni kopyasını üretir
  WaterLog copyWith({
    String? id,
    int? amountMl,
    DateTime? timestamp,
  }) {
    return WaterLog(
      id: id ?? this.id,
      amountMl: amountMl ?? this.amountMl,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  /// JSON haritasından tip güvenli model üretir
  factory WaterLog.fromJson(Map<String, dynamic> json) {
    return WaterLog(
      id: json['id'] as String? ?? '',
      amountMl: (json['amountMl'] as num?)?.toInt() ?? 0,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
    );
  }

  /// Modeli JSON haritasına dönüştürür
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amountMl': amountMl,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaterLog &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          amountMl == other.amountMl &&
          timestamp == other.timestamp;

  @override
  int get hashCode => id.hashCode ^ amountMl.hashCode ^ timestamp.hashCode;
}
