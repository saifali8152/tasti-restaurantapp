import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import '/features/admin/campaign/campaign.dart';
import '/features/admin/manage_sms/manage_sms.dart';
import '/features/admin/queries/queries.dart';
import '/features/admin/requests/requests.dart';
import '/features/admin/reservations_database/reservations_database.dart';
import '/features/admin/restaurants/restaurants.dart';
import '/features/admin/today_queries/today_queries.dart';
import '/features/admin/today_requests/today_requests.dart';
import '../../../admin/dashboard/dashboard_screen.dart';
import '/features/add_cuisines/add_cuisines.dart';
import '/features/reviews/reviews.dart';
import '/features/settings/settings.dart';
import '/features/share/share.dart';
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
                child: GestureDetector(
                  onTap: (){
                    context.push(AppRoutes.notifications);
                  },
                  child: Image.asset(
                    AppIcons.noti,
                    height: AppSpaces.iconsHeight,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          drawer: CustomDrawer(
            userRole: "admin",
          ),
          body: IndexedStack(
            index: state.index,
            children: DrawerConfig.drawerItemsForRole('admin'),
          ),
        );
      },
    );
  }
}

class DrawerConfig {
  static List<Widget> drawerItemsForRole(String role) {
    switch (role.toLowerCase()) {
      case "admin":
        return [
          AdminDashboardScreen(),
          Restaurants(),
          TodayRequests(),
          TodayQueries(),
          Requests(),
          Queries(),
          ReservationsDatabase(),
          ManageSMS(),
          MarketingCampain()
        ];
      case "restaurant":
      default:
        return [
          DashboardScreen(),
          ReservationsScreen(),
          ManageBookingTimeScreen(),
          RestaurantWorkingHoursScreen(),
          SeatingAreaScreen(),
          AddCuisinesScreen(),
          FoodMenuScreen(),
          GalleryScreen(),
          CustomerReservations(),
          ReviewsScreen(),
          Text("Bundles and Billings"),
          Settings(),
          ShareLinksScreen(),
        ];
    }
  }
}
