import 'package:decimal/decimal.dart';
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
      coin: Value<String>(project.coin),
      scale: Value<int>(project.scale),
      currentAmount: Value<Decimal>(project.amount),
      realizedPnl: Value<Decimal>(project.realizedPnl)
    );

    try {
      ProjectDTO dto;
      if (project.id == null) {
        dto = await into(projects).insertReturning(p);

      } else {
        await (update(projects)..where((tbl) => tbl.id.equals(project.id!))).write(p);
        dto = await (select(projects)..where((tbl) => tbl.id.equals(project.id!))).getSingle();
      }

      result = ResultObject(
        Project(
          name: dto.name,
          coin: dto.coin,
          scale: dto.scale,
          amount: dto.currentAmount,
          currentCosts: dto.currentCosts,
          realizedPnl: dto.realizedPnl,
          id: dto.id
        )
      );

    } on SqliteException catch(e) {
      if (e.extendedResultCode == 2067) { // UNIQUE CONSTRAINT ERROR CODE
        result.addErrorMessage('This project or coin is already present in your portfolio.');
        return Future.value(result);
      }
      result.addErrorMessage('An error occurred while saving your project.');
    }

    return Future.value(result);
  }


  Future<ResultObject<Project>> getProjectById(int id) async{
    ResultObject<Project> result = ResultObject();
    try {
      final pq = select(projects);
      pq.where((tbl) => tbl.id.equals(id));
      ProjectDTO p = await pq.getSingle();

      result = ResultObject(
        Project(
          name: p.name,
          coin: p.coin,
          scale: p.scale,
          amount: p.currentAmount,
          currentCosts: p.currentCosts,
          realizedPnl: p.realizedPnl
        )
      );

    } on SqliteException catch (e) {
      result.addErrorMessage('An error occurred while loading the project');
    }

    return Future.value(result);
  }


  ResultObject<Stream<List<Project>>> watchAllProjects() {
    ResultObject<Stream<List<Project>>> result = ResultObject();

    try {
      final s = select(projects).watch().map((rows) {
        return rows.map((row) {
          return Project(
            id:  row.id,
            name: row.name,
            coin: row.coin,
            scale: row.scale,
            amount: row.currentAmount,
            currentCosts: row.currentCosts,
            realizedPnl: row.realizedPnl,
          );
        }).toList();
      });

      result = ResultObject(s);

    } on SqliteException catch (e) {
      result.addErrorMessage('TODO');
    }

    return result;
  }


  Future<ResultObject<List<Project>>> findAllProjects() async{
    ResultObject<List<Project>> result = ResultObject();
    try {
      final q = await select(projects).get();
      result = ResultObject(q.map((row) {
        return Project(
          name: row.name,
          coin: row.coin,
          scale: row.scale,
          amount: row.currentAmount,
          currentCosts: row.currentCosts,
          realizedPnl: row.realizedPnl,
          id: row.id
        );
      }).toList());

    } on SqliteException catch(e) {
      result.addErrorMessage('An error occurred while loading your projects.');
    }

    return Future.value(result);
  }
}