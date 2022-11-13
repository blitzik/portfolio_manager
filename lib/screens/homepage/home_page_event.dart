part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class HomePageLoaded extends HomePageEvent {}

class HomePageProjectCreated extends HomePageEvent {
  final Project project;

  HomePageProjectCreated(this.project);
}