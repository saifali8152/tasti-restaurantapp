import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import '/config/constants/colors.dart';
import '/config/constants/spaces.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_input_field.dart';
import '/core/parms/parms.dart';
import '/core/utils/flushbar_extention.dart';
import '../bloc/change_password/change_password_bloc.dart';
import '../bloc/change_password/change_password_event.dart';
import '../bloc/change_password/change_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _onResetPasswordPressed() {
    final currentPassword = currentPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (newPassword != confirmPassword) {
      context.flushBarErrorMessage(
          message: "New password and confirm password do not match");
      return;
    }

    context.read<ChangePasswordBloc>().add(ChangePasswordRequested(
          ChangePasswordParms(
            currentPassword: currentPassword,
            newPassword: newPassword,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            Navigator.pop(context);
            context.flushBarSuccessMessage(message: "Password changed successfully");
            
          } else if (state is ChangePasswordError) {
            context.flushBarErrorMessage(message: state.message);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpaces.screenHpad),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      "Change Password",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Your password must be different from previously used password",
                      style:
                          TextStyle(fontSize: 16, color: AppColors.lightGrey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    CustomInputField(
                      controller: currentPasswordController,
                      icon: Icons.lock_outline,
                      hintText: "Current Password",
                      isPasswordField: true,
                    ),
                    const SizedBox(height: 10),
                    CustomInputField(
                      controller: newPasswordController,
                      icon: Icons.lock_outline,
                      hintText: "New Password",
                      isPasswordField: true,
                    ),
                    const SizedBox(height: 10),
                    CustomInputField(
                      controller: confirmPasswordController,
                      icon: Icons.lock_outline,
                      hintText: "Confirm New Password",
                      isPasswordField: true,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                      builder: (context, state) {
                        return CustomButton(
                          isLoading: state is ChangePasswordLoading,
                          onPressed: _onResetPasswordPressed,
                          text: "Update",
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
