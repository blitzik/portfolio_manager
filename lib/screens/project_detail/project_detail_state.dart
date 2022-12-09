part of 'project_detail_bloc.dart';

@immutable
abstract class ProjectDetailState {
  final Project project;

  const ProjectDetailState(this.project);
}

class ProjectDetailLoadInProgress extends ProjectDetailState {
  const ProjectDetailLoadInProgress(super.project);
}


class ProjectDetailTransactionsLoadedSuccessfully extends ProjectDetailState {
  final List<Transaction> transactions;

  const ProjectDetailTransactionsLoadedSuccessfully(super.project, this.transactions);
}