import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
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
  }

  void _onHomePageLoaded(HomePageLoaded event, Emitter<HomePageState> emit) async{
    emit(HomePageLoadInProgress());

    ResultObject<List<Project>> loadingProjects = await _db.projectsDao.findAllProjects();

    if (loadingProjects.isFailure) {
      emit(HomePageLoadFailure(loadingProjects.lastErrorMessage));
      return;
    }

    emit(HomePageLoadSuccess(loadingProjects.value!));
  }
}
