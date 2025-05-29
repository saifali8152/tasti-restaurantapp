import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/routes/route_name.dart';

class SplashServices {
  static Future<void> navigateToLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    context.go(AppRoutes.onboarding);
  }
}
