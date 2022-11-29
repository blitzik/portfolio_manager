import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  final List<TextButton> children;

  const Menu({Key? key, required this.children}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: widget.children,
      ),
    );
  }
}
