import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/drift/database.dart';
import 'package:portfolio_manager/utils/result_object.dart';

part 'project_event.dart';
part 'project_state.dart';

@injectable
class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final Database _db;

  ProjectBloc(this._db) : super(ProjectInitial()) {
    on<ProjectSaveClicked>(_onProjectSaveClicked);
    on<ProjectBackToInitialClicked>(_onBackToInitialClicked);
  }

  void _onBackToInitialClicked(ProjectBackToInitialClicked event, Emitter<ProjectState> emit) async{
      emit(ProjectInitial());
  }

  void _onProjectSaveClicked(ProjectSaveClicked event, Emitter<ProjectState> emit) async{
    emit(ProjectSaveInProgress());

    Project project = event.project ?? Project(name: event.name, coin: event.coin, amount: Decimal.zero);

    await Future.delayed(Duration(seconds: 5));
    ResultObject<Project> savingProject = await _db.projectsDao.save(project);
    if (savingProject.isFailure) {
      emit(ProjectSaveFailure(savingProject.lastErrorMessage));
      return;
    }

    emit(ProjectSaveSuccess(savingProject.value!));
  }
}