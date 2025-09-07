import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';

class NavigatorService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void navigateTo(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  static void navigateToReplacement(String routeName) {
    navigatorKey.currentState?.pushReplacementNamed(routeName);
  }
  
  static void navigateToRemoveUntill(String routeName) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(routeName, (route)=>false);
  }
  
  static void clearSessionAndnavigate() {
    SessionController().clearSession();
    navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRoutes.login, (route)=>false);
  }
}
