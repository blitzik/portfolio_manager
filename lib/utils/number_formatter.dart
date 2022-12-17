import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

class NumberFormatter {
  static final _formatter = NumberFormat('###.0#', 'en_US');

  static num formatDecimal(Decimal number) {
    return _formatter.parse(number.toStringAsPrecision(12));
  }
}