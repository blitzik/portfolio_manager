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
  final Map<String, double> pieData;
  final Decimal currentCosts;
  final Decimal totalRealizedPnl;

  HomePageLoadSuccess({
    required this.projects,
    required this.currentCosts,
    required this.totalRealizedPnl,
    required this.pieData
  });
}