part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState {
  final Project project;

  const TransactionState(this.project);
}

class TransactionInitial extends TransactionState {
  const TransactionInitial(super.project);
}

class TransactionLoadInProgress extends TransactionState {
  const TransactionLoadInProgress(super.project);
}

class TransactionLoadedSuccessfully extends TransactionState {
  final List<Proceed> proceeds;

  const TransactionLoadedSuccessfully(super.project, this.proceeds);
}

class TransactionSavedSuccessfully extends TransactionState {
  final Transaction transaction;

  const TransactionSavedSuccessfully(super.project, this.transaction);
}


class TransactionSaveFailure extends TransactionState {
  final String error;

  const TransactionSaveFailure(super.project, this.error);
}