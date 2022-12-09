import 'package:decimal/decimal.dart';

enum TransactionType { //
  deposit, withdrawal, buy, sell, transfer
}

abstract class Transaction {
  int get id;
  DateTime get date;
  Decimal get amount;
  Decimal get netAmount;
  Decimal get fee;
  Decimal get fiatFee;
}