part of 'project_detail_bloc.dart';

@immutable
abstract class ProjectDetailState {
  final Project project;
  final String? error;

  const ProjectDetailState(this.project, {this.error});
}

class ProjectDetailLoadInProgress extends ProjectDetailState {
  const ProjectDetailLoadInProgress(super.project, {super.error});
}

class ProjectDetailTransactionsLoadedSuccessfully extends ProjectDetailState {
  final List<Transaction> transactions;

  const ProjectDetailTransactionsLoadedSuccessfully(super.project, this.transactions, {super.error});
}

class ProjectDetailTransactionDeletedSuccessfully extends ProjectDetailTransactionsLoadedSuccessfully {
  const ProjectDetailTransactionDeletedSuccessfully(super.project, super.transactions, {super.error});
}