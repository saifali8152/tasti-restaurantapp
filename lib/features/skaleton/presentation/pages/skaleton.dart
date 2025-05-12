import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/food_menu/food_menu.dart';
import '/features/restaurant_working_hours/restaurant_working_hours.dart';
import '/features/seating_area/seating_area.dart';
import '../../../customer_reservations/customer_reservations.dart';
import '../../../gallery/gallery.dart';
import '/config/constants/colors.dart';
import '/features/dashboard/dashboard_screen.dart';
import '/features/dashboard/widgets/custom_drawer.dart';
import '/features/manage_booking_time/manage_booking_time.dart';
import '/features/reservations/reservations.dart';
import '../../../../config/constants/icons.dart';
import '../../../../config/constants/spaces.dart';
import '../bloc/cubit/skaleton_cubit.dart';

class Skaleton extends StatelessWidget {
  const Skaleton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SkaletonCubit, SkaletonCubitState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.darkOrange,
          appBar: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 26),
                child: Image.asset(
                  AppIcons.noti,
                  height: AppSpaces.iconsHeight,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          drawer: CustomDrawer(),
          body: IndexedStack(
            index: state.index,
            children: const [
              DashboardScreen(),
              ReservationsScreen(),
              ManageBookingTimeScreen(),
              RestaurantWorkingHoursScreen(),
              SeatingAreaScreen(),
              Placeholder(),
              FoodMenuScreen(),
              GalleryScreen(),
              CustomerReservations(),
            ],
          ),
        );
      },
    );
  }
}
