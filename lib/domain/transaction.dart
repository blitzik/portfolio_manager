import 'package:decimal/decimal.dart';
import 'package:portfolio_manager/domain/project.dart';

enum TransactionType {
  deposit, withdrawal, buy, sell, transfer
}

class Transaction {
  final int? id;
  final DateTime date;
  final Project project;
  final TransactionType type;
  final Decimal amount;
  final Decimal amountToSell;
  final Decimal value;
  final Decimal proceeds;
  final Decimal costs;
  final Decimal realizedPNL;
  final Decimal fee;
  final Decimal fiatFee;
  final String? note;

  Decimal get pricePerUnit => (amount / value).toDecimal();

  const Transaction({
    this.id,
    required this.date,
    required this.project,
    required this.type,
    required this.amount,
    required this.amountToSell,
    required this.value,
    required this.proceeds,
    required this.costs,
    required this.realizedPNL,
    required this.fee,
    required this.fiatFee,
    this.note
  });
}