// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ProjectDTO extends DataClass implements Insertable<ProjectDTO> {
  final int id;
  final String name;
  final String coin;
  const ProjectDTO({required this.id, required this.name, required this.coin});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['coin'] = Variable<String>(coin);
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      name: Value(name),
      coin: Value(coin),
    );
  }

  factory ProjectDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectDTO(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      coin: serializer.fromJson<String>(json['coin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'coin': serializer.toJson<String>(coin),
    };
  }

  ProjectDTO copyWith({int? id, String? name, String? coin}) => ProjectDTO(
        id: id ?? this.id,
        name: name ?? this.name,
        coin: coin ?? this.coin,
      );
  @override
  String toString() {
    return (StringBuffer('ProjectDTO(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('coin: $coin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, coin);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectDTO &&
          other.id == this.id &&
          other.name == this.name &&
          other.coin == this.coin);
}

class ProjectsCompanion extends UpdateCompanion<ProjectDTO> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> coin;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.coin = const Value.absent(),
  });
  ProjectsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String coin,
  })  : name = Value(name),
        coin = Value(coin);
  static Insertable<ProjectDTO> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? coin,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (coin != null) 'coin': coin,
    });
  }

  ProjectsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String>? coin}) {
    return ProjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      coin: coin ?? this.coin,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (coin.present) {
      map['coin'] = Variable<String>(coin.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('coin: $coin')
          ..write(')'))
        .toString();
  }
}

class $ProjectsTable extends Projects
    with TableInfo<$ProjectsTable, ProjectDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE NOT NULL');
  final VerificationMeta _coinMeta = const VerificationMeta('coin');
  @override
  late final GeneratedColumn<String> coin = GeneratedColumn<String>(
      'coin', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, name, coin];
  @override
  String get aliasedName => _alias ?? 'projects';
  @override
  String get actualTableName => 'projects';
  @override
  VerificationContext validateIntegrity(Insertable<ProjectDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('coin')) {
      context.handle(
          _coinMeta, coin.isAcceptableOrUnknown(data['coin']!, _coinMeta));
    } else if (isInserting) {
      context.missing(_coinMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProjectDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectDTO(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      coin: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}coin'])!,
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final ProjectsDao projectsDao = ProjectsDao(this as Database);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [projects];
}
