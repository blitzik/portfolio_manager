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
    String? note = event.note == null ?  null : event.note!.trim();

    Transaction tx;
    switch (event.type) {
      case TransactionType.deposit:
        tx = Transaction.deposit(
          date: event.date,
          project: event.project,
          amount: event.amount,
          value: event.totalValue,
          fee: event.fee,
          note: note
        );
        break;
      case TransactionType.withdrawal:
        tx = Transaction.withdrawal(
          date: event.date,
          project: event.project,
          amount: event.amount,
          value: event.totalValue,
          fee: event.fee,
          note: note
        );
        break;
      case TransactionType.buy:
        tx = Transaction.purchase(
          date: event.date,
          project: event.project,
          amount: event.amount,
          value: event.totalValue,
          fee: event.fee,
          note: note
        );
        break;
      case TransactionType.sell:
        tx = Transaction.sale(
          date: event.date,
          project: event.project,
          amount: event.amount,
          value: event.totalValue,
          fiatFee: event.fiatFee,
          note: note
        );
        break;
      case TransactionType.transfer:
        tx = Transaction.transfer(
          date: event.date,
          project: event.project,
          amount: event.amount,
          value: event.totalValue,
          fee: event.fee,
          note: note
        );
        break;
    }

    final result = await _db.transactionsDao.save(tx);
  }
}