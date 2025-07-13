import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasti_restaurant_app/features/auth/presentation/widgets/auth_stack.dart';
import '/core/network/response.dart';
import '/core/utils/flushbar_extention.dart';
import '/dependency_injection.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import '../../../../config/constants/colors.dart';
import '../../../../config/routes/route_name.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final loginBloc = sl<LoginBloc>();
    return BlocProvider(
      create: (context) => loginBloc,
      child: AuthStack(
        title: "Welcome Back!",
        subtitle:
            "Log in to book your table and manage your reservations easily.",
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
                  icon: Icons.email_outlined,
                  hintText: "Email",
                  keyboardInputType: TextInputType.emailAddress,
                  onChanged: (p0) => loginBloc.add(EmailChanged(p0)),
                ),
                CustomInputField(
                  icon: Icons.lock_outline,
                  hintText: "Password",
                  isPasswordField: true,
                  onChanged: (p0) => loginBloc.add(PasswordChanged(p0)),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    context.push(AppRoutes.forgotPassword);
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: AppColors.darkOrange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                BlocConsumer<LoginBloc, LoginState>(
                  bloc: loginBloc,
                  listenWhen: (previous, current) {
                    return previous.loginResponse.status !=
                        current.loginResponse.status;
                  },
                  listener: (context, state) {
                    if (state.loginResponse.status == Status.error) {
                      context.flushBarErrorMessage(
                          message:
                              state.loginResponse.message ?? "Error Occured");
                    }

                    if (state.loginResponse.status == Status.completed) {
                      context.go(AppRoutes.skaleton);
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      isLoading: state.loginResponse.status == Status.loading,
                      text: "Sign in",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          loginBloc.add(LoginSubmitted());
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account? "),
                    GestureDetector(
                      onTap: () {
                        context.pushReplacement(
                          AppRoutes.signup,
                        );
                      },
                      child: Text(
                        "Sign up",
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
