import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/enum/subscription_status.dart';
import '/features/skaleton/user_cubit/skaleton_cubit.dart';
import '/core/services/session_controller.dart';
import '/dependency_injection.dart';
import '../../config/routes/route_name.dart';

class SplashServices {
  static Future<void> navigateToLogin(BuildContext context) async {
    final SessionController sC = sl<SessionController>();
    final userCubit = sl<UserCubit>();
    final NavigatorState nav = Navigator.of(context);

    await sC.loadSession();
    await Future.delayed(const Duration(seconds: 1));

    if (sC.user != null) {
      userCubit.setUser(sC.user!);
    }

    if (sC.isFirstVisit) {
      nav.pushNamedAndRemoveUntil(AppRoutes.onboarding, (route) => false);
    } else {
      userCubit.setUser(sC.user!);
      _handleLoginNavigation(context);
    }
  }

  static void _handleLoginNavigation(BuildContext context) {
  final user = SessionController().user;
  print("User from session: $user");

  if (user == null) {
    print("No user found in session.");
    return;
  }

  print("User type: ${user.type}");

  if (user.type == 'admin') {
    print("Navigating to admin skaleton screen.");
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.skaleton, (route) => false);
  } else if (user.type == 'restaurant') {
    final status = user.subscriptionStatus;
    print("Restaurant user subscription status: $status");

    if (status == SubscriptionStatus.active.title) {
      print("Subscription is active. Navigating to skaleton screen.");
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.skaleton, (route) => false);
    }
    if (status == SubscriptionStatus.noRestaurant.title) {
      print("No restaurant found. Navigating to createNewRestaurant screen.");
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.createNewRestaurant, (route) => false);
    }
    if (status == SubscriptionStatus.restaurantSuspended.title) {
      print("Restaurant suspended. Showing error: ${user.subscriptionMessage}");
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.createNewRestaurant, (route) => false);
    }
    if (status == SubscriptionStatus.inactive.title) {
      print("Subscription inactive. Showing error: ${user.subscriptionMessage}");
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.monthlyFee, (route) => false);
    }
    if (status == SubscriptionStatus.expired.title) {
      print("Subscription expired. Showing error: ${user.subscriptionMessage}");
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.monthlyFee, (route) => false);
    }
  }
}

}
