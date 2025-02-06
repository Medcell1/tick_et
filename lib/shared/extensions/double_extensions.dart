import 'package:intl/intl.dart';

extension CustomDoubleExtension on double? {
  String asCurrencyFormat(
    String? currencyCode, {
    int decimalDigits = 2,
  }) {
    return this == null
        ? 'N/A'
        : NumberFormat.simpleCurrency(
            name: currencyCode,
            decimalDigits: decimalDigits,
          ).format(this);
  }

  String compactSimpleCurrency(String? currencyCode) {
    return this == null
        ? 'N/A'
        : NumberFormat.compactSimpleCurrency(
            name: currencyCode,
          ).format(this);
  }
}
