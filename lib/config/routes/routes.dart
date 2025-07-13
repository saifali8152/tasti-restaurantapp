import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/features/admin/reservations_database/domain/entities/reservation.dart';
import '/features/admin/manage_sms/add_sms_bundle.dart';
import '../../features/screens.dart';
import 'route_name.dart';

import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: AppRoutes.splash,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: AppRoutes.addSmsBundle,
      builder: (context, state) => const AddSMSBundle(),
    ),
    GoRoute(
      path: AppRoutes.transactionHistory,
      builder: (context, state) => const TransactionHistory(),
    ),
    GoRoute(
      path: AppRoutes.smsBundleDetails,
      builder: (context, state) => const SmsBundleDetails(),
    ),
    GoRoute(
      path: AppRoutes.queryDetails,
      builder: (context, state) => const QueryDetails(),
    ),
    GoRoute(
      path: AppRoutes.reservationDbDetails,
      builder: (context, state) => ReservationDbDetails(item: state.extra as AdminReservationItem),
    ),
    GoRoute(
      path: AppRoutes.restaurantDetails,
      builder: (context, state) => const RestaurantDetails(),
    ),
    GoRoute(
      path: AppRoutes.requestDetails,
      builder: (context, state) => const RequestDetails(),
    ),
    GoRoute(
      path: AppRoutes.notifications,
      builder: (context, state) => const Notifications(),
    ),
    GoRoute(
      path: AppRoutes.campaignDetails,
      builder: (context, state) => const CampaignDetails(),
    ),
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: Text("Forgot Password")),
      ),
    ),
    GoRoute(
      path: AppRoutes.signup,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => OnboardingScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return Skaleton();
      },
      routes: [
        GoRoute(
          path: AppRoutes.stats,
          builder: (context, state) => DashboardScreen(),
        ),
        GoRoute(
          path: AppRoutes.billings,
          builder: (context, state) => const Text("Bundle and billings"),
        ),
        GoRoute(
          path: AppRoutes.makeReservation,
          builder: (context, state) => MakeReservationScreen(),
        ),
        GoRoute(
            path: AppRoutes.workingHours,
            builder: (context, state) => const RestaurantWorkingHoursScreen()),
        GoRoute(
          path: AppRoutes.manageBookingTime,
          builder: (context, state) => const ManageBookingTimeScreen(),
        ),
        GoRoute(
          path: AppRoutes.timeSlotManagement,
          builder: (context, state) => const TimeSlotManagementScreen(),
        ),
        GoRoute(
          path: AppRoutes.inactiveTimeSlots,
          builder: (context, state) => const InactiveSlotsScreen(),
        ),
        GoRoute(
          path: AppRoutes.updateTimeDuration,
          builder: (context, state) => const UpdateTimeDurationScreen(),
        ),
        GoRoute(
          path: AppRoutes.reservations,
          builder: (context, state) => const ReservationsScreen(),
        ),
        GoRoute(
            path: AppRoutes.settings,
            builder: (context, state) => const Settings(),
            routes: [
              GoRoute(
                path: AppRoutes.setVanueCategory,
                builder: (context, state) => const SetVanueCategory(),
              ),
            ]),
        GoRoute(
          path: AppRoutes.share,
          builder: (context, state) => const ShareLinksScreen(),
        ),
        GoRoute(
          path: AppRoutes.campaignSummary,
          builder: (context, state) => const CampaignSummary(),
        ),
        GoRoute(
          path: AppRoutes.targetedCampaign,
          builder: (context, state) => const TargetedCampaign(),
        ),
        GoRoute(
          path: AppRoutes.customerReservationDetails,
          builder: (context, state) => const CustomerReservationDetails(),
        ),
        GoRoute(
          path: AppRoutes.addPhotos,
          builder: (context, state) => const AddPhotosScreen(),
        ),
        GoRoute(
          path: AppRoutes.settingAreaDetails,
          builder: (context, state) => const SeatingAreaDetails(),
        ),
        GoRoute(
          path: AppRoutes.restaurantQRFoodMenu,
          builder: (context, state) => const RestaurantQrFoodMenu(),
        ),
        GoRoute(
          path: AppRoutes.skaleton,
          builder: (context, state) => const Skaleton(),
        ),
      ],
    ),
  ],
);
