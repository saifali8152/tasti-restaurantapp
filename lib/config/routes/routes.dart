import 'package:flutter/material.dart';
import '../../features/screens.dart';
import 'route_name.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.campaignSummary:
        return MaterialPageRoute(
          builder: (_) => const CampaignSummary(),
        );
      case RoutesName.setVanueCategory:
        return MaterialPageRoute(
          builder: (_) => const SetVanueCategory(),
        );
      case RoutesName.targetedCampaign:
        return MaterialPageRoute(
          builder: (_) => const TargetedCampaign(),
        );
      case RoutesName.customerReservationDetails:
        return MaterialPageRoute(
          builder: (_) => const CustomerReservationDetails(),
        );
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case RoutesName.addPhotos:
        return MaterialPageRoute(
          builder: (_) => const AddPhotosScreen(),
        );
      case RoutesName.settingAreaDetails:
        return MaterialPageRoute(
          builder: (_) => const SeatingAreaDetails(),
        );
      case RoutesName.restaurantQRFoodMenu:
        return MaterialPageRoute(
          builder: (_) => const RestaurantQrFoodMenu(),
        );
      case RoutesName.skaleton:
        return MaterialPageRoute(
          builder: (_) => const Skaleton(),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case RoutesName.signup:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
        );
      case RoutesName.onboarding:
        return MaterialPageRoute(
          builder: (_) => OnboardingScreen(),
        );
      case RoutesName.makeReservation:
        return MaterialPageRoute(
          builder: (_) => MakeReservationScreen(),
        );
      case RoutesName.manageBookingTime:
        return MaterialPageRoute(
          builder: (_) => ManageBookingTimeScreen(),
        );
      case RoutesName.timeSlotManagement:
        return MaterialPageRoute(
          builder: (_) => TimeSlotManagementScreen(),
        );
      case RoutesName.inactiveTimeSlots:
        return MaterialPageRoute(
          builder: (_) => InactiveSlotsScreen(),
        );
      case RoutesName.updateTimeDuration:
        return MaterialPageRoute(
          builder: (_) => UpdateTimeDurationScreen(),
        );
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
