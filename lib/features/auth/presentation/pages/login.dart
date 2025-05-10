import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/colors.dart';
import '../../../../config/routes/route_name.dart';
import '../../widgets/auth_stack.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_input_field.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = AuthBloc();

    return AuthStack(
      title: "Welcome Back!",
      subtitle:
          "Log in to book your table and manage your reservations easily.",
      child: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 40),
                CustomInputField(
                  icon: Icons.email_outlined,
                  hintText: "Email",
                  keyboardInputType: TextInputType.emailAddress,
                ),
                CustomInputField(
                  icon: Icons.lock_outline,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.forgotPassword);
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
                CustomButton(
                  text: "Sign in",
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RoutesName.skaleton);
                  },
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesName.signup,
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
          );
        },
      ),
    );
  }
}
