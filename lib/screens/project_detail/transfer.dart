import 'package:flutter/material.dart';
import 'package:portfolio_manager/domain/transaction.dart';
import 'package:portfolio_manager/extensions/string_extension.dart';
import 'package:portfolio_manager/utils/custom_text_styles.dart';
import 'package:portfolio_manager/widgets/date.dart';
import 'package:portfolio_manager/widgets/money_usd.dart';

class Transfer extends StatelessWidget {
  final Transaction transaction;

  const Transfer({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
                width: 120.0,
                child: Date(date: transaction.date)
            ),
            Text(transaction.type.name.capitalize())
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Amount transferred', style: CustomTextStyles.rowHeader,),
                  Text('${transaction.amount}')
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Value', style: CustomTextStyles.rowHeader,),
                  MoneyUsd(transaction.value)
                  //Text('${NumberFormatter.formatDecimal(transaction.realizedPnl)}', style: CustomTextStyles.decideNumberColor(transaction.realizedPnl),)
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Fee', style: CustomTextStyles.rowHeader,),
                  Text('${transaction.fee}')
                ],
              ),
            ),
          ],
        ),Row(
          children: [
            const Expanded(
              child: SizedBox()
            ),
            const Expanded(
              child: SizedBox()
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Fiat Fee', style: CustomTextStyles.rowHeader,),
                  MoneyUsd(transaction.fiatFee)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
