import 'package:flutter/material.dart';
import '/core/enum/subscription_status.dart';
import '../../features/common/skaleton/user_cubit/skaleton_cubit.dart';
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

    if (sC.user == null) {
      nav.pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
      return;
    }

    if (sC.user != null) {
      userCubit.setUser(sC.user!);
    }

    if (sC.isFirstVisit) {
      nav.pushNamedAndRemoveUntil(AppRoutes.onboarding, (route) => false);
    } else {
      userCubit.setUser(sC.user!);
      _handleLoginNavigation(nav);
    }
  }

  static void _handleLoginNavigation(NavigatorState nav) {
    final user = SessionController().user;
    debugPrint("User from session: $user");

    if (user == null) {
      debugPrint("No user found in session.");
      return;
    }

    debugPrint("User type: ${user.type}");

    if (user.type == 'admin' || user.type == 'admin_user') {
      debugPrint("Navigating to admin skaleton screen.");
      nav.pushNamedAndRemoveUntil(AppRoutes.skaleton, (route) => false);
    } else if (user.type == 'restaurant') {
      final status = user.subscriptionStatus;
      debugPrint("Restaurant user subscription status: $status");

      if (status == SubscriptionStatus.active.title) {
        debugPrint("Subscription is active. Navigating to skaleton screen.");
        nav.pushNamedAndRemoveUntil(AppRoutes.skaleton, (route) => false);
      }
      if (status == SubscriptionStatus.noRestaurant.title) {
        debugPrint(
            "No restaurant found. Navigating to createNewRestaurant screen.");
        nav.pushNamedAndRemoveUntil(
            AppRoutes.createNewRestaurant, (route) => false);
      }
      if (status == SubscriptionStatus.restaurantSuspended.title) {
        debugPrint(
            "Restaurant suspended. Showing error: ${user.subscriptionMessage}");
        nav.pushNamedAndRemoveUntil(
            AppRoutes.createNewRestaurant, (route) => false);
      }
      if (status == SubscriptionStatus.inactive.title) {
        debugPrint(
            "Subscription inactive. Showing error: ${user.subscriptionMessage}");
        nav.pushNamedAndRemoveUntil(AppRoutes.monthlyFee, (route) => false);
      }
      if (status == SubscriptionStatus.expired.title) {
        debugPrint(
            "Subscription expired. Showing error: ${user.subscriptionMessage}");
        nav.pushNamedAndRemoveUntil(AppRoutes.monthlyFee, (route) => false);
      }
    } else if (user.type == 'restaurant_user') {
      final status = user.subscriptionStatus;
      debugPrint("Restaurant user subscription status: $status");

      if (status == SubscriptionStatus.active.title) {
        debugPrint("Subscription is active. Navigating to skaleton screen.");
        nav.pushNamedAndRemoveUntil(AppRoutes.skaleton, (route) => false);
      }
    }
  }
}
