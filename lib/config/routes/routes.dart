import 'package:flutter/material.dart';
import '../../features/screens.dart';
import 'route_name.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
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
