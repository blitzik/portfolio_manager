import 'package:portfolio_manager/domain/fifo/transaction.dart';
import 'package:decimal/decimal.dart';

class Deposit implements Transaction {
  @override
  final DateTime date;

  @override
  final Decimal amount;

  @override
  final Decimal netAmount;

  @override
  final Decimal fee = Decimal.parse("0.0");

  @override
  final Decimal fiatFee = Decimal.parse("0.0");


  Deposit({
    required this.date,
    required this.amount
  }) : netAmount = amount;

}