import 'package:decimal/decimal.dart';

class Project {
  final int? id;
  final String name;
  final String coin;
  final Decimal amount;

  Project({
    required this.name,
    required this.coin,
    required this.amount,
    this.id,
  });

  Project copyWith({
    String? name,
    String? coin,
    Decimal? amount
  }) {
    return Project(
      name: name ?? this.name,
      coin: coin ?? this.coin,
      amount: amount ?? this.amount,
      id: id
    );
  }
}