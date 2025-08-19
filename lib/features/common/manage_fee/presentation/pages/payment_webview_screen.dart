import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
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
            if (!_hasVerified && url.contains('verify-payment') || url.contains("verify-sms-payment") || url.contains("verify-campaign-payment")) {
              _hasVerified = true;

              Navigator.pop(context);
              widget.onVerify(widget.reference);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Complete Payment'),
      body: WebViewWidget(controller: _controller),
    );
  }
}
