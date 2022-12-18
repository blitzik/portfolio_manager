import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:money2/money2.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/drift/database.dart';
import 'package:portfolio_manager/utils/result_object.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

@injectable
class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final Database _db;

  HomePageBloc(this._db) : super(HomePageLoadInProgress()) {
    on<HomePageLoaded>(_onHomePageLoaded);
    on<HomePageProjectCreated>(_onHomePageProjectCreated);
  }


  void _onHomePageProjectCreated(HomePageProjectCreated event, Emitter<HomePageState> emit) async{
    if (state is! HomePageLoadSuccess) return;

    List<Project> projects = (state as HomePageLoadSuccess).projects.toList();

    emit(HomePageLoadSuccess(projects..add(event.project)..toList(growable: false)));
  }


  void _onHomePageLoaded(HomePageLoaded event, Emitter<HomePageState> emit) async{
    emit(HomePageLoadInProgress());

    ResultObject<List<Project>> loadingProjects = await _db.projectsDao.findAllProjects();

    if (loadingProjects.isFailure) {
      emit(HomePageLoadFailure(loadingProjects.lastErrorMessage));
      return;
    }

    emit(HomePageLoadSuccess(loadingProjects.value!.toList(growable: false)));
  }

  String _pattern(int scale) {
    String s = '#,##0.';
    String dec = ''.padRight(scale, '0');
    return s + dec;
  }
}
