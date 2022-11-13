import 'dart:io';

import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:portfolio_manager/drift/decimal_converter.dart';
import 'package:portfolio_manager/drift/projects_dao.dart';

part 'database.g.dart';

DecimalConverter decimalConverter = const DecimalConverter();

d(String s) {
  return Decimal.parse(s);
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file, logStatements: true);
  });
}

@DataClassName('ProjectDTO')
class Projects extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().customConstraint("UNIQUE NOT NULL")();
  TextColumn get coin => text().customConstraint("UNIQUE NOT NULL")();
  TextColumn get amount => text().map(decimalConverter).withDefault(const Constant("0.0"))();
}

@Singleton()
@DriftDatabase(tables: [Projects], daos: [ProjectsDao])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (Migrator m) async{
        await m.createAll();
        //await m.createIndex(Index(records.actualTableName, 'CREATE INDEX records_date ON records(date)'));
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (Migrator m, oldVersion, newVersion) async{
      }
  );
}