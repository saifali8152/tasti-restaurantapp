import 'package:flutter/material.dart';

class CardDetailsRow extends StatelessWidget {
  final String label;
  final String value;
  final int flex;
  const CardDetailsRow({
    required this.label,
    required this.value,
    this.flex = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
          SizedBox(width: 10),
          Expanded(
            flex: flex,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
