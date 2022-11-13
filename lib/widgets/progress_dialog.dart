import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final String text;

  const ProgressDialog({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(20),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text),
            const SizedBox(height: 15.0,),
            const CircularProgressIndicator()
          ],
        )
      ],
    );
  }
}
