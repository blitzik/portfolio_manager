import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart' as m2;
import 'package:portfolio_manager/utils/currency.dart';
import 'package:portfolio_manager/utils/custom_text_styles.dart';

class MoneyUsd extends StatelessWidget {
  final Decimal value;
  final bool isColored;

  const MoneyUsd(
    this.value,
  {
    Key? key,
    this.isColored = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    m2.Money m = m2.Money.fromDecimalWithCurrency(value, Currency.usd);
    return Text(
      m.toString(),
      style: isColored ? CustomTextStyles.decideNumberColor(value) : null ,
    );
  }
}