import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/enum/subscription_status.dart';
import '/core/services/session_controller.dart';
import '/core/widgets/phone_input_field.dart';
import '/features/common/auth/presentation/widgets/auth_stack.dart';
import '/core/network/response.dart';
import '/core/utils/flushbar_extention.dart';
import '/dependency_injection.dart';
import '../bloc/signup/signup_bloc.dart';
import '../bloc/signup/signup_event.dart';
import '../bloc/signup/signup_state.dart';
import '../../../../../config/routes/route_name.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_input_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  void _handleLoginNavigation(BuildContext context) {
    final user = SessionController().user;
    if (user == null) return;

    if (user.type == 'admin' || user.type == 'admin_admin') {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.skaleton, (route) => false);
    } else if (user.type == 'restaurant' || user.type == 'restaurant_admin') {
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
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final singupBloc = sl<SignupBloc>();
    return BlocProvider(
      create: (context) => singupBloc,
      child: AuthStack(
        title: "Create an account",
        subtitle:
            "Join us to simplify your restaurant's booking and table management.",
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 40),
                CustomInputField(
                  icon: Icons.person_outline,
                  hintText: "First name",
                  keyboardInputType: TextInputType.emailAddress,
                  onChanged: (p0) {
                    singupBloc.add(FirstNameChanged(p0));
                  },
                ),
                CustomInputField(
                  icon: Icons.person_outline,
                  hintText: "Last name",
                  keyboardInputType: TextInputType.emailAddress,
                  onChanged: (p0) {
                    singupBloc.add(LastNameChanged(p0));
                  },
                ),
                CustomInputField(
                  icon: Icons.email_outlined,
                  hintText: "Email",
                  onChanged: (p0) {
                    singupBloc.add(EmailChanged(p0));
                  },
                ),
                PhoneInputField(onChanged: (value){
                  singupBloc.add(PhoneNumberChanged(value));
                }),
                CustomInputField(
                  icon: Icons.lock_outline,
                  hintText: "Password",
                  isPasswordField: true,
                  onChanged: (p0) {
                    singupBloc.add(PasswordChanged(p0));
                  },
                ),
                CustomInputField(
                  icon: Icons.lock_outline,
                  hintText: "Confirm Password",
                  isPasswordField: true,
                  onChanged: (p0) {
                    singupBloc.add(ConfirmPasswordChanged(p0));
                  },
                ),
                SizedBox(height: 24),
                BlocConsumer<SignupBloc, SignupState>(
                  bloc: singupBloc,
                  listener: (context, state) {
                    if (state.signupResponse.status == Status.error) {
                      context.flushBarErrorMessage(
                          message:
                              state.signupResponse.message ?? "Error Occured");
                    }

                    if (state.signupResponse.status == Status.completed) {
                      _handleLoginNavigation(context);
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      isLoading: state.signupResponse.status == Status.loading,
                      text: "Sign Up",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          singupBloc.add(SignUpSubmitted());
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.login,
                        );
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
