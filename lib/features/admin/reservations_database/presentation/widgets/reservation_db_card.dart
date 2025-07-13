import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/features/admin/reservations_database/domain/entities/reservation.dart';
import '/config/routes/route_name.dart';
import '/config/constants/colors.dart';

class ReservationsDBCard extends StatelessWidget {
  final AdminReservationItem item;
  const ReservationsDBCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.reservationDbDetails, extra: item),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: .5,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.restaurantName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Icon(Icons.open_in_new, size: 16),
                ],
              ),
              SizedBox(height: 12),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reservation Time',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  Text(
                    item.reservationTimeFormatted,
                    style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                  ),
                ],
              ),
              SizedBox(height: 12),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Number of Guests',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  Text(
                    item.numGuests.toString(),
                    style: TextStyle(fontSize: 14, color: AppColors.darkOrange, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
