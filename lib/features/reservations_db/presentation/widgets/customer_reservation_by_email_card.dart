import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/reservation_data_email.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/card_details_row.dart';

class CustomerReservationByEmailCard extends StatelessWidget {
  final ReservationDataEmailEntity data;
  const CustomerReservationByEmailCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.customerReservationDetails, arguments: data);
      },
      child: Container(
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
            CardDetailsRow(label: 'Name', value: data.name),
            CardDetailsRow(label: 'Email', value: "data.email"),
            CardDetailsRow(label: 'Number of people', value: data.reservation.toString()),
            CardDetailsRow(label: 'Time', value: data.formattedEndTime),
            // Custom price row
          ],
        ),
      ),
    );
  }
}
