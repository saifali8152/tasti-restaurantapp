import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/widgets/curved_container.dart';
import 'package:tasti_restaurant_app/core/widgets/themed_app_bar.dart';
import '../../config/constants/icons.dart';
import '../../config/routes/route_name.dart';
import '../../core/widgets/icon_button.dart';
import '/features/reservations/widgets/date_picker.dart';
import '/features/reservations/widgets/revervation_card.dart';
import '/config/constants/colors.dart';

class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 150,
        title: "Reservation",
        subTitle: ButtonWithIcon(
          icon: Image.asset(AppIcons.reservation,
              color: Colors.white, height: 15),
          title: 'Make reservation',
          onTap: () {
            Navigator.pushNamed(context, RoutesName.makeReservation);
          },
          bgColor: Color(0xFF02966B),
        ),
      ),
      body: CurvedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.bookmark, color: Colors.deepOrange),
                      SizedBox(width: 8),
                      Text(
                        'Total Bookings: ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '12',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(Icons.people, color: AppColors.darkOrange),
                      SizedBox(width: 8),
                      Text(
                        'Total Pax: ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '3',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ReservationsDatePicker(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: 3,
                itemBuilder: (_, index) => RevervationCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
