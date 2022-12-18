import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:portfolio_manager/domain/fifo/fifo.dart';
import 'package:portfolio_manager/domain/fifo/trade_report.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/domain/transaction.dart';
import 'package:portfolio_manager/drift/database.dart';
import 'package:portfolio_manager/utils/result_object.dart';

part 'transactions_dao.g.dart';

@DriftAccessor(tables: [Projects, Transactions])
class TransactionsDao extends DatabaseAccessor<Database> with _$TransactionsDaoMixin {
  TransactionsDao(Database attachedDatabase) : super(attachedDatabase);

  Future<ResultObject<Transaction>> save(Transaction tx) async{
    ResultObject<Transaction> result = ResultObject();

    try {
      ResultObject<Transaction> result = await transaction(() async{
        TransactionsCompanion tcomp = TransactionsCompanion(
            id: tx.id == null ? const Value.absent() : Value<int>(tx.id!),
            date: Value<DateTime>(tx.date),
            project: Value<int>(tx.project.id!),
            type: Value<TransactionType>(tx.type),
            amount: Value<Decimal>(tx.amount),
            amountToSell: Value<Decimal>(tx.amountToSell),
            value: Value<Decimal>(tx.value),
            costs: Value<Decimal>(tx.costs),
            proceeds: Value<Decimal>(tx.proceeds),
            fee: Value<Decimal>(tx.fee),
            fiatFee: Value<Decimal>(tx.fiatFee),
            note: Value<String?>(tx.note),
        );

        int id = await into(transactions).insertOnConflictUpdate(tcomp);

        await _processTransactions(tx.project.id!);

        final q = select(transactions)..where((tbl) => tbl.id.equals(id == 0 ? tx.id! : id));
        TransactionDTO savedTransaction = await q.getSingle();

        final pq = select(projects);
        pq.where((tbl) => tbl.id.equals(tx.project.id!));
        ProjectDTO pdto = await pq.getSingle();

        return ResultObject(
          Transaction(
            id: savedTransaction.id,
            project: _mapProject(pdto),
            date: savedTransaction.date,
            type: savedTransaction.type,
            amount: savedTransaction.amount,
            amountToSell: savedTransaction.amountToSell,
            value: savedTransaction.value,
            costs: savedTransaction.costs,
            proceeds: savedTransaction.proceeds,
            fee: savedTransaction.fee,
            fiatFee: savedTransaction.fiatFee,
            note: savedTransaction.note
          )
        );
      });

      return Future.value(result);

    } on SqliteException catch(e) {
      result.addErrorMessage('An error occurred while saving the transaction.');
    }

    return Future.value(result);
  }

  Future<ResultObject<Project>> deleteTransaction(Transaction tx) async{
    ResultObject<Project> result = ResultObject();
    if (tx.id == null) {
      result.addErrorMessage('Transaction cannot be deleted');
      return result;
    }

    try {
      final dq = delete(transactions);
      dq.where((tbl) => tbl.id.equals(tx.id!));
      int affectedRows = await dq.go();

      await _processTransactions(tx.project.id!);

      final pq = select(projects);
      pq.where((tbl) => tbl.id.equals(tx.project.id!));
      ProjectDTO pdto = await pq.getSingle();

      result = ResultObject(_mapProject(pdto));

    } on SqliteException catch(e) {
      result.addErrorMessage('An error occurred while trying to delete the transaction');
      return result;
    }

    return Future.value(result);
  }


  Future<Fifo> _processTransactions(int projectId) async{
    final query = select(transactions);
    query.orderBy([(t) => OrderingTerm(expression: transactions.date, mode: OrderingMode.asc)]);
    query.where((tbl) => tbl.project.equals(projectId));

    final r = await query.get();
    final resultList = r.map((row) {
      return TransactionDTO(
          id: row.id,
          date: row.date,
          project: row.project,
          type: row.type,
          amount: row.amount,
          amountToSell: row.amountToSell,
          value: row.value,
          proceeds: row.proceeds,
          costs: row.costs,
          fee: row.fee,
          fiatFee: row.fiatFee
      );
    }).toList(growable: false);

    Fifo fifo = Fifo(symbol: '');
    for (TransactionDTO t in resultList) {
      switch (t.type) {
        case TransactionType.deposit:
          fifo.addDeposit(t.id, t.date, t.amount, t.fee, t.fiatFee);
          break;
        case TransactionType.withdrawal:
          fifo.addWithdrawal(t.id, t.date, t.amount, t.fee, t.fiatFee);
          break;
        case TransactionType.buy:
          fifo.addPurchase(t.id, t.date, t.amount, t.value, t.fee);
          break;
        case TransactionType.sell:
          fifo.addSale(t.id, t.date, t.amount, t.value, t.fiatFee);
          break;
        default: // transfer
          fifo.addTransfer(t.id, t.date, t.amount, t.fee, t.fiatFee);
          break;
      }
    }

    Map<int, TransactionDTO> txsMap = { for (TransactionDTO t in resultList) t.id : t };
    await batch((batch) {
      fifo.processTransactions(
          onTradeProcessed: (TradeReport report) {
            if (!txsMap.containsKey(report.id)) throw Exception("No transaction with id #[${report.id}] found!"); // TODO

            TransactionDTO dto = txsMap[report.id]!;
            if (report.amountToSell != dto.amountToSell ||
                report.proceeds != dto.proceeds ||
                report.costs != dto.costs)
            {
              batch.update(
                transactions,
                TransactionsCompanion(
                  amountToSell: Value<Decimal>(report.amountToSell),
                  proceeds: Value<Decimal>(report.proceeds),
                  costs: Value<Decimal>(report.costs),
                ),
                where: (tbl) => tbl.id.equals(report.id)
              );
            }
          }
      );
      batch.update(
        projects,
        ProjectsCompanion(
          currentAmount: Value<Decimal>(fifo.currentAmount),
          currentCosts: Value<Decimal>(fifo.currentCostBasis),
          realizedPnl: Value<Decimal>(fifo.totalProceeds),
        ),
        where: (tbl) => tbl.id.equals(projectId)
      );
    });

    return fifo;
  }


  Future<ResultObject<List<Transaction>>> findTransactions(int projectId) async{
    ResultObject<List<Transaction>> result = ResultObject();
    try {
      final query = select(transactions).join([
        leftOuterJoin(projects, projects.id.equalsExp(transactions.project))
      ]);
      query.orderBy([OrderingTerm.desc(transactions.date)]);
      query.where(transactions.project.equals(projectId));

      final r = await query.map((row) {
        final p = row.readTable(projects);
        final t = row.readTable(transactions);
        return Transaction(
          id: t.id,
          date: t.date,
          project: _mapProject(p),
          type: t.type,
          amount: t.amount,
          amountToSell: t.amountToSell,
          value: t.value,
          proceeds: t.proceeds,
          costs: t.costs,
          fee: t.fee,
          fiatFee: t.fiatFee,
          note: t.note
        );
      }).get();

      return ResultObject(r);

    } on SqliteException catch(e) {
      result.addErrorMessage("An error occurred while loading transactions");
    }

    return Future.value(result);
  }

  Project _mapProject(ProjectDTO pdto) {
    return Project(
      id: pdto.id,
      name: pdto.name,
      coin: pdto.coin,
      scale: pdto.scale,
      amount: pdto.currentAmount,
      currentCosts: pdto.currentCosts,
      realizedPnl: pdto.realizedPnl,
    );
  }
}