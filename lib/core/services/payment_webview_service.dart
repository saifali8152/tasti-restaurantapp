import 'package:flutter/material.dart';
import '/features/common/manage_fee/presentation/pages/payment_webview_screen.dart';

class PaymentWebViewService {
  static void openPaymentPage({
    required BuildContext context,
    required String paymentUrl,
    required String reference,
    required void Function(String reference) onVerify,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentWebViewScreen(
          paymentUrl: paymentUrl,
          reference: reference,
          onVerify: onVerify,
        ),
      ),
    );
  }
}
