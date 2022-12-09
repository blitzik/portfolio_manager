import 'dart:collection';

import 'package:portfolio_manager/domain/fifo/deposit.dart';
import 'package:portfolio_manager/domain/fifo/purchase.dart';
import 'package:portfolio_manager/domain/fifo/fifo_report.dart';
import 'package:portfolio_manager/domain/fifo/sale.dart';
import 'package:portfolio_manager/domain/fifo/trade.dart';
import 'package:portfolio_manager/domain/fifo/trade_report.dart';
import 'package:portfolio_manager/domain/fifo/transfer.dart';
import 'package:decimal/decimal.dart';
import 'package:portfolio_manager/domain/fifo/withdrawal.dart';

typedef OnTradeReportCreated = Function(TradeReport report);

class Fifo {
  final String _symbol;

  final List<Transfer> _transfers = [];
  final List<Deposit> _deposits = [];
  final List<Withdrawal> _withdrawals = [];
  final List<Trade> _trades = [];
  final Queue<Purchase> _purchases = Queue();
  final List<Sale> _sales = [];

  final List<Purchase> _processedPurchases = [];

  Decimal _amount = Decimal.zero;

  Fifo({
    required String symbol
  }) : _symbol = symbol;


  void addPurchase(int id, DateTime date, Decimal amount, Decimal costBasis, Decimal fee) {
    Purchase p = Purchase(id: id, date: date, amount: amount, costBasis: costBasis, fee: fee);
    _amount += p.netAmount;
    //_transactions.add(p);
    _trades.add(p);
    _purchases.addFirst(p);
  }

  void addSale(int id, DateTime date, Decimal amount, Decimal profit, Decimal fiatFee) {
    Sale s = Sale(id: id, date: date, amount: amount, profit: profit, fiatFee: fiatFee);
    //_transactions.add(s);
    _trades.add(s);
    _sales.add(s);
  }

  void addTransfer(int id, DateTime date, Decimal amount, Decimal fee, Decimal fiatFee) {
    Transfer t = Transfer(id: id, date: date, amount: amount, fee: fee, fiatFee: fiatFee);
    //_transactions.add(t);
    _transfers.add(t);
    _amount -= fee;
  }

  void addDeposit(int id, DateTime date, Decimal amount, Decimal fee, Decimal fiatFee) {
    Deposit d = Deposit(id: id, date: date, amount: amount, fee: fee, fiatFee: fiatFee);
    _deposits.add(d);
    _amount += d.netAmount;
  }

  void addWithdrawal(int id, DateTime date, Decimal amount, Decimal fee, Decimal fiatFee) {
    Withdrawal w = Withdrawal(id: id, date: date, amount: amount, fee: fee, fiatFee: fiatFee);
    _withdrawals.add(w);
    _amount -= w.netAmount;
  }

  void _processTransactions() {
    for (Sale sale in _sales) {
      do {
        Purchase purchase = _purchases.last;
        sale.processPurchase(purchase);
        if (purchase.amountToSell == Decimal.zero) {
          _processedPurchases.add(_purchases.removeLast());
        }

      } while (sale.amountToSell > Decimal.zero);
      _amount -= sale.amount;
      if (_amount < Decimal.zero) {
        throw Exception("Amount \"(${_amount})\" cannot be lower than zero!"); // todo
      }
    }
  }

  List<TradeReport> getTradeReports({OnTradeReportCreated? onTradeReportCreated}) {
    List<TradeReport> tradeReports = [];
    for (Trade t in _trades) {
      TradeReport report = TradeReport(
          id: t.id,
          date: t.date,
          symbol: _symbol,
          type: (t is Sale) ? TradeType.short : TradeType.long,
          pricePerUnit: t.pricePerUnit,
          amount: t.amount,
          amountToSell: t.amountToSell,
          proceeds: (t is Sale) ? t.profit : Decimal.zero,
          costs: t.costBasis,
          realizedPNL: t.totalGrossPNL,
          fee: t.fee,
          fiatFee: t.fiatFee
      );
      tradeReports.add(report);
      onTradeReportCreated?.call(report);
    }

    return tradeReports;
  }

  FifoReport generateFiFoReport() {
    _processTransactions();

    List<TradeReport> tradeReports = getTradeReports();
    return FifoReport(_symbol, tradeReports, _transfers, _deposits, _withdrawals);
  }
}