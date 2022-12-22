import 'dart:collection';

import 'package:portfolio_manager/domain/fifo/deposit.dart';
import 'package:portfolio_manager/domain/fifo/proceed.dart';
import 'package:portfolio_manager/domain/fifo/purchase.dart';
import 'package:portfolio_manager/domain/fifo/fifo_report.dart';
import 'package:portfolio_manager/domain/fifo/sale.dart';
import 'package:portfolio_manager/domain/fifo/trade.dart';
import 'package:portfolio_manager/domain/fifo/trade_report.dart';
import 'package:portfolio_manager/domain/fifo/transaction.dart';
import 'package:portfolio_manager/domain/fifo/transfer.dart';
import 'package:decimal/decimal.dart';
import 'package:portfolio_manager/domain/fifo/withdrawal.dart';

typedef OnTradeProcessed = Function(TradeReport report);

typedef OnSaleProcessed = Function(TradeReport sale);
typedef OnPurchaseProcessed = Function(TradeReport purchase);
typedef OnProceedCreated = Function(int purchaseID, int saleID, Proceed proceed);

class Fifo {
  final String _symbol;

  final List<Transaction> _transactions = [];

  final List<Transfer> _transfers = [];
  final List<Deposit> _deposits = [];
  final List<Withdrawal> _withdrawals = [];
  final List<Trade> _trades = [];
  final Queue<Purchase> _purchases = Queue();
  final List<Sale> _sales = [];

  Decimal _currentAmount = d('0.0');
  Decimal get currentAmount => _currentAmount;

  Decimal _currentCostBasis = d('0.0');
  Decimal get currentCostBasis => _currentCostBasis - _purchaseFiatFees;

  Decimal _totalProceeds = d('0.0');
  Decimal get totalProceeds => _totalProceeds;

  Decimal _purchaseFees = d('0.0');
  Decimal get purchaseFees => _purchaseFees;

  Decimal _purchaseFiatFees = d('0.');
  Decimal get purchaseFiatFees => _purchaseFiatFees;

  Decimal _saleFees = d('0.0');
  Decimal get saleFees => _saleFees;

  Decimal _saleFiatFees = d('0.0');
  Decimal get saleFiatFees => _saleFiatFees;

  Decimal get totalTradeFees => _purchaseFees + _saleFees;
  Decimal get totalTradeFiatFees => _purchaseFiatFees + _saleFiatFees;

  Decimal get totalNetPNL => _totalProceeds - totalTradeFiatFees;

  Fifo({
    required String symbol
  }) : _symbol = symbol;


  void addPurchase(int id, DateTime date, Decimal amount, Decimal costBasis, Decimal fee) {
    Purchase p = Purchase(id: id, date: date, amount: amount, costBasis: costBasis, fee: fee);
    _trades.add(p);
    _purchases.addFirst(p);
    _transactions.add(p);
  }

  void addSale(int id, DateTime date, Decimal amount, Decimal profit, Decimal fiatFee) {
    Sale s = Sale(id: id, date: date, amount: amount, profit: profit, fiatFee: fiatFee);
    _trades.add(s);
    _sales.add(s);
    _transactions.add(s);
  }

  void addTransfer(int id, DateTime date, Decimal amount, Decimal fee, Decimal fiatFee) {
    Transfer t = Transfer(id: id, date: date, amount: amount, fee: fee, fiatFee: fiatFee);
    _transfers.add(t);
    _transactions.add(t);
  }

  void addDeposit(int id, DateTime date, Decimal amount, Decimal fee, Decimal fiatFee) {
    Deposit d = Deposit(id: id, date: date, amount: amount, fee: fee, fiatFee: fiatFee);
    _deposits.add(d);
    _transactions.add(d);
  }

  void addWithdrawal(int id, DateTime date, Decimal amount, Decimal fee, Decimal fiatFee) {
    Withdrawal w = Withdrawal(id: id, date: date, amount: amount, fee: fee, fiatFee: fiatFee);
    _withdrawals.add(w);
    _transactions.add(w);
  }

  void processTransactions({
    OnTradeProcessed? onTradeProcessed,
    OnSaleProcessed? onSaleProcessed,
    OnPurchaseProcessed? onPurchaseProcessed,
    OnProceedCreated? onProceedCreated
  }) {
    Purchase? lastProcessedPurchase;
    for (Transaction t in _transactions) {
      if (t is Sale) {
        Sale sale = t;
        do {
          if (_purchases.isEmpty) {
            throw NotEnoughHoldingsException(0, 'You cannot sell more then you have!');
          }
          lastProcessedPurchase = _purchases.last;
          Proceed proceed = sale.processPurchase(lastProcessedPurchase);
          onProceedCreated?.call(lastProcessedPurchase.id, sale.id, proceed);
          if (lastProcessedPurchase.amountToSell == Decimal.zero) {
            Purchase p = _purchases.removeLast();
            TradeReport r = _generateTradeReport(p);
            onPurchaseProcessed?.call(r);
            onTradeProcessed?.call(r);
          }
        } while (sale.amountToSell > Decimal.zero);
        _currentAmount -= sale.amount;
        _currentCostBasis -= sale.costBasis;
        _totalProceeds += sale.totalGrossPNL;
        _saleFees += sale.fee;
        _saleFiatFees += sale.fiatFee;

        TradeReport r = _generateTradeReport(sale);
        onSaleProcessed?.call(r);
        onTradeProcessed?.call(r);

        if (_currentAmount < Decimal.zero) {
          throw NotEnoughHoldingsException(0, 'You cannot sell more then you have!');
        }

      } else if (t is Purchase) {
        _currentAmount += t.netAmount;
        _currentCostBasis += t.costBasis;
        _purchaseFees += t.fee;
        _purchaseFiatFees += t.fiatFee;

      } else if (t is Deposit) {


      } else if (t is Withdrawal) {


      } else { // Transfer

      }
    }

    if (lastProcessedPurchase != null && (lastProcessedPurchase.amountToSell != lastProcessedPurchase.amount)) {
      TradeReport r = _generateTradeReport(lastProcessedPurchase);
      onPurchaseProcessed?.call(r);
      onTradeProcessed?.call(r);
    }
  }

  List<TradeReport> getTradeReports({OnTradeProcessed? onTradeProcessed}) {
    processTransactions();
    List<TradeReport> tradeReports = [];
    for (Trade t in _trades) {
      TradeReport report = _generateTradeReport(t);
      tradeReports.add(report);
      onTradeProcessed?.call(report);
    }

    return tradeReports;
  }

  FifoReport generateFiFoReport() {
    processTransactions();

    List<TradeReport> tradeReports = getTradeReports();
    return FifoReport(_symbol, tradeReports, _transfers, _deposits, _withdrawals);
  }

  TradeReport _generateTradeReport(Trade t) {
    return TradeReport(
        id: t.id,
        date: t.date,
        symbol: _symbol,
        type: (t is Sale) ? TradeType.short : TradeType.long,
        pricePerUnit: t.pricePerUnit,
        amount: t.amount,
        amountToSell: t.amountToSell,
        proceeds: (t is Sale) ? t.profit : t.totalGrossPNL,
        costs: t.costBasis,
        realizedPNL: t.totalGrossPNL,
        fee: t.fee,
        fiatFee: t.fiatFee
    );
  }
}


class NotEnoughHoldingsException implements Exception{
  final int code;
  final String message;

  NotEnoughHoldingsException(this.code, this.message);
}