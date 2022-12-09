import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/domain/transaction.dart';
import 'package:portfolio_manager/drift/database.dart';

part 'project_detail_event.dart';
part 'project_detail_state.dart';

@lazySingleton
class ProjectDetailBlocFactory {
  final Database _db;

  ProjectDetailBlocFactory(this._db);

  ProjectDetailBloc create(Project project) {
    return ProjectDetailBloc(_db, project);
  }
}

class ProjectDetailBloc extends Bloc<ProjectDetailEvent, ProjectDetailState> {
  final Database _db;

  ProjectDetailBloc(this._db, Project project) : super(ProjectDetailLoadInProgress(project)) {
    on<ProjectDetailTransactionsLoaded>(_onTransactionsLoaded);
  }

  void _onTransactionsLoaded(ProjectDetailTransactionsLoaded event, Emitter<ProjectDetailState> emit) async{
    emit(ProjectDetailLoadInProgress(state.project));

    final result = await _db.transactionsDao.findTransactions(state.project.id!);
    for (Transaction t in result.value ?? []) {
      print("#${t.id}");
    }
    if (result.isSuccess) {
      emit(ProjectDetailTransactionsLoadedSuccessfully(state.project, result.value ?? []));
    }
  }
}
