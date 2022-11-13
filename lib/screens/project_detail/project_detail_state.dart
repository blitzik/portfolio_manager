part of 'project_detail_bloc.dart';

@immutable
abstract class ProjectDetailState {}

class ProjectDetailInitial extends ProjectDetailState {
  final Project project;

  ProjectDetailInitial(this.project);
}
