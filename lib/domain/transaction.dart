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
  final Decimal fee;
  final Decimal fiatFee;
  final String? note;

  Decimal get pricePerUnit => value == Decimal.zero ? Decimal.zero : (value / amount).toDecimal(scaleOnInfinitePrecision: 12);
  Decimal get realizedPnl => proceeds - costs;
  Decimal? get roi => realizedPnl == Decimal.zero || costs == Decimal.zero ?
                      null :
                      (realizedPnl / costs).toDecimal(scaleOnInfinitePrecision: 12) * Decimal.fromInt(100);

  Transaction({
    this.id,
    required this.date,
    required this.project,
    required this.type,
    required this.amount,
    required this.amountToSell,
    required this.value,
    required this.proceeds,
    required this.costs,
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
    this.note
  }) : type = TransactionType.buy,
       amountToSell = amount,
       costs = value,
       proceeds = Decimal.zero,
       fiatFee = (value / amount).toDecimal(scaleOnInfinitePrecision: 12) * fee;


  Transaction.sale({
    this.id,
    required this.date,
    required this.project,
    required this.amount,
    required this.value,
    required this.fiatFee,
    this.note
  }) : type = TransactionType.sell,
       amountToSell = amount,
       costs = Decimal.zero,
       proceeds = value,
       fee = Decimal.zero;


  Transaction.transfer({
    this.id,
    required this.date,
    required this.project,
    required this.amount,
    required this.value,
    required this.fee,
    this.note
  }) : type = TransactionType.transfer,
       amountToSell = Decimal.zero,
       costs = Decimal.zero,
       proceeds = Decimal.zero,
       fiatFee = (value / amount).toDecimal(scaleOnInfinitePrecision: 12) * fee;


  Transaction.deposit({
    this.id,
    required this.date,
    required this.project,
    required this.amount,
    required this.value,
    required this.fee,
    this.note
  }) : type = TransactionType.deposit,
       amountToSell = Decimal.zero,
       costs = Decimal.zero,
       proceeds = Decimal.zero,
       fiatFee = (value / amount).toDecimal(scaleOnInfinitePrecision: 12) * fee;


  Transaction.withdrawal({
    this.id,
    required this.date,
    required this.project,
    required this.amount,
    required this.value,
    required this.fee,
    this.note
  }) : type = TransactionType.withdrawal,
       amountToSell = Decimal.zero,
       costs = Decimal.zero,
       proceeds = Decimal.zero,
       fiatFee = (value / amount).toDecimal(scaleOnInfinitePrecision: 12) * fee;

}