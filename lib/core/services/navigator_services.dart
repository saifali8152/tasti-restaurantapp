import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';

class NavigatorService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void _runWhenUnlocked(void Function(NavigatorState nav) action) {
    void execute() {
      final nav = navigatorKey.currentState;
      if (nav == null || !nav.mounted) return;
      action(nav);
    }

    final binding = SchedulerBinding.instance;
    if (binding.schedulerPhase == SchedulerPhase.idle) {
      binding.addPostFrameCallback((_) => execute());
    } else {
      binding.addPostFrameCallback((_) => execute());
    }
  }

  static void navigateTo(String routeName) {
    _runWhenUnlocked((nav) => nav.pushNamed(routeName));
  }

  static void navigateToReplacement(String routeName) {
    _runWhenUnlocked((nav) => nav.pushReplacementNamed(routeName));
  }

  static void navigateToRemoveUntill(String routeName) {
    _runWhenUnlocked(
      (nav) => nav.pushNamedAndRemoveUntil(routeName, (route) => false),
    );
  }

  static void clearSessionAndnavigate() {
    SessionController().clearSession();
    navigateToRemoveUntill(AppRoutes.login);
  }
}
