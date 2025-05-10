import 'package:flutter/material.dart';
import '../../config/routes/route_name.dart';

class SplashServices {
  static Future<void> navigateToLogin(BuildContext context) async {
    final nav = Navigator.of(context);
    await Future.delayed(const Duration(seconds: 2));
    nav.pushNamedAndRemoveUntil(RoutesName.onboarding, (route) => false);
  }
}
