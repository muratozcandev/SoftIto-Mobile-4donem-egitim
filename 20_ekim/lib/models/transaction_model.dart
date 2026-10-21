import 'package:flutter/material.dart';

enum TransactionType {
  deposit, // Para Ekleme
  transfer, // Para Transferi
  investment, // Yatırım Yapma
}

class TransactionModel {
  final String id;
  final TransactionType type;
  final String title;
  final String description;
  final int amount; // Kuruş
  final DateTime date;
  final bool isPositive;

  const TransactionModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.isPositive,
  });

  String get formattedAmount {
    final double tl = amount / 100.0;
    final int rounded = tl.round();
    final String prefix = isPositive ? '+' : '-';
    return '$prefix${_formatNumberWithDots(rounded)} ₺';
  }

  String get formattedDate {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  IconData get icon {
    switch (type) {
      case TransactionType.deposit:
        return Icons.arrow_downward_rounded;
      case TransactionType.transfer:
        return Icons.swap_horiz_rounded;
      case TransactionType.investment:
        return Icons.rocket_launch_rounded;
    }
  }

  static String _formatNumberWithDots(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}
