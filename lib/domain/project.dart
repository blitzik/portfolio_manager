import 'package:decimal/decimal.dart';

class Project {
  final int? id;
  final String name;
  final String coin;
  final Decimal amount;
  final Decimal realizedPnl;

  Project({
    required this.name,
    required this.coin,
    required this.amount,
    required this.realizedPnl,
    this.id,
  });

  Project copyWith({
    String? name,
    String? coin,
    Decimal? amount,
    Decimal? realizedPnl
  }) {
    return Project(
      name: name ?? this.name,
      coin: coin ?? this.coin,
      amount: amount ?? this.amount,
      realizedPnl: realizedPnl ?? this.realizedPnl,
      id: id
    );
  }
}