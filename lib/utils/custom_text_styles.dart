import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

abstract class CustomTextStyles {
  static const TextStyle rowHeader = TextStyle(
    fontWeight: FontWeight.bold
  );

  static TextStyle decideNumberColor(Decimal number) {
    if (number < Decimal.zero) {
      return const TextStyle(color: Color(0xFFE74C3C), fontWeight: FontWeight.bold);
    }
    return const TextStyle(color: Color(0xFF27AE60), fontWeight: FontWeight.bold);
  }
}