import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import '../widgets/forgot_password_email_sent_dialog.dart';
import '/core/utils/flushbar_extention.dart';
import '/core/utils/general_extentions.dart';
import '/dependency_injection.dart';
import '../bloc/forgot_password/forgot_password_bloc.dart';
import '../bloc/forgot_password/forgot_password_event.dart';
import '../bloc/forgot_password/forgot_password_state.dart';
import '../../../../../config/constants/spaces.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailC = TextEditingController();
  final ForgotPasswordBloc bloc = sl<ForgotPasswordBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpaces.screenHpad),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Forgot Password",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Enter your email address, we will send you a verification code.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  CustomInputField(
                    icon: Icons.email_outlined,
                    hintText: 'abc@gmail.com',
                    controller: emailC,
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                    listener: (context, state) {
                      if (state is ForgotPasswordError) {
                        context.flushBarErrorMessage(message: state.message);
                      }
                      if (state is ForgotPasswordSuccess) {
                        context.showCustomDialog(
                            ForgotPasswordEmailSentDialog(),
                            isDismissible: false);
                      }
                    },
                    bloc: bloc,
                    builder: (context, state) {
                      return CustomButton(
                        isLoading: state is ForgotPasswordLoading,
                        onPressed: () {
                          bloc.add(ForgotPasswordRequested(emailC.text));
                        },
                        text: "Sent Reset Link",
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
