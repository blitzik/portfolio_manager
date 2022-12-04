import 'package:flutter/services.dart';

class DecimalsFormatter extends TextInputFormatter {
  late final RegExp _doubleNumberRegExp;
  late final RegExp _noDigitsButDecimals;
  late final RegExp _leadingZeroesRegExp;

  final bool allowNegative;

  DecimalsFormatter({this.allowNegative = true}) {
    _doubleNumberRegExp = RegExp('^${allowNegative ? '-?' : ''}(0|[1-9][0-9]*)[,.]{0,1}[0-9]*\$');
    _noDigitsButDecimals = RegExp('^${allowNegative ? '-?' : ''}\\.[0-9]+\$');
    _leadingZeroesRegExp = RegExp('^${allowNegative ? '-?' : ''}00+\\.?[0-9]*\$');
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newFieldValue = newValue.text.replaceAll(',', '.');
    if (newFieldValue.isEmpty) {
      return newValue;
    }

    if (newFieldValue == '-') {
      return const TextEditingValue(text: '');
    }

    if (_leadingZeroesRegExp.hasMatch(newFieldValue)) {
      newFieldValue = double.parse(newFieldValue).toString();
      return TextEditingValue(text: newFieldValue, selection: TextSelection.collapsed(offset: newFieldValue.length));
    }

    if (_noDigitsButDecimals.hasMatch(newFieldValue)) {
      bool containsSign = false;
      if (allowNegative && newFieldValue.contains('-')) {
        containsSign = true;
        newFieldValue = newFieldValue.replaceFirst('-', '-0');
      } else {
        newFieldValue = '0$newFieldValue';
      }
      return TextEditingValue(text: newFieldValue, selection: TextSelection.collapsed(offset: containsSign ? 3 : 2));
    }

    if (!_doubleNumberRegExp.hasMatch(newValue.text)) {
      return oldValue;
    }

    return TextEditingValue(text: newFieldValue, selection: newValue.selection);
  }
}