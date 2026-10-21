import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/coupon_models.dart';
import '../../core/storage/local_storage_service.dart';
import '../../core/constants/app_constants.dart';

/// Kupon Geçmişi Repository
class CouponRepository {
  static final CouponRepository instance = CouponRepository._internal();
  CouponRepository._internal();

  final ValueNotifier<List<CouponModel>> couponsNotifier = ValueNotifier<List<CouponModel>>([]);

  List<CouponModel> get coupons => couponsNotifier.value;

  Future<void> init() async {
    final rawJson = LocalStorageService.instance.getString(AppConstants.keyCoupons);
    if (rawJson != null) {
      try {
        final list = (jsonDecode(rawJson) as List<dynamic>)
            .map((e) => CouponModel.fromJson(e as Map<String, dynamic>))
            .toList();
        couponsNotifier.value = list;
      } catch (_) {
        couponsNotifier.value = [];
      }
    }
  }

  Future<void> saveCoupon(CouponModel coupon) async {
    final updated = List<CouponModel>.from(couponsNotifier.value)..insert(0, coupon);
    couponsNotifier.value = updated;
    final jsonStr = jsonEncode(updated.map((e) => e.toJson()).toList());
    await LocalStorageService.instance.setString(AppConstants.keyCoupons, jsonStr);
  }

  Future<void> clearHistory() async {
    couponsNotifier.value = [];
    await LocalStorageService.instance.remove(AppConstants.keyCoupons);
  }
}
