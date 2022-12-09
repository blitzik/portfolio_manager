part of 'project_detail_bloc.dart';

@immutable
abstract class ProjectDetailEvent {}

class ProjectDetailTransactionsLoaded extends ProjectDetailEvent {
  ProjectDetailTransactionsLoaded();
}