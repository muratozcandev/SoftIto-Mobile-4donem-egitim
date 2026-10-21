import 'package:intl/intl.dart';

/// Para birimi ve sayı formatlayıcı
abstract class CurrencyFormatter {
  static final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'tr_TR',
    symbol: '₺',
    decimalDigits: 2,
  );

  static final NumberFormat _compactCurrency = NumberFormat.currency(
    locale: 'tr_TR',
    symbol: '₺',
    decimalDigits: 0,
  );

  static String format(double amount) {
    return _currencyFormat.format(amount);
  }

  static String formatCompact(double amount) {
    if (amount % 1 == 0) {
      return _compactCurrency.format(amount);
    }
    return _currencyFormat.format(amount);
  }

  static String formatOdds(double odds) {
    return odds.toStringAsFixed(2);
  }
}
