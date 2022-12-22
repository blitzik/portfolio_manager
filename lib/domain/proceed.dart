import 'package:decimal/decimal.dart';

class Proceed {
  final Decimal amountSold;
  final Decimal costs;
  final Decimal value;

  Decimal get pnl => value - costs;

  Proceed({
    required this.amountSold,
    required this.costs,
    required this.value
  });
}