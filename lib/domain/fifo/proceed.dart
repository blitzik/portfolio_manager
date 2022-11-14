import 'package:decimal/decimal.dart';

class Proceed {
  final Decimal amount;
  final Decimal costs;
  final Decimal saleValue;
  final Decimal pnl;

  Proceed({
    required this.amount,
    required this.costs,
    required this.saleValue
  }) : pnl = saleValue - costs;
}