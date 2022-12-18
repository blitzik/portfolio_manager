import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/domain/transaction.dart';
import 'package:portfolio_manager/drift/database.dart';
import 'package:portfolio_manager/utils/result_object.dart';

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
    on<ProjectDetailTransactionDeleted>(_onTransactionDeleted);
  }

  void _onTransactionsLoaded(ProjectDetailTransactionsLoaded event, Emitter<ProjectDetailState> emit) async{
    emit(ProjectDetailLoadInProgress(event.project));

    final result = await _db.transactionsDao.findTransactions(event.project.id!);
    if (result.isSuccess) {
      emit(ProjectDetailTransactionsLoadedSuccessfully(event.project, result.value ?? []));
    }
  }

  void _onTransactionDeleted(ProjectDetailTransactionDeleted event, Emitter<ProjectDetailState> emit) async{
    emit(ProjectDetailLoadInProgress(state.project));

    ResultObject<Project> deletion = await _db.transactionsDao.deleteTransaction(event.transaction);

    if (deletion.isSuccess) {
      add(ProjectDetailTransactionsLoaded(deletion.value!));
    }
  }
}
