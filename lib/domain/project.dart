import 'package:decimal/decimal.dart';

class Project {
  final int? id;
  final String name;
  final String coin;
  final int scale;
  final Decimal amount;
  final Decimal currentCosts;
  final Decimal realizedPnl;
  final Decimal feesPaid;
  final Decimal fiatFeesPaid;
  Decimal get averageCostPerCoin =>
      amount == Decimal.zero ?
      Decimal.zero :
      (currentCosts / amount).toDecimal(scaleOnInfinitePrecision: 20);

  Project({
    required this.name,
    required this.coin,
    required this.scale,
    required this.amount,
    required this.currentCosts,
    required this.realizedPnl,
    required this.feesPaid,
    required this.fiatFeesPaid,
    this.id,
  });

  Project copyWith({
    String? name,
    String? coin,
    int? scale,
    Decimal? amount,
    Decimal? currentCosts,
    Decimal? realizedPnl,
    Decimal? feesPaid,
    Decimal? fiatFeesPaid
  }) {
    return Project(
      id: id,
      name: name ?? this.name,
      coin: coin ?? this.coin,
      scale: scale ?? this.scale,
      amount: amount ?? this.amount,
      currentCosts: currentCosts ?? this.currentCosts,
      realizedPnl: realizedPnl ?? this.realizedPnl,
      feesPaid: feesPaid ?? this.feesPaid,
      fiatFeesPaid: fiatFeesPaid ?? this.fiatFeesPaid
    );
  }
}