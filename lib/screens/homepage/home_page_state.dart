part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState {}

class HomePageLoadInProgress extends HomePageState {}

class HomePageLoadFailure extends HomePageState {
  final String error;

  HomePageLoadFailure(this.error);
}

class HomePageLoadSuccess extends HomePageState {
  final List<Project> projects;

  HomePageLoadSuccess(this.projects);
}