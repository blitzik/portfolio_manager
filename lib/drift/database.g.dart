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
  final int scale;
  final Decimal currentAmount;
  final Decimal realizedPnl;
  final Decimal currentCosts;
  final Decimal feesPaid;
  final Decimal fiatFeesPaid;
  const ProjectDTO(
      {required this.id,
      required this.name,
      required this.coin,
      required this.scale,
      required this.currentAmount,
      required this.realizedPnl,
      required this.currentCosts,
      required this.feesPaid,
      required this.fiatFeesPaid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['coin'] = Variable<String>(coin);
    map['scale'] = Variable<int>(scale);
    {
      final converter = $ProjectsTable.$converter0;
      map['current_amount'] = Variable<String>(converter.toSql(currentAmount));
    }
    {
      final converter = $ProjectsTable.$converter1;
      map['realized_pnl'] = Variable<String>(converter.toSql(realizedPnl));
    }
    {
      final converter = $ProjectsTable.$converter2;
      map['current_costs'] = Variable<String>(converter.toSql(currentCosts));
    }
    {
      final converter = $ProjectsTable.$converter3;
      map['fees_paid'] = Variable<String>(converter.toSql(feesPaid));
    }
    {
      final converter = $ProjectsTable.$converter4;
      map['fiat_fees_paid'] = Variable<String>(converter.toSql(fiatFeesPaid));
    }
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      name: Value(name),
      coin: Value(coin),
      scale: Value(scale),
      currentAmount: Value(currentAmount),
      realizedPnl: Value(realizedPnl),
      currentCosts: Value(currentCosts),
      feesPaid: Value(feesPaid),
      fiatFeesPaid: Value(fiatFeesPaid),
    );
  }

  factory ProjectDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectDTO(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      coin: serializer.fromJson<String>(json['coin']),
      scale: serializer.fromJson<int>(json['scale']),
      currentAmount: serializer.fromJson<Decimal>(json['currentAmount']),
      realizedPnl: serializer.fromJson<Decimal>(json['realizedPnl']),
      currentCosts: serializer.fromJson<Decimal>(json['currentCosts']),
      feesPaid: serializer.fromJson<Decimal>(json['feesPaid']),
      fiatFeesPaid: serializer.fromJson<Decimal>(json['fiatFeesPaid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'coin': serializer.toJson<String>(coin),
      'scale': serializer.toJson<int>(scale),
      'currentAmount': serializer.toJson<Decimal>(currentAmount),
      'realizedPnl': serializer.toJson<Decimal>(realizedPnl),
      'currentCosts': serializer.toJson<Decimal>(currentCosts),
      'feesPaid': serializer.toJson<Decimal>(feesPaid),
      'fiatFeesPaid': serializer.toJson<Decimal>(fiatFeesPaid),
    };
  }

  ProjectDTO copyWith(
          {int? id,
          String? name,
          String? coin,
          int? scale,
          Decimal? currentAmount,
          Decimal? realizedPnl,
          Decimal? currentCosts,
          Decimal? feesPaid,
          Decimal? fiatFeesPaid}) =>
      ProjectDTO(
        id: id ?? this.id,
        name: name ?? this.name,
        coin: coin ?? this.coin,
        scale: scale ?? this.scale,
        currentAmount: currentAmount ?? this.currentAmount,
        realizedPnl: realizedPnl ?? this.realizedPnl,
        currentCosts: currentCosts ?? this.currentCosts,
        feesPaid: feesPaid ?? this.feesPaid,
        fiatFeesPaid: fiatFeesPaid ?? this.fiatFeesPaid,
      );
  @override
  String toString() {
    return (StringBuffer('ProjectDTO(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('coin: $coin, ')
          ..write('scale: $scale, ')
          ..write('currentAmount: $currentAmount, ')
          ..write('realizedPnl: $realizedPnl, ')
          ..write('currentCosts: $currentCosts, ')
          ..write('feesPaid: $feesPaid, ')
          ..write('fiatFeesPaid: $fiatFeesPaid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, coin, scale, currentAmount,
      realizedPnl, currentCosts, feesPaid, fiatFeesPaid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectDTO &&
          other.id == this.id &&
          other.name == this.name &&
          other.coin == this.coin &&
          other.scale == this.scale &&
          other.currentAmount == this.currentAmount &&
          other.realizedPnl == this.realizedPnl &&
          other.currentCosts == this.currentCosts &&
          other.feesPaid == this.feesPaid &&
          other.fiatFeesPaid == this.fiatFeesPaid);
}

class ProjectsCompanion extends UpdateCompanion<ProjectDTO> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> coin;
  final Value<int> scale;
  final Value<Decimal> currentAmount;
  final Value<Decimal> realizedPnl;
  final Value<Decimal> currentCosts;
  final Value<Decimal> feesPaid;
  final Value<Decimal> fiatFeesPaid;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.coin = const Value.absent(),
    this.scale = const Value.absent(),
    this.currentAmount = const Value.absent(),
    this.realizedPnl = const Value.absent(),
    this.currentCosts = const Value.absent(),
    this.feesPaid = const Value.absent(),
    this.fiatFeesPaid = const Value.absent(),
  });
  ProjectsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String coin,
    required int scale,
    this.currentAmount = const Value.absent(),
    this.realizedPnl = const Value.absent(),
    this.currentCosts = const Value.absent(),
    this.feesPaid = const Value.absent(),
    this.fiatFeesPaid = const Value.absent(),
  })  : name = Value(name),
        coin = Value(coin),
        scale = Value(scale);
  static Insertable<ProjectDTO> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? coin,
    Expression<int>? scale,
    Expression<String>? currentAmount,
    Expression<String>? realizedPnl,
    Expression<String>? currentCosts,
    Expression<String>? feesPaid,
    Expression<String>? fiatFeesPaid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (coin != null) 'coin': coin,
      if (scale != null) 'scale': scale,
      if (currentAmount != null) 'current_amount': currentAmount,
      if (realizedPnl != null) 'realized_pnl': realizedPnl,
      if (currentCosts != null) 'current_costs': currentCosts,
      if (feesPaid != null) 'fees_paid': feesPaid,
      if (fiatFeesPaid != null) 'fiat_fees_paid': fiatFeesPaid,
    });
  }

  ProjectsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? coin,
      Value<int>? scale,
      Value<Decimal>? currentAmount,
      Value<Decimal>? realizedPnl,
      Value<Decimal>? currentCosts,
      Value<Decimal>? feesPaid,
      Value<Decimal>? fiatFeesPaid}) {
    return ProjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      coin: coin ?? this.coin,
      scale: scale ?? this.scale,
      currentAmount: currentAmount ?? this.currentAmount,
      realizedPnl: realizedPnl ?? this.realizedPnl,
      currentCosts: currentCosts ?? this.currentCosts,
      feesPaid: feesPaid ?? this.feesPaid,
      fiatFeesPaid: fiatFeesPaid ?? this.fiatFeesPaid,
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
    if (scale.present) {
      map['scale'] = Variable<int>(scale.value);
    }
    if (currentAmount.present) {
      final converter = $ProjectsTable.$converter0;
      map['current_amount'] =
          Variable<String>(converter.toSql(currentAmount.value));
    }
    if (realizedPnl.present) {
      final converter = $ProjectsTable.$converter1;
      map['realized_pnl'] =
          Variable<String>(converter.toSql(realizedPnl.value));
    }
    if (currentCosts.present) {
      final converter = $ProjectsTable.$converter2;
      map['current_costs'] =
          Variable<String>(converter.toSql(currentCosts.value));
    }
    if (feesPaid.present) {
      final converter = $ProjectsTable.$converter3;
      map['fees_paid'] = Variable<String>(converter.toSql(feesPaid.value));
    }
    if (fiatFeesPaid.present) {
      final converter = $ProjectsTable.$converter4;
      map['fiat_fees_paid'] =
          Variable<String>(converter.toSql(fiatFeesPaid.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('coin: $coin, ')
          ..write('scale: $scale, ')
          ..write('currentAmount: $currentAmount, ')
          ..write('realizedPnl: $realizedPnl, ')
          ..write('currentCosts: $currentCosts, ')
          ..write('feesPaid: $feesPaid, ')
          ..write('fiatFeesPaid: $fiatFeesPaid')
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
  final VerificationMeta _scaleMeta = const VerificationMeta('scale');
  @override
  late final GeneratedColumn<int> scale = GeneratedColumn<int>(
      'scale', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _currentAmountMeta =
      const VerificationMeta('currentAmount');
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> currentAmount =
      GeneratedColumn<String>('current_amount', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('0.0'))
          .withConverter<Decimal>($ProjectsTable.$converter0);
  final VerificationMeta _realizedPnlMeta =
      const VerificationMeta('realizedPnl');
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> realizedPnl =
      GeneratedColumn<String>('realized_pnl', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('0.0'))
          .withConverter<Decimal>($ProjectsTable.$converter1);
  final VerificationMeta _currentCostsMeta =
      const VerificationMeta('currentCosts');
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> currentCosts =
      GeneratedColumn<String>('current_costs', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('0.0'))
          .withConverter<Decimal>($ProjectsTable.$converter2);
  final VerificationMeta _feesPaidMeta = const VerificationMeta('feesPaid');
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> feesPaid =
      GeneratedColumn<String>('fees_paid', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('0.0'))
          .withConverter<Decimal>($ProjectsTable.$converter3);
  final VerificationMeta _fiatFeesPaidMeta =
      const VerificationMeta('fiatFeesPaid');
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> fiatFeesPaid =
      GeneratedColumn<String>('fiat_fees_paid', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('0.0'))
          .withConverter<Decimal>($ProjectsTable.$converter4);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        coin,
        scale,
        currentAmount,
        realizedPnl,
        currentCosts,
        feesPaid,
        fiatFeesPaid
      ];
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
    if (data.containsKey('scale')) {
      context.handle(
          _scaleMeta, scale.isAcceptableOrUnknown(data['scale']!, _scaleMeta));
    } else if (isInserting) {
      context.missing(_scaleMeta);
    }
    context.handle(_currentAmountMeta, const VerificationResult.success());
    context.handle(_realizedPnlMeta, const VerificationResult.success());
    context.handle(_currentCostsMeta, const VerificationResult.success());
    context.handle(_feesPaidMeta, const VerificationResult.success());
    context.handle(_fiatFeesPaidMeta, const VerificationResult.success());
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
      scale: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}scale'])!,
      currentAmount: $ProjectsTable.$converter0.fromSql(
          attachedDatabase.options.types.read(
              DriftSqlType.string, data['${effectivePrefix}current_amount'])!),
      realizedPnl: $ProjectsTable.$converter1.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.string, data['${effectivePrefix}realized_pnl'])!),
      currentCosts: $ProjectsTable.$converter2.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.string, data['${effectivePrefix}current_costs'])!),
      feesPaid: $ProjectsTable.$converter3.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.string, data['${effectivePrefix}fees_paid'])!),
      fiatFeesPaid: $ProjectsTable.$converter4.fromSql(
          attachedDatabase.options.types.read(
              DriftSqlType.string, data['${effectivePrefix}fiat_fees_paid'])!),
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }

  static TypeConverter<Decimal, String> $converter0 = decimalConverter;
  static TypeConverter<Decimal, String> $converter1 = decimalConverter;
  static TypeConverter<Decimal, String> $converter2 = decimalConverter;
  static TypeConverter<Decimal, String> $converter3 = decimalConverter;
  static TypeConverter<Decimal, String> $converter4 = decimalConverter;
}

class TransactionDTO extends DataClass implements Insertable<TransactionDTO> {
  final int id;
  final DateTime date;
  final int project;
  final TransactionType type;
  final Decimal amount;
  final Decimal amountToSell;
  final Decimal value;
  final Decimal proceeds;
  final Decimal costs;
  final Decimal fee;
  final Decimal fiatFee;
  final String? note;
  const TransactionDTO(
      {required this.id,
      required this.date,
      required this.project,
      required this.type,
      required this.amount,
      required this.amountToSell,
      required this.value,
      required this.proceeds,
      required this.costs,
      required this.fee,
      required this.fiatFee,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['project'] = Variable<int>(project);
    {
      final converter = $TransactionsTable.$converter0;
      map['type'] = Variable<int>(converter.toSql(type));
    }
    {
      final converter = $TransactionsTable.$converter1;
      map['amount'] = Variable<String>(converter.toSql(amount));
    }
    {
      final converter = $TransactionsTable.$converter2;
      map['amount_to_sell'] = Variable<String>(converter.toSql(amountToSell));
    }
    {
      final converter = $TransactionsTable.$converter3;
      map['value'] = Variable<String>(converter.toSql(value));
    }
    {
      final converter = $TransactionsTable.$converter4;
      map['proceeds'] = Variable<String>(converter.toSql(proceeds));
    }
    {
      final converter = $TransactionsTable.$converter5;
      map['costs'] = Variable<String>(converter.toSql(costs));
    }
    {
      final converter = $TransactionsTable.$converter6;
      map['fee'] = Variable<String>(converter.toSql(fee));
    }
    {
      final converter = $TransactionsTable.$converter7;
      map['fiat_fee'] = Variable<String>(converter.toSql(fiatFee));
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      date: Value(date),
      project: Value(project),
      type: Value(type),
      amount: Value(amount),
      amountToSell: Value(amountToSell),
      value: Value(value),
      proceeds: Value(proceeds),
      costs: Value(costs),
      fee: Value(fee),
      fiatFee: Value(fiatFee),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory TransactionDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionDTO(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      project: serializer.fromJson<int>(json['project']),
      type: serializer.fromJson<TransactionType>(json['type']),
      amount: serializer.fromJson<Decimal>(json['amount']),
      amountToSell: serializer.fromJson<Decimal>(json['amountToSell']),
      value: serializer.fromJson<Decimal>(json['value']),
      proceeds: serializer.fromJson<Decimal>(json['proceeds']),
      costs: serializer.fromJson<Decimal>(json['costs']),
      fee: serializer.fromJson<Decimal>(json['fee']),
      fiatFee: serializer.fromJson<Decimal>(json['fiatFee']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'project': serializer.toJson<int>(project),
      'type': serializer.toJson<TransactionType>(type),
      'amount': serializer.toJson<Decimal>(amount),
      'amountToSell': serializer.toJson<Decimal>(amountToSell),
      'value': serializer.toJson<Decimal>(value),
      'proceeds': serializer.toJson<Decimal>(proceeds),
      'costs': serializer.toJson<Decimal>(costs),
      'fee': serializer.toJson<Decimal>(fee),
      'fiatFee': serializer.toJson<Decimal>(fiatFee),
      'note': serializer.toJson<String?>(note),
    };
  }

  TransactionDTO copyWith(
          {int? id,
          DateTime? date,
          int? project,
          TransactionType? type,
          Decimal? amount,
          Decimal? amountToSell,
          Decimal? value,
          Decimal? proceeds,
          Decimal? costs,
          Decimal? fee,
          Decimal? fiatFee,
          Value<String?> note = const Value.absent()}) =>
      TransactionDTO(
        id: id ?? this.id,
        date: date ?? this.date,
        project: project ?? this.project,
        type: type ?? this.type,
        amount: amount ?? this.amount,
        amountToSell: amountToSell ?? this.amountToSell,
        value: value ?? this.value,
        proceeds: proceeds ?? this.proceeds,
        costs: costs ?? this.costs,
        fee: fee ?? this.fee,
        fiatFee: fiatFee ?? this.fiatFee,
        note: note.present ? note.value : this.note,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionDTO(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('project: $project, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('amountToSell: $amountToSell, ')
          ..write('value: $value, ')
          ..write('proceeds: $proceeds, ')
          ..write('costs: $costs, ')
          ..write('fee: $fee, ')
          ..write('fiatFee: $fiatFee, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, project, type, amount, amountToSell,
      value, proceeds, costs, fee, fiatFee, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionDTO &&
          other.id == this.id &&
          other.date == this.date &&
          other.project == this.project &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.amountToSell == this.amountToSell &&
          other.value == this.value &&
          other.proceeds == this.proceeds &&
          other.costs == this.costs &&
          other.fee == this.fee &&
          other.fiatFee == this.fiatFee &&
          other.note == this.note);
}

class TransactionsCompanion extends UpdateCompanion<TransactionDTO> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> project;
  final Value<TransactionType> type;
  final Value<Decimal> amount;
  final Value<Decimal> amountToSell;
  final Value<Decimal> value;
  final Value<Decimal> proceeds;
  final Value<Decimal> costs;
  final Value<Decimal> fee;
  final Value<Decimal> fiatFee;
  final Value<String?> note;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.project = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.amountToSell = const Value.absent(),
    this.value = const Value.absent(),
    this.proceeds = const Value.absent(),
    this.costs = const Value.absent(),
    this.fee = const Value.absent(),
    this.fiatFee = const Value.absent(),
    this.note = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int project,
    required TransactionType type,
    this.amount = const Value.absent(),
    this.amountToSell = const Value.absent(),
    this.value = const Value.absent(),
    this.proceeds = const Value.absent(),
    this.costs = const Value.absent(),
    this.fee = const Value.absent(),
    this.fiatFee = const Value.absent(),
    this.note = const Value.absent(),
  })  : date = Value(date),
        project = Value(project),
        type = Value(type);
  static Insertable<TransactionDTO> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? project,
    Expression<int>? type,
    Expression<String>? amount,
    Expression<String>? amountToSell,
    Expression<String>? value,
    Expression<String>? proceeds,
    Expression<String>? costs,
    Expression<String>? fee,
    Expression<String>? fiatFee,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (project != null) 'project': project,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (amountToSell != null) 'amount_to_sell': amountToSell,
      if (value != null) 'value': value,
      if (proceeds != null) 'proceeds': proceeds,
      if (costs != null) 'costs': costs,
      if (fee != null) 'fee': fee,
      if (fiatFee != null) 'fiat_fee': fiatFee,
      if (note != null) 'note': note,
    });
  }

  TransactionsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<int>? project,
      Value<TransactionType>? type,
      Value<Decimal>? amount,
      Value<Decimal>? amountToSell,
      Value<Decimal>? value,
      Value<Decimal>? proceeds,
      Value<Decimal>? costs,
      Value<Decimal>? fee,
      Value<Decimal>? fiatFee,
      Value<String?>? note}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      project: project ?? this.project,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      amountToSell: amountToSell ?? this.amountToSell,
      value: value ?? this.value,
      proceeds: proceeds ?? this.proceeds,
      costs: costs ?? this.costs,
      fee: fee ?? this.fee,
      fiatFee: fiatFee ?? this.fiatFee,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (project.present) {
      map['project'] = Variable<int>(project.value);
    }
    if (type.present) {
      final converter = $TransactionsTable.$converter0;
      map['type'] = Variable<int>(converter.toSql(type.value));
    }
    if (amount.present) {
      final converter = $TransactionsTable.$converter1;
      map['amount'] = Variable<String>(converter.toSql(amount.value));
    }
    if (amountToSell.present) {
      final converter = $TransactionsTable.$converter2;
      map['amount_to_sell'] =
          Variable<String>(converter.toSql(amountToSell.value));
    }
    if (value.present) {
      final converter = $TransactionsTable.$converter3;
      map['value'] = Variable<String>(converter.toSql(value.value));
    }
    if (proceeds.present) {
      final converter = $TransactionsTable.$converter4;
      map['proceeds'] = Variable<String>(converter.toSql(proceeds.value));
    }
    if (costs.present) {
      final converter = $TransactionsTable.$converter5;
      map['costs'] = Variable<String>(converter.toSql(costs.value));
    }
    if (fee.present) {
      final converter = $TransactionsTable.$converter6;
      map['fee'] = Variable<String>(converter.toSql(fee.value));
    }
    if (fiatFee.present) {
      final converter = $TransactionsTable.$converter7;
      map['fiat_fee'] = Variable<String>(converter.toSql(fiatFee.value));
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('project: $project, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('amountToSell: $amountToSell, ')
          ..write('value: $value, ')
          ..write('proceeds: $proceeds, ')
          ..write('costs: $costs, ')
          ..write('fee: $fee, ')
          ..write('fiatFee: $fiatFee, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, TransactionDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _projectMeta = const VerificationMeta('project');
  @override
  late final GeneratedColumn<int> project = GeneratedColumn<int>(
      'project', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "projects" ("id")');
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<TransactionType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<TransactionType>($TransactionsTable.$converter0);
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> amount =
      GeneratedColumn<String>('amount', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('0.0'))
          .withConverter<Decimal>($TransactionsTable.$converter1);
  final VerificationMeta _amountToSellMeta =
      const VerificationMeta('amountToSell');
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> amountToSell =
      GeneratedColumn<String>('amount_to_sell', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('0.0'))
          .withConverter<Decimal>($TransactionsTable.$converter2);
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> value =
      GeneratedColumn<String>('value', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('0.0'))
          .withConverter<Decimal>($TransactionsTable.$converter3);
  final VerificationMeta _proceedsMeta = const VerificationMeta('proceeds');
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> proceeds =
      GeneratedColumn<String>('proceeds', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('0.0'))
          .withConverter<Decimal>($TransactionsTable.$converter4);
  final VerificationMeta _costsMeta = const VerificationMeta('costs');
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> costs =
      GeneratedColumn<String>('costs', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('0.0'))
          .withConverter<Decimal>($TransactionsTable.$converter5);
  final VerificationMeta _feeMeta = const VerificationMeta('fee');
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> fee =
      GeneratedColumn<String>('fee', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('0.0'))
          .withConverter<Decimal>($TransactionsTable.$converter6);
  final VerificationMeta _fiatFeeMeta = const VerificationMeta('fiatFee');
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> fiatFee =
      GeneratedColumn<String>('fiat_fee', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('0.0'))
          .withConverter<Decimal>($TransactionsTable.$converter7);
  final VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        project,
        type,
        amount,
        amountToSell,
        value,
        proceeds,
        costs,
        fee,
        fiatFee,
        note
      ];
  @override
  String get aliasedName => _alias ?? 'transactions';
  @override
  String get actualTableName => 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<TransactionDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('project')) {
      context.handle(_projectMeta,
          project.isAcceptableOrUnknown(data['project']!, _projectMeta));
    } else if (isInserting) {
      context.missing(_projectMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    context.handle(_amountMeta, const VerificationResult.success());
    context.handle(_amountToSellMeta, const VerificationResult.success());
    context.handle(_valueMeta, const VerificationResult.success());
    context.handle(_proceedsMeta, const VerificationResult.success());
    context.handle(_costsMeta, const VerificationResult.success());
    context.handle(_feeMeta, const VerificationResult.success());
    context.handle(_fiatFeeMeta, const VerificationResult.success());
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionDTO(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      project: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}project'])!,
      type: $TransactionsTable.$converter0.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      amount: $TransactionsTable.$converter1.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.string, data['${effectivePrefix}amount'])!),
      amountToSell: $TransactionsTable.$converter2.fromSql(
          attachedDatabase.options.types.read(
              DriftSqlType.string, data['${effectivePrefix}amount_to_sell'])!),
      value: $TransactionsTable.$converter3.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!),
      proceeds: $TransactionsTable.$converter4.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.string, data['${effectivePrefix}proceeds'])!),
      costs: $TransactionsTable.$converter5.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.string, data['${effectivePrefix}costs'])!),
      fee: $TransactionsTable.$converter6.fromSql(attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}fee'])!),
      fiatFee: $TransactionsTable.$converter7.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.string, data['${effectivePrefix}fiat_fee'])!),
      note: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }

  static TypeConverter<TransactionType, int> $converter0 =
      const EnumIndexConverter<TransactionType>(TransactionType.values);
  static TypeConverter<Decimal, String> $converter1 = decimalConverter;
  static TypeConverter<Decimal, String> $converter2 = decimalConverter;
  static TypeConverter<Decimal, String> $converter3 = decimalConverter;
  static TypeConverter<Decimal, String> $converter4 = decimalConverter;
  static TypeConverter<Decimal, String> $converter5 = decimalConverter;
  static TypeConverter<Decimal, String> $converter6 = decimalConverter;
  static TypeConverter<Decimal, String> $converter7 = decimalConverter;
}

class ProceedDTO extends DataClass implements Insertable<ProceedDTO> {
  final int id;
  final int project;
  final int purchase;
  final int sale;
  final Decimal amountSold;
  final Decimal costs;
  final Decimal value;
  const ProceedDTO(
      {required this.id,
      required this.project,
      required this.purchase,
      required this.sale,
      required this.amountSold,
      required this.costs,
      required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['project'] = Variable<int>(project);
    map['purchase'] = Variable<int>(purchase);
    map['sale'] = Variable<int>(sale);
    {
      final converter = $ProceedsTable.$converter0;
      map['amount_sold'] = Variable<String>(converter.toSql(amountSold));
    }
    {
      final converter = $ProceedsTable.$converter1;
      map['costs'] = Variable<String>(converter.toSql(costs));
    }
    {
      final converter = $ProceedsTable.$converter2;
      map['value'] = Variable<String>(converter.toSql(value));
    }
    return map;
  }

  ProceedsCompanion toCompanion(bool nullToAbsent) {
    return ProceedsCompanion(
      id: Value(id),
      project: Value(project),
      purchase: Value(purchase),
      sale: Value(sale),
      amountSold: Value(amountSold),
      costs: Value(costs),
      value: Value(value),
    );
  }

  factory ProceedDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProceedDTO(
      id: serializer.fromJson<int>(json['id']),
      project: serializer.fromJson<int>(json['project']),
      purchase: serializer.fromJson<int>(json['purchase']),
      sale: serializer.fromJson<int>(json['sale']),
      amountSold: serializer.fromJson<Decimal>(json['amountSold']),
      costs: serializer.fromJson<Decimal>(json['costs']),
      value: serializer.fromJson<Decimal>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'project': serializer.toJson<int>(project),
      'purchase': serializer.toJson<int>(purchase),
      'sale': serializer.toJson<int>(sale),
      'amountSold': serializer.toJson<Decimal>(amountSold),
      'costs': serializer.toJson<Decimal>(costs),
      'value': serializer.toJson<Decimal>(value),
    };
  }

  ProceedDTO copyWith(
          {int? id,
          int? project,
          int? purchase,
          int? sale,
          Decimal? amountSold,
          Decimal? costs,
          Decimal? value}) =>
      ProceedDTO(
        id: id ?? this.id,
        project: project ?? this.project,
        purchase: purchase ?? this.purchase,
        sale: sale ?? this.sale,
        amountSold: amountSold ?? this.amountSold,
        costs: costs ?? this.costs,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('ProceedDTO(')
          ..write('id: $id, ')
          ..write('project: $project, ')
          ..write('purchase: $purchase, ')
          ..write('sale: $sale, ')
          ..write('amountSold: $amountSold, ')
          ..write('costs: $costs, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, project, purchase, sale, amountSold, costs, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProceedDTO &&
          other.id == this.id &&
          other.project == this.project &&
          other.purchase == this.purchase &&
          other.sale == this.sale &&
          other.amountSold == this.amountSold &&
          other.costs == this.costs &&
          other.value == this.value);
}

class ProceedsCompanion extends UpdateCompanion<ProceedDTO> {
  final Value<int> id;
  final Value<int> project;
  final Value<int> purchase;
  final Value<int> sale;
  final Value<Decimal> amountSold;
  final Value<Decimal> costs;
  final Value<Decimal> value;
  const ProceedsCompanion({
    this.id = const Value.absent(),
    this.project = const Value.absent(),
    this.purchase = const Value.absent(),
    this.sale = const Value.absent(),
    this.amountSold = const Value.absent(),
    this.costs = const Value.absent(),
    this.value = const Value.absent(),
  });
  ProceedsCompanion.insert({
    this.id = const Value.absent(),
    required int project,
    required int purchase,
    required int sale,
    required Decimal amountSold,
    required Decimal costs,
    required Decimal value,
  })  : project = Value(project),
        purchase = Value(purchase),
        sale = Value(sale),
        amountSold = Value(amountSold),
        costs = Value(costs),
        value = Value(value);
  static Insertable<ProceedDTO> custom({
    Expression<int>? id,
    Expression<int>? project,
    Expression<int>? purchase,
    Expression<int>? sale,
    Expression<String>? amountSold,
    Expression<String>? costs,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (project != null) 'project': project,
      if (purchase != null) 'purchase': purchase,
      if (sale != null) 'sale': sale,
      if (amountSold != null) 'amount_sold': amountSold,
      if (costs != null) 'costs': costs,
      if (value != null) 'value': value,
    });
  }

  ProceedsCompanion copyWith(
      {Value<int>? id,
      Value<int>? project,
      Value<int>? purchase,
      Value<int>? sale,
      Value<Decimal>? amountSold,
      Value<Decimal>? costs,
      Value<Decimal>? value}) {
    return ProceedsCompanion(
      id: id ?? this.id,
      project: project ?? this.project,
      purchase: purchase ?? this.purchase,
      sale: sale ?? this.sale,
      amountSold: amountSold ?? this.amountSold,
      costs: costs ?? this.costs,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (project.present) {
      map['project'] = Variable<int>(project.value);
    }
    if (purchase.present) {
      map['purchase'] = Variable<int>(purchase.value);
    }
    if (sale.present) {
      map['sale'] = Variable<int>(sale.value);
    }
    if (amountSold.present) {
      final converter = $ProceedsTable.$converter0;
      map['amount_sold'] = Variable<String>(converter.toSql(amountSold.value));
    }
    if (costs.present) {
      final converter = $ProceedsTable.$converter1;
      map['costs'] = Variable<String>(converter.toSql(costs.value));
    }
    if (value.present) {
      final converter = $ProceedsTable.$converter2;
      map['value'] = Variable<String>(converter.toSql(value.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProceedsCompanion(')
          ..write('id: $id, ')
          ..write('project: $project, ')
          ..write('purchase: $purchase, ')
          ..write('sale: $sale, ')
          ..write('amountSold: $amountSold, ')
          ..write('costs: $costs, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $ProceedsTable extends Proceeds
    with TableInfo<$ProceedsTable, ProceedDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProceedsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _projectMeta = const VerificationMeta('project');
  @override
  late final GeneratedColumn<int> project = GeneratedColumn<int>(
      'project', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "projects" ("id")');
  final VerificationMeta _purchaseMeta = const VerificationMeta('purchase');
  @override
  late final GeneratedColumn<int> purchase = GeneratedColumn<int>(
      'purchase', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "transactions" ("id")');
  final VerificationMeta _saleMeta = const VerificationMeta('sale');
  @override
  late final GeneratedColumn<int> sale = GeneratedColumn<int>(
      'sale', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES "transactions" ("id")');
  final VerificationMeta _amountSoldMeta = const VerificationMeta('amountSold');
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> amountSold =
      GeneratedColumn<String>('amount_sold', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Decimal>($ProceedsTable.$converter0);
  final VerificationMeta _costsMeta = const VerificationMeta('costs');
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> costs =
      GeneratedColumn<String>('costs', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Decimal>($ProceedsTable.$converter1);
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumnWithTypeConverter<Decimal, String> value =
      GeneratedColumn<String>('value', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Decimal>($ProceedsTable.$converter2);
  @override
  List<GeneratedColumn> get $columns =>
      [id, project, purchase, sale, amountSold, costs, value];
  @override
  String get aliasedName => _alias ?? 'proceeds';
  @override
  String get actualTableName => 'proceeds';
  @override
  VerificationContext validateIntegrity(Insertable<ProceedDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('project')) {
      context.handle(_projectMeta,
          project.isAcceptableOrUnknown(data['project']!, _projectMeta));
    } else if (isInserting) {
      context.missing(_projectMeta);
    }
    if (data.containsKey('purchase')) {
      context.handle(_purchaseMeta,
          purchase.isAcceptableOrUnknown(data['purchase']!, _purchaseMeta));
    } else if (isInserting) {
      context.missing(_purchaseMeta);
    }
    if (data.containsKey('sale')) {
      context.handle(
          _saleMeta, sale.isAcceptableOrUnknown(data['sale']!, _saleMeta));
    } else if (isInserting) {
      context.missing(_saleMeta);
    }
    context.handle(_amountSoldMeta, const VerificationResult.success());
    context.handle(_costsMeta, const VerificationResult.success());
    context.handle(_valueMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProceedDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProceedDTO(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      project: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}project'])!,
      purchase: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}purchase'])!,
      sale: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}sale'])!,
      amountSold: $ProceedsTable.$converter0.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.string, data['${effectivePrefix}amount_sold'])!),
      costs: $ProceedsTable.$converter1.fromSql(attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}costs'])!),
      value: $ProceedsTable.$converter2.fromSql(attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!),
    );
  }

  @override
  $ProceedsTable createAlias(String alias) {
    return $ProceedsTable(attachedDatabase, alias);
  }

  static TypeConverter<Decimal, String> $converter0 = decimalConverter;
  static TypeConverter<Decimal, String> $converter1 = decimalConverter;
  static TypeConverter<Decimal, String> $converter2 = decimalConverter;
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $ProceedsTable proceeds = $ProceedsTable(this);
  late final ProjectsDao projectsDao = ProjectsDao(this as Database);
  late final TransactionsDao transactionsDao =
      TransactionsDao(this as Database);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [projects, transactions, proceeds];
}
