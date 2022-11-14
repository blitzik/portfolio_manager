part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState {}

class TransactionInitial extends TransactionState {
  final Project project;

  TransactionInitial(this.project);
}
