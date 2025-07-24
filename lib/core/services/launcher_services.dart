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
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    await _launchUrl(uri);
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

  Future<void> openWebsite(String url, {LaunchMode? launchMode}) async {
    Uri uri = Uri.parse(url);
    if (!uri.hasScheme) {
      uri = Uri.parse('https://$url');
    }
    await _launchUrl(uri, launchMode: launchMode);
  }

  Future<void> _launchUrl(Uri uri, {LaunchMode? launchMode}) async {
    if (await canLaunchUrl(uri)) {
      final bool launched = await launchUrl(
        uri,
        mode: launchMode ?? LaunchMode.externalApplication,
      );
      if (!launched) throw 'Could not launch $uri';
    } else {
      throw 'Could not launch $uri';
    }
  }
}
