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
  final int _projectId;
  final Database _db;

  ProjectDetailBloc(this._db, Project project) : _projectId = project.id!, super(ProjectDetailLoadInProgress(project)) {
    on<ProjectDetailTransactionsLoaded>(_onTransactionsLoaded);
    on<ProjectDetailTransactionDeleted>(_onTransactionDeleted);
  }

  void _onTransactionsLoaded(ProjectDetailTransactionsLoaded event, Emitter<ProjectDetailState> emit) async{
    emit(ProjectDetailLoadInProgress(state.project));

    ResultObject<Project> projectLoading = await _db.projectsDao.getProjectById(_projectId);
    if (projectLoading.isSuccess) {
      ResultObject<List<Transaction>> transactionsLoading = await _db.transactionsDao.findTransactions(_projectId);
      if (transactionsLoading.isSuccess) {
        if (event.transactionDeleted != null && event.transactionDeleted == true) {
         emit(ProjectDetailTransactionDeletedSuccessfully(
           projectLoading.value!, transactionsLoading.value ?? [],
         ));

        } else {
          emit(ProjectDetailTransactionsLoadedSuccessfully(
            projectLoading.value!, transactionsLoading.value ?? [],
            error: event.error
          ));
        }
      }
    }
  }

  void _onTransactionDeleted(ProjectDetailTransactionDeleted event, Emitter<ProjectDetailState> emit) async{
    emit(ProjectDetailLoadInProgress(state.project));

    //await Future.delayed(Duration(seconds: 3));
    ResultObject<int> deletion = await _db.transactionsDao.deleteTransaction(event.transaction);
    if (deletion.isSuccess) {
      add(ProjectDetailTransactionsLoaded(state.project, transactionDeleted: true));
    } else {
      add(ProjectDetailTransactionsLoaded(state.project, transactionDeleted: false, error: deletion.lastErrorMessage));
    }
  }
}