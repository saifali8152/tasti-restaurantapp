import 'package:flutter/material.dart';
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
      nav.pushNamedAndRemoveUntil(AppRoutes.skaleton, (route) => false);
    }
  }
}
