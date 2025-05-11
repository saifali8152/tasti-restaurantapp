import 'package:flutter/material.dart';

class HeaderCell extends StatelessWidget {
  final String label;
  final int flex;
  const HeaderCell(this.label, {super.key, this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}