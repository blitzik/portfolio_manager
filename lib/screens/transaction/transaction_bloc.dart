import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:portfolio_manager/domain/project.dart';
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
    on<TransactionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
