part of 'project_detail_bloc.dart';

@immutable
abstract class ProjectDetailEvent {}

class ProjectDetailTransactionsLoaded extends ProjectDetailEvent {
  final Project project;
  final String? error;

  ProjectDetailTransactionsLoaded(this.project, {this.error});
}

class ProjectDetailTransactionDeleted extends ProjectDetailEvent {
  final Transaction transaction;

  ProjectDetailTransactionDeleted(this.transaction);
}