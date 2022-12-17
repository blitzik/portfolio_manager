import 'package:flutter/material.dart';
import 'package:money2/money2.dart' as m2;
import 'package:portfolio_manager/domain/project.dart';
import 'package:portfolio_manager/utils/currency.dart';

class ProjectItem extends StatelessWidget {
  final Project project;

  const ProjectItem(this.project, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(project.name, style: const TextStyle(fontSize: 18.0),),
      subtitle: Text("Holdings: ${project.amount} | Holdings cost: ${m2.Money.fromDecimalWithCurrency(project.currentCosts, Currency.usd)}"),
    );
  }
}