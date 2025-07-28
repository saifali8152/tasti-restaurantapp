import '/config/routes/route_name.dart';
import '/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordEmailSentDialog extends StatelessWidget {
  const ForgotPasswordEmailSentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ),
            const Icon(Icons.logout, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Alert',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'The link to reset password has been sent. Please check email!“',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CustomButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route)=>false, arguments: true),
              text: "Continue to log in",
            ),
          ],
        ),
      ),
    );
  }
}
