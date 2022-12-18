import 'package:flutter/material.dart';
import 'package:money2/money2.dart' as m2;
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/utils/currency.dart';
import 'package:portfolio_manager/widgets/money_usd.dart';

class ProjectItem extends StatelessWidget {
  final Project project;

  const ProjectItem(this.project, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
              child: Text(project.name, style: const TextStyle(fontSize: 18.0))
          ),
          Expanded(
              child: Row(
                children: [
                  const Text('Realized P/L: ', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),),
                  MoneyUsd(project.realizedPnl, isColored: true,)
                ],
              )
          )
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text('${project.amount} ${project.coin}')
          ),
          Expanded(
            child: Text('Holdings cost: ${m2.Money.fromDecimalWithCurrency(project.currentCosts, Currency.usd)}')
          )
        ],
      ),
    );
  }
}