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

  Transaction._({
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

  Transaction.purchase({
    this.id,
    required this.date,
    required this.project,
    required this.amount,
    required this.value,
    required this.fee,
    required this.fiatFee,
    this.note
  }) : type = TransactionType.buy,
       amountToSell = amount,
       costs = value,
       proceeds = Decimal.zero,
       realizedPNL = Decimal.zero;


  Transaction.sale({
    this.id,
    required this.date,
    required this.project,
    required this.amount,
    required this.value,
    required this.fee,
    required this.fiatFee,
    this.note
  }) : type = TransactionType.sell,
       amountToSell = amount,
       costs = Decimal.zero,
       proceeds = value,
       realizedPNL = Decimal.zero;


  Transaction.transfer({
    this.id,
    required this.date,
    required this.project,
    required this.amount,
    required this.value,
    required this.fee,
    required this.fiatFee,
    this.note
  }) : type = TransactionType.transfer,
       amountToSell = Decimal.zero,
       costs = Decimal.zero,
       proceeds = Decimal.zero,
       realizedPNL = Decimal.zero;


  Transaction.deposit({
    this.id,
    required this.date,
    required this.project,
    required this.amount,
    required this.fee,
    required this.fiatFee,
    this.note
  }) : type = TransactionType.deposit,
       value = Decimal.zero,
       amountToSell = Decimal.zero,
       costs = Decimal.zero,
       proceeds = Decimal.zero,
       realizedPNL = Decimal.zero;


  Transaction.withdrawal({
    this.id,
    required this.date,
    required this.project,
    required this.amount,
    required this.fee,
    required this.fiatFee,
    this.note
  }) : type = TransactionType.withdrawal,
       value = Decimal.zero,
       amountToSell = Decimal.zero,
       costs = Decimal.zero,
       proceeds = Decimal.zero,
       realizedPNL = Decimal.zero;
}