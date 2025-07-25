import 'package:flutter/material.dart';

class BadgeLabel extends StatelessWidget {
  final String label;
  final String value;
  final Color bgColor;
  final Color textColor;

  const BadgeLabel({super.key, 
    required this.label,
    required this.value,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            value,
            style: TextStyle(color: textColor, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
