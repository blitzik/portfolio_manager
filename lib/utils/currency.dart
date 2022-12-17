import 'package:money2/money2.dart' as m2;

abstract class Currency {
  static final m2.Currency usd = m2.Currency.create('USD', 2, symbol: '\$', pattern: 'S#,##0.00');
}