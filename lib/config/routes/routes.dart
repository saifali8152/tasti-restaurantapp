import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/restaurants/domain/entities/restaurant.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/presentation/pages/csv_sent_campaign.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/presentation/pages/sent_campaign.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations/domain/entities/reservation.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations/presentation/pages/reservation_details.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/domain/entities/reservation_data_email.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/presentation/pages/customer_reservations_by_email.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/presentation/pages/cvc_imported_data.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/presentation/pages/import_database.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/presentation/pages/buy_sms_bundle.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/presentation/pages/restaurant_transaction_history.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/domain/entities/restaurant_campaign.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/presentation/pages/restaurant_campaign_details.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/presentation/pages/restaurant_campaigns.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/presentation/pages/create_new_restaurant.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/presentation/pages/update_new_restaurant.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/domain/entities/working_hour.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/presentation/pages/restaurant_working_hours.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/presentation/pages/update_working_hours.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/seating_area/domain/entities/seating_area.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/seating_area/presentation/pages/add_seating_area.dart';
import '/features/admin/campaigns/domain/entities/campaigns_by_res.dart';
import '/features/admin/campaigns/presentation/pages/campaigns_by_res.dart';
import '/features/admin/events/domain/entities/event.dart';
import '/features/admin/events/presentation/pages/add_event.dart';
import '/features/admin/events/presentation/pages/update_event.dart';
import '../../features/common/manage_fee/presentation/pages/update_monthly_fee.dart';
import '../../features/common/manage_fee/presentation/pages/monthly_fee.dart';
import '/features/admin/manage_sms/domain/entities/admin_sms.dart';
import '/features/admin/manage_sms/presentation/pages/manage_sms_bundle_discount.dart';
import '/features/admin/manage_sms/presentation/pages/add_sms_bundle.dart';
import '../../features/common/profile/presentation/pages/change_password.dart';
import '../../features/common/profile/presentation/pages/personal_info.dart';
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
      case AppRoutes.createNewRestaurant:
        return MaterialPageRoute(builder: (_) => const CreateNewRestaurant());
      case AppRoutes.addEvent:
        return MaterialPageRoute(builder: (_) => const AddEventScreen());
      case AppRoutes.updateRestaurant:
        return MaterialPageRoute(builder: (_) => const UpdateNewRestaurant());
      case AppRoutes.updateEvent:
        return MaterialPageRoute(
            builder: (_) => UpdateEventScreen(
                  event: settings.arguments as EventItem,
                ));
      case AppRoutes.transactionHistory:
        return MaterialPageRoute(builder: (_) => const TransactionHistory());
      case AppRoutes.buySmsBundles:
        return MaterialPageRoute(builder: (_) => const BuySmsBundle());
      case AppRoutes.restaurantTransactionHistory:
        return MaterialPageRoute(
            builder: (_) => const RestaurantTransactionHistory());
      case AppRoutes.campaigns:
        return MaterialPageRoute(builder: (_) => RestaurantCampaignsScreen());
      case AppRoutes.campaignDetails:
        return MaterialPageRoute(
            builder: (_) => RestaurantCampaignDetails(
                  campaign: settings.arguments as RestaurantCampaignEntity,
                ));
      case AppRoutes.reservationDetails:
        return MaterialPageRoute(
            builder: (_) => ReservationDetails(
                  reservation: settings.arguments as ReservationItem,
                ));
      case AppRoutes.importDatabase:
        return MaterialPageRoute(builder: (_) => ImportDatabase());
      case AppRoutes.smsBundleDetails:
        return MaterialPageRoute(
          builder: (_) =>
              SmsBundleDetails(item: settings.arguments as AdminSmsItem),
        );
      case AppRoutes.monthlyFee:
        return MaterialPageRoute(builder: (_) => MonthlyFee());
      case AppRoutes.updateMonthlyFee:
        return MaterialPageRoute(
          builder: (_) => UpdateMonthlyFee(id: settings.arguments as String),
        );
      case AppRoutes.manageSmsBundleDiscount:
        return MaterialPageRoute(
          builder: (_) => ManageSmsBundleDiscountView(
              item: settings.arguments as AdminSmsItem),
        );
      case AppRoutes.queryDetails:
        return MaterialPageRoute(
          builder: (_) =>
              QueryDetails(query: settings.arguments as QueriesItem),
        );
      case AppRoutes.reservationDbDetails:
        return MaterialPageRoute(
          builder: (_) => ReservationDbDetails(
              item: settings.arguments as AdminReservationItem),
        );
      case AppRoutes.restaurantDetails:
        return MaterialPageRoute(
            builder: (_) => RestaurantDetails(
                  restaurant: settings.arguments as RestaurantItem,
                ));
      case AppRoutes.requestDetails:
        return MaterialPageRoute(
          builder: (_) =>
              RequestDetails(data: settings.arguments as Map<String, dynamic>),
        );
      case AppRoutes.notifications:
        return MaterialPageRoute(builder: (_) => const Notifications());
      case AppRoutes.campaignDetailsByRes:
        return MaterialPageRoute(
            builder: (_) => CampaignByResDetails(
                  campaign: settings.arguments as CampaignsByResEntity,
                ));
      case AppRoutes.campaignByRes:
        return MaterialPageRoute(
          builder: (_) =>
              MarketingCampaignByRes(id: settings.arguments as String),
        );
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(appBar: AppBar(title: Text("Forgot Password"))),
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
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Bundle and billings"))),
        );
      case AppRoutes.makeReservation:
        return MaterialPageRoute(builder: (_) => MakeReservationScreen());
      case AppRoutes.workingHours:
        return MaterialPageRoute(
            builder: (_) => const RestaurantWorkingHoursScreen());
      case AppRoutes.manageBookingTime:
        return MaterialPageRoute(
            builder: (_) => const ManageBookingTimeScreen());
      case AppRoutes.timeSlotManagement:
        return MaterialPageRoute(
            builder: (_) => const TimeSlotManagementScreen());
      case AppRoutes.inactiveTimeSlots:
        return MaterialPageRoute(builder: (_) => const InactiveSlotsScreen());
      case AppRoutes.updateTimeDuration:
        return MaterialPageRoute(
            builder: (_) => const UpdateTimeDurationScreen());
      case AppRoutes.reservations:
        return MaterialPageRoute(builder: (_) => const ReservationsScreen());
      case AppRoutes.reservationsByEmail:
        return MaterialPageRoute(builder: (_) => CustomerReservationsByEmail(
          email: settings.arguments as String,
        ));
      // case AppRoutes.settings:
      //   return MaterialPageRoute(builder: (_) => const Settings());
      case AppRoutes.setVanueCategory:
        return MaterialPageRoute(builder: (_) => const SetVenueCategory());
      case AppRoutes.share:
        return MaterialPageRoute(builder: (_) => const ShareLinksScreen());
      case AppRoutes.csvImportedData:
        return MaterialPageRoute(builder: (_) => const CvcImportedDataScreen());
      case AppRoutes.csvSentCampaign:
        return MaterialPageRoute(builder: (_) => CsvSentCampaign(arguments: settings.arguments as CsvSentCampaignArguments));
      case AppRoutes.sentCampaign:
        return MaterialPageRoute(builder: (_) => SentCampaign(arguments: settings.arguments as SentCampaignArguments));
      case AppRoutes.updateWorkingHours:
        return MaterialPageRoute(
          builder: (_) => UpdateWorkingHours(
            workingHours: settings.arguments as WorkingHourEntity,
          ),
        );
      case AppRoutes.campaignSummary:
        return MaterialPageRoute(builder: (_) => CampaignSummary(
          parms: settings.arguments as AddTargetedCampaignParms,
        ));
      case AppRoutes.targetedCampaign:
        return MaterialPageRoute(builder: (_) => const TargetedCampaign());
      case AppRoutes.customerReservationDetails:
        return MaterialPageRoute(
            builder: (_) => CustomerReservationDetails(data: settings.arguments as ReservationDataEmailEntity));
      case AppRoutes.addPhotos:
        return MaterialPageRoute(builder: (_) => const AddPhotosScreen());
      case AppRoutes.settingAreaDetails:
        return MaterialPageRoute(
            builder: (_) => SeatingAreaDetails(
                  tables: settings.arguments as List<TableEntity>,
                ));
      case AppRoutes.addSeatingArea:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => AddSeatingAreaScreen(
            isEdit: args?['isEdit'] ?? false,
            initialData: args?['initialData'],
          ),
        );

      case AppRoutes.restaurantQRFoodMenu:
        return MaterialPageRoute(
            builder: (_) => RestaurantQrFoodMenu(
                  menuUrl: settings.arguments as String,
                ));
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
