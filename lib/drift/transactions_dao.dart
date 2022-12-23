import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:portfolio_manager/domain/fifo/fifo.dart';
import 'package:portfolio_manager/domain/fifo/proceed.dart' as f;
import 'package:portfolio_manager/domain/proceed.dart' as d;
import 'package:portfolio_manager/domain/fifo/trade_report.dart';
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/domain/transaction.dart';
import 'package:portfolio_manager/drift/database.dart';
import 'package:portfolio_manager/utils/result_object.dart';

part 'transactions_dao.g.dart';

@DriftAccessor(tables: [Projects, Transactions, Proceeds])
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

        int id;
        if (tx.id == null) {
          id = await into(transactions).insert(tcomp);
        } else {
          id = tx.id!;
          await (update(transactions)..where((tbl) => tbl.id.equals(id))).write(tcomp);
        }

        final proceedsQ = delete(proceeds);
        proceedsQ.where((tbl) => tbl.project.equals(tx.project.id!));
        await proceedsQ.go();

        await _processTransactions(tx.project.id!);

        final q = select(transactions)..where((tbl) => tbl.id.equals(id));
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
    } on NotEnoughHoldingsException catch(e) {
      result.addErrorMessage('Transaction cannot be updated because your holdings would become negative');
    }

    return Future.value(result);
  }

  Future<ResultObject<int>> deleteTransaction(Transaction tx) async{
    ResultObject<int> result = ResultObject();
    if (tx.id == null) {
      result.addErrorMessage('Transaction cannot be deleted');
      return result;
    }

    try {
      result = await transaction(() async{
        final pq = delete(proceeds);
        pq.where((tbl) => tbl.project.equals(tx.project.id!));
        await pq.go();

        final dq = delete(transactions);
        dq.where((tbl) => tbl.id.equals(tx.id!));
        int affectedRows = await dq.go();

        await _processTransactions(tx.project.id!);

        return ResultObject(affectedRows);
      });

    } on SqliteException catch(e) {
      result.addErrorMessage('An error occurred while trying to delete the transaction');
    } on NotEnoughHoldingsException catch (e) {
      result.addErrorMessage('Transaction cannot be deleted because your holdings would become negative');
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
          },
        onProceedCreated: (int purchaseID, int saleID, f.Proceed proceed) {
          batch.insert(
            proceeds,
            ProceedsCompanion.insert(
              project: projectId,
              purchase: purchaseID,
              sale: saleID,
              amountSold: proceed.amount,
              costs: proceed.costs,
              value: proceed.saleValue
            )
          );
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

  Future<ResultObject<List<d.Proceed>>> findProceeds(Transaction tx) async{
    ResultObject<List<d.Proceed>> result = ResultObject();
    try {
      final q = select(this.proceeds);
      if (tx.type == TransactionType.buy) {
        q.where((tbl) => tbl.purchase.equals(tx.id!));
      } else if (tx.type == TransactionType.sell) {
        q.where((tbl) => tbl.sale.equals(tx.id!));
      } else {
        // TODO
      }

      List<d.Proceed> proceeds = await q.map((row) {
        return d.Proceed(
          amountSold: row.amountSold,
          costs: row.costs,
          value: row.value
        );
      }).get();

      result = ResultObject(proceeds);

    } on SqliteException catch (e) {
      result.addErrorMessage('An error occurred while loading proceeds of this transaction');
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
      feesPaid: pdto.feesPaid,
      fiatFeesPaid: pdto.fiatFeesPaid,
    );
  }
}