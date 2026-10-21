import 'dart:math';

/// Benzersiz kimlik (ID) ve kupon numarası oluşturucu
abstract class IdGenerator {
  static final Random _random = Random();

  /// Benzersiz kupon numarası oluşturur (Örn: TD-847291)
  static String generateCouponId() {
    final number = 100000 + _random.nextInt(900000);
    return 'TD-$number';
  }

  /// Benzersiz rastgele ID
  static String generateId({String prefix = 'id'}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomSuffix = _random.nextInt(9999);
    return '${prefix}_${timestamp}_$randomSuffix';
  }
}
