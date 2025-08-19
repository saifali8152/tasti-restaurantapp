import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/reservation_data_email.dart';
import '../../../../core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';

class CustomerReservationDetails extends StatelessWidget {
  final ReservationDataEmailEntity data;
  const CustomerReservationDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final status = data.statusDisplay.toLowerCase();
    final actionDate = data.actionDate;

    Color? bgColor;
    Color? textColor;
    String? displayText;

    if (status == "arrived") {
      bgColor = Colors.green.shade100;
      textColor = Colors.green.shade800;
      displayText = "The reservation is marked as Arrived at $actionDate";
    } else if (status == "no_show") {
      bgColor = Colors.red.shade100;
      textColor = Colors.red.shade800;
      displayText = "The reservation is marked as No Show at $actionDate";
    } else if (status == "cancelled") {
      bgColor = Colors.orange.shade100;
      textColor = Colors.orange.shade800;
      displayText = "The reservation is marked as Canceled at $actionDate";
    } else if (status == "pending") {
      bgColor = Colors.grey.shade100;
      textColor = Colors.grey.shade800;
      displayText = "The reservation is still Pending since $actionDate";
    }

    return Scaffold(
      appBar: CustomAppBar(title: 'Customer Reservation'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
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
            DetailsRow(title: 'Guest Name', value: data.name),
            DetailsRow(title: 'Party Size', value: data.guests.toString()),
            DetailsRow(title: 'Date & Time', value: data.formattedDateTime),
            DetailsRow(title: 'Time From', value: data.formattedStartTime),
            DetailsRow(title: 'Time To', value: data.formattedEndTime),
            DetailsRow(title: 'Notes', value: data.notes),
          ],
        ),
      ),
    );
  }
}
