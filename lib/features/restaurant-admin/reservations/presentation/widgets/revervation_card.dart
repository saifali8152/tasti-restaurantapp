import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations/presentation/widgets/status_chip.dart';
import '/config/routes/route_name.dart';
import '/core/services/launcher_services.dart';
import '/features/restaurant-admin/reservations/domain/entities/reservation.dart';
import '/features/restaurant-admin/reservations/presentation/widgets/add_update_waiter.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/card_details_row.dart';
import '../../../../../core/widgets/custom_button.dart';

class RevervationCard extends StatelessWidget {
  final ReservationItem reservation;
  final int restaurantId;
  final String date;
  const RevervationCard(
      {super.key,
      required this.reservation,
      required this.restaurantId,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.reservationDetails,
          arguments: reservation,
        );
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
            Row(
              children: [
                Text(
                  reservation.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5),
                if (reservation.isConfirmed)
                  const Icon(Icons.thumb_up, color: Colors.green, size: 15),
                Spacer(),
                Row(
                  children: [
                    if (reservation.hasSpecialNotes)
                      const Icon(Icons.message, color: Colors.red, size: 18),
                    IconButton(
                      icon: const Icon(Icons.open_in_new, size: 18),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.reservationDetails,
                          arguments: reservation,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    UrlLauncherService().callPhoneNumber(reservation.phone);
                  },
                  child: Text(
                    reservation.phone,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            CardDetailsRow(
                label: 'Time From', value: reservation.formattedStartTime),
            CardDetailsRow(
                label: 'Time To', value: reservation.formattedEndTime),
            CardDetailsRow(
                label: 'Party Size', value: reservation.guests.toString()),
            CardDetailsRow(label: 'Seating Area', value: reservation.notes),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status',
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
                ReservationStatusChip(status: reservation.statusDisplay),
              ],
            ),
            SizedBox(height: 5),
            const Divider(),
            if (reservation.waiter.isNotEmpty)
              CardDetailsRow(label: 'Waiter', value: reservation.waiter),
            SizedBox(height: 5),
            if (reservation.statusDisplay == "pending")
              Center(
                child: CustomButton(
                  onPressed: () {
                    context.showCustomDialog(AddUpdateWaiterDialog(
                      waiter: reservation.waiter,
                      reservationId: reservation.id,
                      restaurantId: restaurantId,
                      date: date,
                    ));
                  },
                  text: reservation.waiter.isEmpty
                      ? "Assign Waiter"
                      : "Update Waiter",
                  isFullWidth: false,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
