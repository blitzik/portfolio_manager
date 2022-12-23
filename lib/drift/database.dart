import 'dart:io';

import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:portfolio_manager/domain/transaction.dart';
import 'package:portfolio_manager/drift/decimal_converter.dart';
import 'package:portfolio_manager/drift/projects_dao.dart';
import 'package:portfolio_manager/drift/transactions_dao.dart';

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
    //final dbFolder = await getApplicationDocumentsDirectory();
    final dbFolder = Directory('.');
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file, logStatements: true);
  });
}

@DataClassName('ProjectDTO')
class Projects extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().customConstraint('UNIQUE NOT NULL')();
  TextColumn get coin => text().customConstraint('UNIQUE NOT NULL')();
  IntColumn get scale => integer()();
  TextColumn get currentAmount => text().map(decimalConverter).withDefault(const Constant('0.0'))();
  TextColumn get realizedPnl => text().map(decimalConverter).withDefault(const Constant('0.0'))();
  TextColumn get currentCosts => text().map(decimalConverter).withDefault(const Constant('0.0'))();
  TextColumn get feesPaid => text().map(decimalConverter).withDefault(const Constant('0.0'))();
  TextColumn get fiatFeesPaid => text().map(decimalConverter).withDefault(const Constant('0.0'))();
}


@DataClassName('TransactionDTO')
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get project => integer().references(Projects, #id)();
  IntColumn get type => intEnum<TransactionType>()();
  TextColumn get amount => text().map(decimalConverter).withDefault(const Constant('0.0'))();
  TextColumn get amountToSell => text().map(decimalConverter).withDefault(const Constant('0.0'))();
  TextColumn get value => text().map(decimalConverter).withDefault(const Constant('0.0'))();
  TextColumn get proceeds => text().map(decimalConverter).withDefault(const Constant('0.0'))();
  TextColumn get costs => text().map(decimalConverter).withDefault(const Constant('0.0'))();
  TextColumn get fee => text().map(decimalConverter).withDefault(const Constant('0.0'))();
  TextColumn get fiatFee => text().map(decimalConverter).withDefault(const Constant('0.0'))();
  TextColumn get note => text().nullable()();
}

@DataClassName('ProceedDTO')
class Proceeds extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get project => integer().references(Projects, #id)();
  IntColumn get purchase => integer().references(Transactions, #id)();
  IntColumn get sale => integer().references(Transactions, #id)();
  TextColumn get amountSold => text().map(decimalConverter)();
  TextColumn get costs => text().map(decimalConverter)();
  TextColumn get value => text().map(decimalConverter)();
}

bool isInDebugMode = false;

@Singleton()
@DriftDatabase(tables: [Projects, Transactions, Proceeds], daos: [ProjectsDao, TransactionsDao])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (Migrator m) async{
        await m.createAll();
        await m.createIndex(Index(transactions.actualTableName, 'CREATE INDEX txs_project_date ON transactions(project, date)'));
        await m.createIndex(Index(projects.actualTableName, 'CREATE INDEX txs_current_costs ON projects(current_costs)'));
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
        if (isInDebugMode) {
          final m = Migrator(this);
          await m.deleteTable(transactions.actualTableName);
          await m.deleteTable(projects.actualTableName);
          await m.deleteTable(proceeds.actualTableName);

          await m.createTable(projects);
          await m.createTable(transactions);
          await m.createTable(proceeds);
          await m.createIndex(Index(transactions.actualTableName, 'CREATE INDEX txs_project_date ON transactions(project, date)'));
          await m.createIndex(Index(projects.actualTableName, 'CREATE INDEX txs_current_costs ON projects(current_costs)'));
        }
      },
      onUpgrade: (Migrator m, oldVersion, newVersion) async{
      }
  );
}