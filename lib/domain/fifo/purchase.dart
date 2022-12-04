import 'package:portfolio_manager/domain/fifo/proceed.dart';
import 'package:portfolio_manager/domain/fifo/sale.dart';
import 'package:portfolio_manager/domain/fifo/trade.dart';
import 'package:decimal/decimal.dart';

class Purchase implements Trade {
  @override
  final DateTime date;

  @override
  final Decimal amount;

  @override
  Decimal get netAmount => amount - fee;

  @override
  final Decimal costBasis;

  @override
  final Decimal pricePerUnit;

  @override
  final Decimal fee;

  @override
  final Decimal fiatFee;

  Decimal _totalGrossPNL = Decimal.zero;
  @override
  Decimal get totalGrossPNL => _totalGrossPNL;

  @override
  Decimal get totalNetPNL => _totalGrossPNL - fiatFee;

  Decimal _amountToSell;
  @override
  Decimal get amountToSell => _amountToSell;

  Purchase({
    required this.date,
    required this.amount,
    required this.costBasis,
    required this.fee,
  }) : _amountToSell = amount,
       pricePerUnit = (costBasis / amount).toDecimal(),
       fiatFee = (costBasis / amount).toDecimal() * fee;


  Purchase.fiatFee({
    required this.date,
    required this.amount,
    required this.costBasis,
    required this.fiatFee,
  }) : _amountToSell = amount,
       pricePerUnit = (costBasis / amount).toDecimal(),
       fee = Decimal.zero;


  Proceed processSale(Sale sale) {
    Decimal amountSold = _amountToSell <= sale.amountToSell ? _amountToSell : sale.amountToSell;
    Proceed proceed = Proceed(
      amount: amountSold,
      costs: pricePerUnit * amountSold,
      saleValue: sale.pricePerUnit * amountSold
    );

    _amountToSell -= amountSold;
    _totalGrossPNL += proceed.pnl;

    return proceed;
  }
}