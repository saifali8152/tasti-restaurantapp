import 'package:flutter/material.dart';

class ReservationStatusChip extends StatelessWidget {
  final String status;
  final String? actionDate; // optional for details page

  const ReservationStatusChip({super.key, required this.status, this.actionDate});

  @override
  Widget build(BuildContext context) {
    final s = status.toLowerCase();

    Color bgColor;
    Color textColor;
    String displayText;

    switch (s) {
      case "arrived":
        bgColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        displayText = "Arrived";
        break;
      case "no_show":
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        displayText = "No Show";
        break;
      case "cancelled":
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        displayText = "Canceled";
        break;
      default:
        bgColor = Colors.grey.shade200;
        textColor = Colors.grey.shade700;
        displayText = status.toUpperCase();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        actionDate != null
            ? "The reservation is marked as $displayText at $actionDate"
            : displayText,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: actionDate != null ? 14 : 12,
        ),
      ),
    );
  }
}
