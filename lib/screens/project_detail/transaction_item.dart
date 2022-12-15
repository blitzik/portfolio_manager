import 'package:flutter/material.dart';
import 'package:portfolio_manager/domain/transaction.dart';
import 'package:portfolio_manager/screens/project_detail/buy.dart';
import 'package:portfolio_manager/screens/project_detail/deposit.dart';
import 'package:portfolio_manager/screens/project_detail/sell.dart';
import 'package:portfolio_manager/screens/project_detail/transfer.dart';
import 'package:portfolio_manager/screens/project_detail/withdrawal.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (transaction.type) {
      case TransactionType.deposit:
        return Deposit(transaction: transaction);

      case TransactionType.withdrawal:
        return Withdrawal(transaction: transaction);

      case TransactionType.buy:
        return Buy(transaction: transaction);

      case TransactionType.sell:
        return Sell(transaction: transaction);

      case TransactionType.transfer:
        return Transfer(transaction: transaction);
    }
  }
}