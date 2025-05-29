import 'package:flutter/material.dart';
import '/core/widgets/icon_button.dart';
import '/config/constants/icons.dart';
import '/config/routes/route_name.dart';
import '../../../config/constants/colors.dart';

class ReservationsAppBar extends StatelessWidget {
  const ReservationsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120.0,
      pinned: false,
      floating: true,
      backgroundColor: AppColors.darkOrange,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Reservations',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ButtonWithIcon(
                icon: Image.asset(AppIcons.reservation, color: Colors.white, height: 15),
                title: 'Make reservation',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.makeReservation);
                },
                bgColor: Color(0xFF02966B),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
