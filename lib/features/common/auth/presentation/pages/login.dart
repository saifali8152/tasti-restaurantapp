import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/enum/subscription_status.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import '../widgets/auth_stack.dart';
import '/core/network/response.dart';
import '/core/utils/flushbar_extention.dart';
import '/dependency_injection.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import '../../../../../config/constants/colors.dart';
import '../../../../../config/routes/route_name.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _handleLoginNavigation(BuildContext context) {
    final user = SessionController().user;
    if (user == null) return;

    if (user.type == 'admin') {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.skaleton, (route) => false);
    } else if (user.type == 'restaurant') {
      final status = user.subscriptionStatus;
      if (status == SubscriptionStatus.active.title) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.skaleton, (route) => false);
      }
      if (status == SubscriptionStatus.noRestaurant.title) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.createNewRestaurant, (route) => false);
      }
      if (status == SubscriptionStatus.restaurantSuspended.title) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.createNewRestaurant, (route) => false);
      }
      if (status == SubscriptionStatus.inactive.title) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.monthlyFee, (route) => false);
      }
      if (status == SubscriptionStatus.expired.title) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.monthlyFee, (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final loginBloc = sl<LoginBloc>();

    return BlocProvider(
      create: (_) => loginBloc,
      child: AuthStack(
        title: "Welcome Back!",
        subtitle: "Log in to manage tables, monitor bookings, and keep your restaurant running smoothly.",
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 40),

                /// Email
                CustomInputField(
                  icon: Icons.email_outlined,
                  hintText: "Email",
                  keyboardInputType: TextInputType.emailAddress,
                  onChanged: (value) => loginBloc.add(EmailChanged(value)),
                ),

                /// Password
                CustomInputField(
                  icon: Icons.lock_outline,
                  hintText: "Password",
                  isPasswordField: true,
                  onChanged: (value) => loginBloc.add(PasswordChanged(value)),
                ),

                const SizedBox(height: 8),

                /// Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.forgotPassword),
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: AppColors.darkOrange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                /// Sign in Button
                BlocConsumer<LoginBloc, LoginState>(
                  bloc: loginBloc,
                  listener: (context, state) {
                    if (state.loginResponse.status == Status.error) {
                      context.flushBarErrorMessage(
                        message: state.loginResponse.message ?? "Error Occurred",
                      );
                    }
                    if (state.loginResponse.status == Status.completed) {
                      _handleLoginNavigation(context);
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      isLoading: state.loginResponse.status == Status.loading,
                      text: "Sign in",
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          loginBloc.add(LoginSubmitted());
                        }
                      },
                    );
                  },
                ),

                const SizedBox(height: 24),

                /// Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account? "),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, AppRoutes.signup),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
