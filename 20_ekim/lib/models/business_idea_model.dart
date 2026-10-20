import 'package:flutter/material.dart';

class BusinessIdeaModel {
  final String id;
  final String title;
  final String category;
  final String shortDescription;
  final String fullDescription;
  final String businessModel;
  final String targetAudience;
  final int investmentAmount; // Kuruş cinsinden (örn: 50.000 TL = 5000000)
  final IconData icon;
  final String founderName;
  final double fundingPercentage;
  final bool isUserCreated;
  final bool isInvested;

  const BusinessIdeaModel({
    required this.id,
    required this.title,
    required this.category,
    required this.shortDescription,
    required this.fullDescription,
    required this.businessModel,
    required this.targetAudience,
    required this.investmentAmount,
    required this.icon,
    required this.founderName,
    this.fundingPercentage = 0.0,
    this.isUserCreated = false,
    this.isInvested = false,
  });

  String get formattedAmount {
    final double tl = investmentAmount / 100.0;
    final int rounded = tl.round();
    // 75.000 ₺ biçiminde formatlama
    return '${_formatNumberWithDots(rounded)} ₺';
  }

  static String _formatNumberWithDots(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  BusinessIdeaModel copyWith({
    String? id,
    String? title,
    String? category,
    String? shortDescription,
    String? fullDescription,
    String? businessModel,
    String? targetAudience,
    int? investmentAmount,
    IconData? icon,
    String? founderName,
    double? fundingPercentage,
    bool? isUserCreated,
    bool? isInvested,
  }) {
    return BusinessIdeaModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      shortDescription: shortDescription ?? this.shortDescription,
      fullDescription: fullDescription ?? this.fullDescription,
      businessModel: businessModel ?? this.businessModel,
      targetAudience: targetAudience ?? this.targetAudience,
      investmentAmount: investmentAmount ?? this.investmentAmount,
      icon: icon ?? this.icon,
      founderName: founderName ?? this.founderName,
      fundingPercentage: fundingPercentage ?? this.fundingPercentage,
      isUserCreated: isUserCreated ?? this.isUserCreated,
      isInvested: isInvested ?? this.isInvested,
    );
  }
}
