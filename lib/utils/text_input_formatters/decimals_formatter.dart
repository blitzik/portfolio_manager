import 'package:flutter/services.dart';

class DecimalsFormatter extends TextInputFormatter {
  static final _doubleNumberRegExp = RegExp(r'^(0|[1-9][0-9]*)[,.]{0,1}[0-9]*$');
  static final _noDigitsButDecimals = RegExp(r'^\.[0-9]+$');
  static final _leadingZeroesRegExp = RegExp(r'^00+\.?[0-9]*$');
  static final _zeroesRegExp = RegExp(r'^\.?00+$');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newFieldValue = newValue.text.replaceAll(',', '.');
    if (newFieldValue.isEmpty) {
      return const TextEditingValue(text: '');
    }

    if (_zeroesRegExp.hasMatch(newFieldValue)) {
      return const TextEditingValue(text: '0', selection: TextSelection.collapsed(offset: 1));
    }

    if (_leadingZeroesRegExp.hasMatch(newFieldValue)) {
      newFieldValue = double.parse(newFieldValue).toString();
      return TextEditingValue(text: newFieldValue, selection: TextSelection.collapsed(offset: newFieldValue.length));
    }

    if (_noDigitsButDecimals.hasMatch(newFieldValue)) {
      return TextEditingValue(text: '0$newFieldValue', selection: const TextSelection.collapsed(offset: 2));
    }

    if (!_doubleNumberRegExp.hasMatch(newValue.text)) {
      return oldValue;
    }

    return TextEditingValue(text: newFieldValue, selection: newValue.selection);
  }
}