import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Date extends StatelessWidget {
  final DateTime date;
  final DateFormat defaultDateFormat = DateFormat('y/MM/dd HH:mm');
  final DateFormat? dateFormat;

  Date({
    Key? key,
    required this.date,
    this.dateFormat
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(_getFormattedDate(date));
  }

  String _getFormattedDate(DateTime date) {
    if (dateFormat == null) {
      return defaultDateFormat.format(date);
    }
    return dateFormat!.format(date);
  }
}