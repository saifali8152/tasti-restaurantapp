import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/entities/reservation.dart';
import '/core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';

class ReservationDetails extends StatelessWidget {
  final ReservationItem reservation;
  const ReservationDetails({super.key, required this.reservation});

  String formatStatus(String status) {
    switch (status.toLowerCase()) {
      case "arrived":
        return "Arrived";
      case "no_show":
        return "No Show";
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = reservation.statusDisplay.toLowerCase();
    final actionDate = reservation.actionDate;

    Color? bgColor;
    Color? textColor;
    String? displayText;

    if (status == "arrived") {
      bgColor = Colors.green.shade100;
      textColor = Colors.green.shade800;
      displayText =
          "The reservation is marked as Arrived at $actionDate";
    } else if (status == "no_show") {
      bgColor = Colors.red.shade100;
      textColor = Colors.red.shade800;
      displayText =
          "The reservation is marked as No Show at $actionDate";
    }

    return Scaffold(
      appBar: CustomAppBar(title: 'Reservation Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Show banner only if status is Arrived / No Show
            if (displayText != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  displayText,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],

            // ✅ Then show details
            DetailsRow(title: 'Guest Name', value: reservation.name),
            DetailsRow(title: 'Party Size', value: reservation.guests.toString()),
            DetailsRow(title: 'Time From', value: reservation.formattedStartTime),
            DetailsRow(title: 'Time To', value: reservation.formattedEndTime),
            DetailsRow(title: 'Seating Area', value: reservation.notes),

            if (reservation.hasSpecialNotes != false) ...[
              const SizedBox(height: 15),
              const Text(
                "Special Request",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              DetailsRow(title: 'Dietary Requirements', value: reservation.dietary),
              DetailsRow(title: 'Special Occasion', value: reservation.occasion),
              DetailsRow(title: 'Waiting Preferences', value: reservation.request),
              const SizedBox(height: 5),
            ]
          ],
        ),
      ),
    );
  }
}
