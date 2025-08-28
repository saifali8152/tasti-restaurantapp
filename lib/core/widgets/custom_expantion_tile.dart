import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.all(0),
      childrenPadding: EdgeInsets.all(0),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      children: children,
    );
  }
}
