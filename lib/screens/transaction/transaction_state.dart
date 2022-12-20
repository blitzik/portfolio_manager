part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState {
  final Project project;

  const TransactionState(this.project);
}

class TransactionInitial extends TransactionState {
  const TransactionInitial(super.project);
}

class TransactionSavedSuccessfully extends TransactionState {
  final Transaction transaction;

  const TransactionSavedSuccessfully(super.project, this.transaction);
}


class TransactionSaveFailure extends TransactionState {
  final String error;

  const TransactionSaveFailure(super.project, this.error);
}