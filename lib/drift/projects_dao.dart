import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/drift/database.dart';
import 'package:portfolio_manager/utils/result_object.dart';

part 'projects_dao.g.dart';

@DriftAccessor(tables: [Projects])
class ProjectsDao extends DatabaseAccessor<Database> with _$ProjectsDaoMixin {
  ProjectsDao(Database attachedDatabase) : super(attachedDatabase);

  Future<ResultObject<Project>> save(Project project) async{
    ResultObject<Project> result = ResultObject();
    ProjectsCompanion p = ProjectsCompanion(
      name: Value<String>(project.name),
      coin: Value<String>(project.coin)
    );

    try {
      ProjectDTO dto;
      if (project.id == null) {
        dto = await into(projects).insertReturning(p);

      } else {
        await (update(projects)..where((tbl) => tbl.id.equals(project.id!))).write(p);
        dto = await (select(projects)..where((tbl) => tbl.id.equals(project.id!))).getSingle();
      }

      result = ResultObject(Project(dto.name, dto.coin, id: dto.id));

    } on SqliteException catch(e) {
      if (e.extendedResultCode == 2067) { // UNIQUE CONSTRAINT ERROR CODE
        result.addErrorMessage('This project or coin is already present in your portfolio.');
        return Future.value(result);
      }
      result.addErrorMessage('An error occurred while saving your project.');
    }

    return Future.value(result);
  }


  Future<ResultObject<List<Project>>> findAllProjects() async{
    ResultObject<List<Project>> result = ResultObject();
    try {
      final q = await select(projects).get();
      result = ResultObject(q.map((row) {
        return Project(
          row.name,
          row.coin,
          id: row.id
        );
      }).toList());

    } on SqliteException catch(e) {
      result.addErrorMessage('An error occurred while loading your projects.');
    }

    return Future.value(result);
  }
}