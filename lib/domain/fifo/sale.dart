import 'package:portfolio_manager/domain/fifo/purchase.dart';
import 'package:portfolio_manager/domain/fifo/proceed.dart';
import 'package:portfolio_manager/domain/fifo/trade.dart';
import 'package:decimal/decimal.dart';

class Sale implements Trade {
  @override
  final int id;

  @override
  final DateTime date;

  @override
  final Decimal amount;

  @override
  Decimal get netAmount => amount;

  final Decimal profit;

  @override
  Decimal get fee => Decimal.zero;

  @override
  final Decimal fiatFee;

  @override
  final Decimal pricePerUnit;

  Decimal _amountToSell;
  @override
  Decimal get amountToSell => _amountToSell;

  Decimal _grossPNL = Decimal.zero;
  @override
  Decimal get totalGrossPNL => _grossPNL;
  @override
  Decimal get totalNetPNL => _grossPNL - fiatFee;

  Decimal _costBasis = Decimal.zero;
  @override
  Decimal get costBasis => _costBasis;

  Sale({
    required this.id,
    required this.date,
    required this.amount,
    required this.profit,
    required this.fiatFee
  }) : _amountToSell = amount,
       pricePerUnit = (profit / amount).toDecimal(scaleOnInfinitePrecision: 12);


  Proceed processPurchase(Purchase purchase) {
    Proceed proceed = purchase.processSale(this);
    _amountToSell -= proceed.amount;
    _costBasis += proceed.costs;
    _grossPNL += proceed.pnl;

    return proceed;
  }
}