import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DoubleFormFieldFactory {
  static final RegExp _doubleRegExp = RegExp(r'(0|[1-9][0-9]*)[,.]{0,1}[0-9]*');
  static final RegExp _precedingZeroesRegExp = RegExp(r'0{2,}[0-9]*.?');

  FormBuilderTextField create({
    required String name,
    required String labelText
  }) {
    return FormBuilderTextField(
      name: name,
      decoration: InputDecoration(
          labelText: labelText
      ),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(_doubleRegExp),
        TextInputFormatter.withFunction(
              (oldValue, newValue) => newValue.copyWith(
            text: newValue.text.replaceAll(',', '.'),
          ),
        ),
        TextInputFormatter.withFunction(
                (oldValue, newValue) {
              if (_precedingZeroesRegExp.hasMatch(newValue.text)) {
                return oldValue;
              }
              return newValue;
            }
        ),
      ],
    );
  }
}