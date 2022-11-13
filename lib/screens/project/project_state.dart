part of 'project_bloc.dart';

@immutable
abstract class ProjectState {}

class ProjectInitial extends ProjectState {}

class ProjectSaveInProgress extends ProjectState {}

class ProjectSaveSuccess extends ProjectState {
  final Project project;

  ProjectSaveSuccess(this.project);
}

class ProjectSaveFailure extends ProjectState {
  final String error;

  ProjectSaveFailure(this.error);
}