part of 'project_detail_bloc.dart';

@immutable
abstract class ProjectDetailEvent {}

class ProjectDetailTransactionsLoaded extends ProjectDetailEvent {
  final Project project;

  ProjectDetailTransactionsLoaded(this.project);
}

class ProjectDetailTransactionDeleted extends ProjectDetailEvent {
  final Transaction transaction;

  ProjectDetailTransactionDeleted(this.transaction);
}