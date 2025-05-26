import 'package:flutter/material.dart';

class HeaderCell extends StatelessWidget {
  final String label;
  const HeaderCell(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}