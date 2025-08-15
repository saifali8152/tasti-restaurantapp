import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String paymentUrl;
  final String reference; // Needed to verify
  final void Function(String reference) onVerify;

  const PaymentWebViewScreen({
    super.key,
    required this.paymentUrl,
    required this.reference,
    required this.onVerify,
  });

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;

  bool _hasVerified = false;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) async {
            // Check if we're being redirected back to a known domain (like your callback domain)
            if (!_hasVerified && url.contains('verify-payment') || url.contains("verify-sms-payment")) {
              _hasVerified = true;

              Navigator.pop(context); // Close the webview first
              widget.onVerify(widget.reference); // Then verify the payment
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Payment')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
