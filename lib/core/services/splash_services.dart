import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/skaleton/cubit/skaleton_cubit.dart';
import '/core/services/session_controller.dart';
import '/dependency_injection.dart';
import '../../config/routes/route_name.dart';

class SplashServices {
  static Future<void> navigateToLogin(BuildContext context) async {
    final SessionController sC = sl<SessionController>();
    final userCubit = sl<SkaletonCubit>();

    await sC.loadSession();
    await Future.delayed(const Duration(seconds: 1));

    if (sC.user != null) {
      userCubit.setUser(sC.user!);
    }

    if (sC.isFirstVisit) {
      context.go(AppRoutes.onboarding);
    } else {
      context.go(AppRoutes.skaleton);
    }
  }
}
