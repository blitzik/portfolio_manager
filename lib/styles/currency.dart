import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

abstract class Currency {
  static String formatPrice(Decimal number) {
    if (number > Decimal.parse("-1.0") && number < Decimal.parse("1.0")) {
      return number.toStringAsPrecision(2);
    }
    return NumberFormat.currency(customPattern: '#,##0.00', locale: 'en_US').format(number.toDouble());
  }
}