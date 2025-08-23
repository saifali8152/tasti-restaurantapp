import 'package:flutter/material.dart';

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
}
