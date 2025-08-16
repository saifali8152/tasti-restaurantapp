import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/entities/reservation.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/card_details_row.dart';
import '../../../../core/widgets/custom_button.dart';

class RevervationCard extends StatelessWidget {
  final ReservationItem reservation;
  const RevervationCard({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withSafeOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                reservation.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  if (reservation.hasSpecialNotes)
                    const Icon(Icons.message, color: Colors.red, size: 18),
                  IconButton(
                    icon: const Icon(Icons.open_in_new, size: 18),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          CardDetailsRow(
              label: 'Time From', value: reservation.formattedStartTime),
          CardDetailsRow(label: 'Time To', value: reservation.formattedEndTime),
          CardDetailsRow(
              label: 'Party Size', value: reservation.guests.toString()),
          CardDetailsRow(label: 'Seating Area', value: reservation.notes),
          SizedBox(height: 5),
          const Divider(),
          if (reservation.waiter.isNotEmpty)
            CardDetailsRow(label: 'Waiter', value: reservation.waiter),
          SizedBox(height: 5),
          if (reservation.waiter.isEmpty)
            Center(
              child: CustomButton(
                onPressed: () {},
                text: "Assign Waiter",
                isFullWidth: false,
              ),
            ),
        ],
      ),
    );
  }
}
