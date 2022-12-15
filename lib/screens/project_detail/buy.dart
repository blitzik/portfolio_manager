import 'package:flutter/material.dart';
import 'package:portfolio_manager/domain/transaction.dart';
import 'package:portfolio_manager/extensions/string_extension.dart';
import 'package:portfolio_manager/utils/custom_text_styles.dart';
import 'package:portfolio_manager/widgets/date.dart';

class Buy extends StatelessWidget {
  final Transaction transaction;

  const Buy({Key? key, required this.transaction}) : super(key: key);

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
                  const Text('Amount bought', style: CustomTextStyles.rowHeader),
                  Text('${transaction.amount}')
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Cost basis', style: CustomTextStyles.rowHeader),
                  Text('${transaction.costs}')
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Price per unit', style: CustomTextStyles.rowHeader),
                  Text('${transaction.pricePerUnit}')
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(''),
                  Text('')
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Fiat Fee', style: CustomTextStyles.rowHeader),
                  Text('${transaction.fiatFee}')
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Fee', style: CustomTextStyles.rowHeader),
                  Text('${transaction.fee}')
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
