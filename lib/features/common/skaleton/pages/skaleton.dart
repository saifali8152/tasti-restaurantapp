import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/presentation/pages/admin_users.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/pages/restaurant_users.dart';
import '/core/services/session_controller.dart';
import '/features/restaurant-admin/bundle_billings/presentation/pages/bundle_billings.dart';
import '/features/restaurant-admin/create_new_restaurant/presentation/pages/update_new_restaurant.dart';
import '/features/restaurant-admin/dashboard/presentation/pages/dashboard_screen.dart';
import '/features/restaurant-admin/working_hours/presentation/pages/restaurant_working_hours.dart';
import '/core/enum/query_type.dart';
import '/core/enum/request_type.dart';
import '/dependency_injection.dart';
import '/features/admin/campaigns/presentation/pages/campaigns.dart';
import '/features/admin/events/presentation/pages/events.dart';
import '../../profile/presentation/pages/profile.dart';
import '/features/admin/queries/presentation/bloc/queries_bloc.dart';
import '/features/admin/queries/presentation/bloc/queries_event.dart';
import '/features/admin/requests/presentation/bloc/request_bloc.dart';
import '/features/admin/requests/presentation/bloc/request_event.dart';
import '/features/screens.dart';
// import '/config/routes/route_name.dart';
// import '../../../../config/constants/icons.dart';
// import '../../../../config/constants/spaces.dart';
import '/config/constants/colors.dart';
import '../cubit/skaleton_cubit.dart';

class Skaleton extends StatelessWidget {
  const Skaleton({super.key});

  @override
  Widget build(BuildContext context) {
    final userRole = SessionController().user?.type.toLowerCase() == 'admin'
        ? 'admin'
        : 'restaurant';
    final items = DrawerScreens.drawerItemsForRole(userRole);

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
            // actions: [
              // Padding(
              //   padding: const EdgeInsets.only(right: 26),
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.pushNamed(context, AppRoutes.notifications);
              //     },
              //     child: Image.asset(
              //       AppIcons.noti,
              //       height: AppSpaces.iconsHeight,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            // ],
          ),
          drawer: CustomDrawer(
            userRole: userRole,
          ),
          body: IndexedStack(
            index: state.index,
            children: items,
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
          BlocProvider(
            create: (_) => sl<RequestBloc>()
              ..add(FetchInitialRequests(type: RequestType.todayRequests)),
            child: Requests(type: RequestType.todayRequests),
          ),
          BlocProvider(
            create: (_) => sl<QueriesBloc>()
              ..add(FetchInitialQueries(type: QueryType.todayQueries)),
            child: Queries(type: QueryType.todayQueries),
          ),
          BlocProvider(
            create: (_) => sl<RequestBloc>()
              ..add(FetchInitialRequests(type: RequestType.monthlyRequests)),
            child: Requests(type: RequestType.monthlyRequests),
          ),
          BlocProvider(
            create: (_) => sl<QueriesBloc>()
              ..add(FetchInitialQueries(type: QueryType.monthlyQueries)),
            child: Queries(type: QueryType.monthlyQueries),
          ),
          BlocProvider(
            create: (_) => sl<RequestBloc>()
              ..add(FetchInitialRequests(type: RequestType.overallRequests)),
            child: Requests(type: RequestType.overallRequests),
          ),
          BlocProvider(
            create: (_) => sl<QueriesBloc>()
              ..add(FetchInitialQueries(type: QueryType.overallQueries)),
            child: Queries(type: QueryType.overallQueries),
          ),
          ReservationsDatabase(),
          Events(),
          ManageSMS(),
          MarketingCampain(),
          AdminUserScreen(),
          ProfileScreen(),
        ];
      case "restaurant":
      default:
        return [
          DashboardScreen(),
          ReservationsScreen(),
          ManageBookingTimeScreen(),
          RestaurantWorkingHoursScreen(),
          SeatingAreaScreen(),
          CuisinesScreen(),
          FoodMenuScreen(),
          GalleryScreen(),
          CustomerReservations(),
          ReviewsScreen(),
          BundleBillingsScreen(),
          UpdateNewRestaurant(),
          ShareLinksScreen(),
          RestaurantUserScreen(),
          ProfileScreen(),
        ];
    }
  }
}