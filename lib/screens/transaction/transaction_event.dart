part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent {}

class TransactionLoaded extends TransactionEvent {
  final Transaction? transaction;

  TransactionLoaded(this.transaction);
}

class TransactionSaved extends TransactionEvent {
  final int? id;
  final TransactionType type;
  final DateTime date;
  final Project project;
  final Decimal amount;
  final Decimal totalValue;
  final Decimal fee;
  final Decimal fiatFee;
  final String? note;

  TransactionSaved({
    this.id,
    required this.date,
    required this.type,
    required this.project,
    required this.amount,
    required this.totalValue,
    required this.fee,
    required this.fiatFee,
    required this.note
  });
}