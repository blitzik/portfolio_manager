import 'package:portfolio_manager/domain/fifo/deposit.dart';
import 'package:portfolio_manager/domain/fifo/transfer.dart';
import 'package:decimal/decimal.dart';
import 'package:portfolio_manager/domain/fifo/trade_report.dart';
import 'package:portfolio_manager/domain/fifo/withdrawal.dart';

d(String s) => Decimal.parse(s);
typedef OnField = Decimal Function(TradeReport report);

class FifoReport {
  final String symbol;
  final List<TradeReport> trades;
  final List<Transfer> transfers;
  final List<Deposit> deposits;
  final List<Withdrawal> withdrawals;

  Decimal _currentAmount = d("0.0");
  Decimal get currentAmount => _currentAmount;

  Decimal _currentCostBasis = d("0.0");
  Decimal get currentCostBasis => _currentCostBasis;

  Decimal _totalProceeds = d("0.0");
  Decimal get totalProceeds => _totalProceeds;

  Decimal _totalSaleCostBasis = d("0.0");
  Decimal get totalSaleCostBasis => _totalSaleCostBasis;

  Decimal _totalRealizedPNL = d("0.0");
  Decimal get totalRealizedPNL => _totalRealizedPNL;

  Decimal _purchaseFees = d("0.0");
  Decimal get purchaseFees => _purchaseFees;

  Decimal _purchaseFiatFees = d("0.");
  Decimal get purchaseFiatFees => _purchaseFiatFees;

  Decimal _saleFees = d("0.0");
  Decimal get saleFees => _saleFees;

  Decimal _saleFiatFees = d("0.0");
  Decimal get saleFiatFees => _saleFiatFees;

  Decimal _totalFees = d("0.0");
  Decimal get totalFees => _totalFees;

  Decimal _totalFiatFees = d("0.0");
  Decimal get totalFiatFees => _totalFiatFees;

  Decimal get totalNetPNL => totalRealizedPNL - totalFiatFees;


  FifoReport(
    this.symbol,
    this.trades,
    this.transfers,
    this.deposits,
    this.withdrawals
  ) {
    for (TradeReport r in trades) { // TODO withdrawals
      if (r.type == TradeType.long) {
        _currentAmount += r.amount;
        _purchaseFees += r.fee;
        _purchaseFiatFees += r.fiatFee;
        _currentCostBasis += r.pricePerUnit * r.amountToSell;
        //print("${r.amountToSell} -> ${r.pricePerUnit * r.amountToSell} (${r.costs})");
      } else {
        _currentAmount -= r.amount;
        _saleFees += r.fee;
        _saleFiatFees += r.fiatFee;
      }
      _currentAmount -= r.fee;
      _totalProceeds += r.proceeds;
      _totalSaleCostBasis += _onlyShort(r, (r) => r.costs);
      _totalRealizedPNL += _onlyShort(r, (r) => r.realizedPNL);
      _totalFees += r.fee;
      _totalFiatFees += r.fiatFee;
    }

    for (Transfer r in transfers) {
      _currentAmount -= r.fee;
    }

    for (Deposit d in deposits) {
      _currentAmount += d.netAmount;
    }
  }

  Decimal _onlyShort(TradeReport report, OnField onField) {
    if (report.type == TradeType.short) {
      return onField(report);
    }
    return d("0.0");
  }

  Decimal _onlyLong(TradeReport report, OnField onField) {
    if (report.type == TradeType.long) {
      return onField(report);
    }
    return d("0.0");
  }
}