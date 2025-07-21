import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '/features/screens.dart';
import '/config/routes/route_name.dart';
import '../../../config/constants/icons.dart';
import '../../../config/constants/spaces.dart';
import '/config/constants/colors.dart';
import '../cubit/skaleton_cubit.dart';


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
            children: DrawerScreens.drawerItemsForRole('admin'),
          ),
        );
      },
    );
  }
}

class DrawerScreens {
  static List<Widget> drawerItemsForRole(String role) {
    switch (role.toLowerCase()) {
      case "admin":
        return [
          AdminDashboardScreen(),
          Restaurants(),
          TodayRequests(),
          TodayQueries(),
          Placeholder(),
          Placeholder(),
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
