import 'package:decimal/decimal.dart';

enum TradeType {
  long, short
}

class TradeReport {
  final int id;
  final DateTime date;
  final String symbol;
  final TradeType type;
  final Decimal pricePerUnit;
  final Decimal amount;
  final Decimal amountToSell;
  final Decimal proceeds;
  final Decimal costs;
  final Decimal realizedPNL;
  final Decimal fee;
  final Decimal fiatFee;

  const TradeReport({
    required this.id,
    required this.date,
    required this.symbol,
    required this.type,
    required this.pricePerUnit,
    required this.amount,
    required this.amountToSell,
    required this.proceeds,
    required this.costs,
    required this.realizedPNL,
    required this.fee,
    required this.fiatFee
  });
}