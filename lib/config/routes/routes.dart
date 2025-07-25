import 'package:flutter/material.dart';
import '/features/admin/campaigns/domain/entities/campaigns_by_res.dart';
import '/features/admin/campaigns/presentation/pages/campaigns_by_res.dart';
import '/features/admin/events/domain/entities/event.dart';
import '/features/admin/events/presentation/pages/add_event.dart';
import '/features/admin/events/presentation/pages/update_event.dart';
import '/features/admin/manage_fee/presentation/pages/update_monthly_fee.dart';
import '/features/admin/manage_fee/presentation/pages/monthly_fee.dart';
import '/features/admin/manage_sms/domain/entities/admin_sms.dart';
import '/features/admin/manage_sms/presentation/pages/manage_sms_bundle_discount.dart';
import '/features/admin/manage_sms/presentation/pages/add_sms_bundle.dart';
import '/features/admin/profile/presentation/pages/change_password.dart';
import '/features/admin/profile/presentation/pages/personal_info.dart';
import '/features/admin/queries/domain/entities/queries.dart';
import '/features/admin/reservations_database/domain/entities/reservation.dart';
import '/features/admin/transaction_history/presentation/pages/transaction_history.dart';
import '/features/screens.dart';
import 'route_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.addSmsBundle:
        return MaterialPageRoute(builder: (_) => const AddSMSBundle());
      case AppRoutes.addEvent:
        return MaterialPageRoute(builder: (_) => const AddEventScreen());
      case AppRoutes.updateEvent:
        return MaterialPageRoute(builder: (_) => UpdateEventScreen(
          event: settings.arguments as EventItem,
        ));
      case AppRoutes.transactionHistory:
        return MaterialPageRoute(builder: (_) => const TransactionHistory());
      case AppRoutes.smsBundleDetails:
        return MaterialPageRoute(
          builder: (_) => SmsBundleDetails(item: settings.arguments as AdminSmsItem),
        );
      case AppRoutes.monthlyFee:
        return MaterialPageRoute(builder: (_) => MonthlyFee());
      case AppRoutes.updateMonthlyFee:
        return MaterialPageRoute(
          builder: (_) => UpdateMonthlyFee(id: settings.arguments as String),
        );
      case AppRoutes.manageSmsBundleDiscount:
        return MaterialPageRoute(
          builder: (_) => ManageSmsBundleDiscountView(item: settings.arguments as AdminSmsItem),
        );
      case AppRoutes.queryDetails:
        return MaterialPageRoute(
          builder: (_) => QueryDetails(query: settings.arguments as QueriesItem),
        );
      case AppRoutes.reservationDbDetails:
        return MaterialPageRoute(
          builder: (_) => ReservationDbDetails(item: settings.arguments as AdminReservationItem),
        );
      case AppRoutes.restaurantDetails:
        return MaterialPageRoute(builder: (_) => const RestaurantDetails());
      case AppRoutes.requestDetails:
        return MaterialPageRoute(
          builder: (_) => RequestDetails(data: settings.arguments as Map<String, dynamic>),
        );
      case AppRoutes.notifications:
        return MaterialPageRoute(builder: (_) => const Notifications());
      case AppRoutes.campaignDetailsByRes:
        return MaterialPageRoute(builder: (_) => CampaignByResDetails(
          campaign: settings.arguments as CampaignsByResEntity,
        ));
      case AppRoutes.campaignByRes:
        return MaterialPageRoute(
          builder: (_) => MarketingCampaignByRes(id: settings.arguments as String),
        );
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => Scaffold(appBar: AppBar(title: Text("Forgot Password"))),
        );
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const PersonalInfoScreen());
      case AppRoutes.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case AppRoutes.stats:
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case AppRoutes.billings:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text("Bundle and billings"))),
        );
      case AppRoutes.makeReservation:
        return MaterialPageRoute(builder: (_) => MakeReservationScreen());
      case AppRoutes.workingHours:
        return MaterialPageRoute(builder: (_) => const RestaurantWorkingHoursScreen());
      case AppRoutes.manageBookingTime:
        return MaterialPageRoute(builder: (_) => const ManageBookingTimeScreen());
      case AppRoutes.timeSlotManagement:
        return MaterialPageRoute(builder: (_) => const TimeSlotManagementScreen());
      case AppRoutes.inactiveTimeSlots:
        return MaterialPageRoute(builder: (_) => const InactiveSlotsScreen());
      case AppRoutes.updateTimeDuration:
        return MaterialPageRoute(builder: (_) => const UpdateTimeDurationScreen());
      case AppRoutes.reservations:
        return MaterialPageRoute(builder: (_) => const ReservationsScreen());
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const Settings());
      case AppRoutes.setVanueCategory:
        return MaterialPageRoute(builder: (_) => const SetVanueCategory());
      case AppRoutes.share:
        return MaterialPageRoute(builder: (_) => const ShareLinksScreen());
      case AppRoutes.campaignSummary:
        return MaterialPageRoute(builder: (_) => const CampaignSummary());
      case AppRoutes.targetedCampaign:
        return MaterialPageRoute(builder: (_) => const TargetedCampaign());
      case AppRoutes.customerReservationDetails:
        return MaterialPageRoute(builder: (_) => const CustomerReservationDetails());
      case AppRoutes.addPhotos:
        return MaterialPageRoute(builder: (_) => const AddPhotosScreen());
      case AppRoutes.settingAreaDetails:
        return MaterialPageRoute(builder: (_) => const SeatingAreaDetails());
      case AppRoutes.restaurantQRFoodMenu:
        return MaterialPageRoute(builder: (_) => const RestaurantQrFoodMenu());
      case AppRoutes.skaleton:
        return MaterialPageRoute(builder: (_) => const Skaleton());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
