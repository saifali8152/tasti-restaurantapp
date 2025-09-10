import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/presentation/pages/admin_users.dart';
import 'package:tasti_restaurant_app/features/admin/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/presentation/pages/manage_sms_bundle.dart';
import 'package:tasti_restaurant_app/features/admin/queries/presentation/pages/queries.dart';
import 'package:tasti_restaurant_app/features/admin/requests/presentation/pages/requests.dart';
import 'package:tasti_restaurant_app/features/admin/reservations_database/presentation/pages/reservations_database.dart';
import 'package:tasti_restaurant_app/features/admin/restaurants/presentation/pages/restaurants.dart';
import 'package:tasti_restaurant_app/features/common/auth/domain/entities/user.dart';
import 'package:tasti_restaurant_app/features/common/faqs_chat/faq_chat.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/presentation/pages/cuisines.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/food_menu/presentation/pages/food_menu.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/presentation/pages/gallery.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/presentation/pages/manage_booking_time.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations/presentation/pages/reservations.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/presentation/pages/customer_reservations.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/pages/restaurant_users.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/presentation/pages/reviews.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/seating_area/presentation/pages/seating_area.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/share/share.dart';
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


class DrawerScreens {
  // Updated permission keys to match API response
  static const String adminStatsPermission = 'stats';
  static const String restaurantsPermission = 'restaurants';
  static const String maintainMorePermission = 'maintainMore';
  static const String eventsPermission = 'events';
  static const String smsManagementPermission = 'manageSmsFee';
  static const String campaignsPermission = 'campaigns';

  // Restaurant permission keys
  static const String restaurantStatsPermission = 'stats';
  static const String reservationsPermission = 'reservations';
  static const String availabilityPermission = 'restaurantSetup';
  static const String reservationDatabasePermission = 'reservationDatabase';
  static const String maintainReviewsPermission = 'maintainReviews';
  static const String bundleBillingsPermission = 'bundleAndBillings';
  static const String restaurantSettingsPermission = 'restaurantProfile';
  static const String shareWidgetPermission = 'shareWidget';

  static List<Widget> drawerItemsForRole(
    String role, {
    List<PermissionEntity>? userPermissions,
  }) {
    final shouldCheckPermissions = userPermissions != null;
    final permissionKeys = shouldCheckPermissions 
        ? userPermissions.map((p) => p.key).toSet()
        : <String>{};

    bool hasPermission(String permissionKey) {
      return !shouldCheckPermissions || permissionKeys.contains(permissionKey);
    }

    switch (role.toLowerCase()) {
      case "admin":
        final List<Widget> adminScreens = [];
        
        // Admin Stats
        if (hasPermission(adminStatsPermission)) {
          adminScreens.add(AdminDashboardScreen());
        }
        
        // Restaurants
        if (hasPermission(restaurantsPermission)) {
          adminScreens.add(Restaurants());
        }
        
        // Maintain More section - if user has maintainMore permission, add all related screens
        if (hasPermission(maintainMorePermission)) {
          adminScreens.addAll([
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
          ]);
        }
        
        // Events
        if (hasPermission(eventsPermission)) {
          adminScreens.add(Events());
        }
        
        // SMS Management
        if (hasPermission(smsManagementPermission)) {
          adminScreens.add(ManageSMS());
        }
        
        // Marketing Campaign
        if (hasPermission(campaignsPermission)) {
          adminScreens.add(MarketingCampain());
        }
        
        // Admin Users - only for main admin, not admin_user
        if (!shouldCheckPermissions) {
          adminScreens.add(AdminUserScreen());
        }
        
        // Profile - always available
        adminScreens.add(ProfileScreen());
        
        adminScreens.add(FAQChatScreen());
        
        return adminScreens;

      case "restaurant":
      default:
        final List<Widget> restaurantScreens = [];
        
        // Restaurant Stats
        if (hasPermission(restaurantStatsPermission)) {
          restaurantScreens.add(DashboardScreen());
        }
        
        // Reservations
        if (hasPermission(reservationsPermission)) {
          restaurantScreens.add(ReservationsScreen());
        }
        
        // Availability section - if user has availability permission, add all related screens
        if (hasPermission(availabilityPermission)) {
          restaurantScreens.addAll([
            ManageBookingTimeScreen(),
            RestaurantWorkingHoursScreen(),
            SeatingAreaScreen(),
            CuisinesScreen(),
            FoodMenuScreen(),
            GalleryScreen(),
          ]);
        }
        
        // Reservation Database
        if (hasPermission(reservationDatabasePermission)) {
          restaurantScreens.add(CustomerReservations());
        }
        
        // Maintain Reviews
        if (hasPermission(maintainReviewsPermission)) {
          restaurantScreens.add(ReviewsScreen());
        }
        
        // Bundle Billings
        if (hasPermission(bundleBillingsPermission)) {
          restaurantScreens.add(BundleBillingsScreen());
        }
        
        // Restaurant Settings
        if (hasPermission(restaurantSettingsPermission)) {
          restaurantScreens.add(UpdateNewRestaurant());
        }
        
        // Share Widget
        if (hasPermission(shareWidgetPermission)) {
          restaurantScreens.add(ShareLinksScreen());
        }
        
        // Restaurant Users - only for main restaurant, not restaurant_user
        if (!shouldCheckPermissions) {
          restaurantScreens.add(RestaurantUserScreen());
        }
        
        // Profile - always available
        restaurantScreens.add(ProfileScreen());

        restaurantScreens.add(FAQChatScreen());
        
        return restaurantScreens;
    }
  }
}