import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint("Loading: $url");
          },
          onPageFinished: (url) {
            debugPrint("Finished loading: $url");
          },
          onWebResourceError: (error) {
            debugPrint("Error: $error");
          },
        ),
      )
      ..loadRequest(
        Uri.parse("https://tawk.to/chat/68b00e3b5c94f31927e2fac0/1j3nrf6g4"), // 👈 your link here
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: WebViewWidget(controller: _controller));
  }
}
