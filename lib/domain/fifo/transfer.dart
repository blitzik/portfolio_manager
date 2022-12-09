import 'package:portfolio_manager/domain/fifo/transaction.dart';
import 'package:decimal/decimal.dart';

class Transfer implements Transaction{
  @override
  final int id;

  @override
  final DateTime date;

  @override
  final Decimal amount;

  @override
  final Decimal netAmount;

  @override
  final Decimal fee;

  @override
  final Decimal fiatFee;


  Transfer({
    required this.id,
    required this.date,
    required this.amount,
    required this.fee,
    required this.fiatFee
  }) : netAmount = amount - fee;
}