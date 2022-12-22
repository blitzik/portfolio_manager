import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:portfolio_manager/domain/proceed.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/domain/transaction.dart';
import 'package:portfolio_manager/drift/database.dart';
import 'package:portfolio_manager/utils/result_object.dart';

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
    on<TransactionLoaded>(_onTransactionLoaded);
  }

  void _onTransactionLoaded(TransactionLoaded event, Emitter<TransactionState> emit) async{
    emit(TransactionLoadInProgress(state.project));
    if (event.transaction == null) {
      emit(TransactionLoadedSuccessfully(state.project, []));

    } else {
      ResultObject<List<Proceed>> loadingProceeds = await _db.transactionsDao.findProceeds(event.transaction!);
      if (loadingProceeds.isSuccess) {
        emit(TransactionLoadedSuccessfully(state.project, loadingProceeds.value ?? []));
      }
    }
  }


  void _onTransactionSaved(TransactionSaved event, Emitter<TransactionState> emit) async{
    String? note = event.note == null ?  null : event.note!.trim();

    Transaction tx;
    switch (event.type) {
      case TransactionType.deposit:
        tx = Transaction.deposit(
          id: event.id,
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
          id: event.id,
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
          id: event.id,
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
          id: event.id,
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
          id: event.id,
          date: event.date,
          project: event.project,
          amount: event.amount,
          value: event.totalValue,
          fee: event.fee,
          note: note
        );
        break;
    }

    ResultObject<Transaction> saving = await _db.transactionsDao.save(tx);
    if (saving.isSuccess) {
      Transaction tx = saving.value!;
      emit(TransactionSavedSuccessfully(tx.project, tx));
    } else {
      emit(TransactionSaveFailure(event.project, saving.lastErrorMessage));
    }
  }
}