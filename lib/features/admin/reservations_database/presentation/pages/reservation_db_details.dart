import 'package:flutter/material.dart';
import '/features/admin/reservations_database/domain/entities/reservation.dart';
import '/core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';

class ReservationDbDetails extends StatelessWidget {
  final AdminReservationItem item;
  const ReservationDbDetails({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Reservation Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DetailsRow(title: "Restaurant", value: item.restaurantName.toString()),
            DetailsRow(title: "Guest Name", value: item.guestName.toString()),
            DetailsRow(title: "Phone Number", value: item.phone.toString()),
            DetailsRow(title: "Email", value: item.email.toString()),
            DetailsRow(title: "Number of Guests", value: item.numGuests.toString()),
            DetailsRow(title: "Reservation Time", value: item.reservationTimeFormatted),
          ],
        ),
      ),
    );
  }
}
