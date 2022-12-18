import 'package:decimal/decimal.dart';

class Project {
  final int? id;
  final String name;
  final String coin;
  final int scale;
  final Decimal amount;
  final Decimal currentCosts;
  final Decimal realizedPnl;

  Project({
    required this.name,
    required this.coin,
    required this.scale,
    required this.amount,
    required this.currentCosts,
    required this.realizedPnl,
    this.id,
  });

  Project copyWith({
    String? name,
    String? coin,
    int? scale,
    Decimal? amount,
    Decimal? currentCosts,
    Decimal? realizedPnl
  }) {
    return Project(
      name: name ?? this.name,
      coin: coin ?? this.coin,
      scale: scale ?? this.scale,
      amount: amount ?? this.amount,
      currentCosts: currentCosts ?? this.currentCosts,
      realizedPnl: realizedPnl ?? this.realizedPnl,
      id: id
    );
  }
}