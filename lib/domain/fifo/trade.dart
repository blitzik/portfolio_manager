import 'package:portfolio_manager/domain/fifo/transaction.dart';
import 'package:decimal/decimal.dart';

abstract class Trade implements Transaction {
  Decimal get amountToSell;
  Decimal get pricePerUnit;
  Decimal get costBasis;
  Decimal get totalGrossPNL;
  Decimal get totalNetPNL;
}