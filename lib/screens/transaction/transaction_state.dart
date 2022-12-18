part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState {}

class TransactionInitial extends TransactionState {
  final Project project;

  TransactionInitial(this.project);
}

class TransactionSavedSuccessfully extends TransactionInitial {
  final Transaction transaction;

  TransactionSavedSuccessfully(super.project, this.transaction);
}