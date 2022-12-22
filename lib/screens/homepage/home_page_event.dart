part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class HomePageLoaded extends HomePageEvent {}

/*class HomePageProjectUpdated extends HomePageEvent {
  final Project project;

  HomePageProjectUpdated(this.project);
}*/