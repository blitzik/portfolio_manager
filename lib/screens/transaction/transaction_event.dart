part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent {}

class TransactionSaved extends TransactionEvent {
  final Project project;
  final DateTime date;
  final Decimal amount;
  final Decimal totalValue;
  final Decimal fee;
  final Decimal fiatFee;
  final String note;

  TransactionSaved({
    required this.project,
    required this.date,
    required this.amount,
    required this.totalValue,
    required this.fee,
    required this.fiatFee,
    required this.note
  });
}