import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/domain/transaction.dart';
import 'package:portfolio_manager/drift/database.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

@lazySingleton
class TransactionBlocFactory {
  final Database _db;

  TransactionBlocFactory(this._db);

  TransactionBloc create(Project project) {
    return TransactionBloc(project, _db);
  }
}


class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final Database _db;

  TransactionBloc(Project project, this._db) : super(TransactionInitial(project)) {
    on<TransactionSaved>(_onTransactionSaved);
  }


  void _onTransactionSaved(TransactionSaved event, Emitter<TransactionState> emit) async{
    final result = await _db.transactionsDao.save(
      Transaction(
        date: event.date,
        project: event.project,
        type: event.type,
        amount: event.amount,
        amountToSell: Decimal.zero,
        value: event.totalValue,
        proceeds: Decimal.zero,
        costs: Decimal.zero,
        fee: event.fee,
        fiatFee: event.fiatFee,
        note: event.note.isEmpty ? null : event.note
      )
    );
  }
}