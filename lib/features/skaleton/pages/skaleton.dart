import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/enum/query_type.dart';
import '/core/enum/request_type.dart';
import '/dependency_injection.dart';
import '/features/admin/campaigns/presentation/pages/campaigns.dart';
import '/features/admin/events/presentation/pages/events.dart';
import '/features/admin/profile/presentation/pages/profile.dart';
import '/features/admin/queries/presentation/bloc/queries_bloc.dart';
import '/features/admin/queries/presentation/bloc/queries_event.dart';
import '/features/admin/requests/presentation/bloc/request_bloc.dart';
import '/features/admin/requests/presentation/bloc/request_event.dart';
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
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.notifications);
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
          AdminDashboardScreen(), // 0
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
              ..add(FetchInitialRequests(type: RequestType.todayRequests)),
            child: Requests(type: RequestType.monthlyRequests),
          ),
          BlocProvider(
            create: (_) => sl<QueriesBloc>()
              ..add(FetchInitialQueries(type: QueryType.monthlyQueries)),
            child: Queries(type: QueryType.monthlyQueries),
          ),

          BlocProvider(
            create: (_) => sl<RequestBloc>()
              ..add(FetchInitialRequests(type: RequestType.todayRequests)),
            child: Requests(type: RequestType.overallRequests),
          ),
          BlocProvider(
            create: (_) => sl<QueriesBloc>()
              ..add(FetchInitialQueries(type: QueryType.overallQueries)),
            child: Queries(type: QueryType.overallQueries),
          ),

          ReservationsDatabase(), // 8
          Events(), // 9
          ManageSMS(), // 10
          MarketingCampain(), // 11
          Settings(), // 12 ✅ Settings screen here
          ProfileScreen(), // 13 ✅ Profile screen here
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
          ProfileScreen(),
        ];
    }
  }
}
