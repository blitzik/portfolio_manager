part of 'project_bloc.dart';

@immutable
abstract class ProjectEvent {}

class ProjectBackToInitialClicked extends ProjectEvent {}

class ProjectSaveClicked extends ProjectEvent {
  final String name;
  final String coin;
  final int scale;
  final Project? project;

  ProjectSaveClicked({
    required this.name,
    required this.coin,
    required this.scale,
    required this.project
  });
}