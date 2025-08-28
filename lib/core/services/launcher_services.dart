import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class UrlLauncherService {
  Future<void> openMapLocation(
      {required double latitude, required double longitude}) async {
    final Uri uri = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");
    await _launchUrl(uri);
  }

  Future<void> callPhoneNumber(String phoneNumber) async {
  final Uri uri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  // This will go straight to default dialer if one is set,
  // otherwise system shows the chooser.
  await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );
}


  Future<void> sendEmail(String email) async {
    final Uri uri = Uri(scheme: 'mailto', path: email);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'No email app found. Please install an email app.';
      }
    } catch (e) {
      debugPrint('Email launch error: $e');
    }
  }

  Future<void> openWebsite(String url) async {
    Uri uri = Uri.parse(url);
    if (!uri.hasScheme) {
      uri = Uri.parse('https://$url');
    }
    await _launchUrl(uri);
  }

  /// New method for WhatsApp
  Future<void> sendWhatsAppMessage(
    String phoneNumber,
    String? message,
  ) async {
    final String encodedMessage = Uri.encodeComponent(message ?? '');
    final String whatsappUrl =
        "https://wa.me/${phoneNumber.replaceAll('+', '')}?text=$encodedMessage";
    final Uri uri = Uri.parse(whatsappUrl);
    await _launchUrl(uri);
  }

  Future<void> _launchUrl(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) throw 'Could not launch $uri';
    } else {
      throw 'Could not launch $uri';
    }
  }
}
