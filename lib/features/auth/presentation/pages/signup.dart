import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_name.dart';
import '../widgets/auth_stack.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_input_field.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = AuthBloc();

    return AuthStack(
      title: "Create an account",
      subtitle: "Join us and book your favorite restaurants in seconds.",
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
                  icon: Icons.person_outline,
                  hintText: "Full name",
                  keyboardInputType: TextInputType.emailAddress,
                ),
                CustomInputField(
                  icon: Icons.email_outlined,
                  hintText: "Email",
                ),
                CustomInputField(
                  icon: Icons.phone_outlined,
                  hintText: "Phone number",
                  keyboardInputType: TextInputType.phone,
                ),
                CustomInputField(
                  icon: Icons.lock_outline,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                SizedBox(height: 24),
                CustomButton(
                  text: "Sign Up",
                  onPressed: () {
                    context.go(AppRoutes.skaleton);
                  },
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        context.go(AppRoutes.login);
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
          );
        },
      ),
    );
  }
}
