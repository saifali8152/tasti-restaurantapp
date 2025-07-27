import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareService {
  static Future<void> shareOnPlatform(String platform, String url) async {
    final encodedUrl = Uri.encodeComponent(url);
    String shareUrl;

    switch (platform.toLowerCase()) {
      case 'facebook':
        shareUrl = 'https://www.facebook.com/sharer/sharer.php?u=$encodedUrl';
        break;
      case 'twitter':
        shareUrl = 'https://twitter.com/intent/tweet?url=$encodedUrl';
        break;
      case 'linkedin':
        shareUrl = 'https://www.linkedin.com/sharing/share-offsite/?url=$encodedUrl';
        break;
      case 'whatsapp':
        shareUrl = 'https://wa.me/?text=$encodedUrl';
        break;
      default:
        shareUrl = url;
    }

    try {
      final uri = Uri.parse(shareUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint("Could not launch $shareUrl");
      }
    } catch (e) {
      debugPrint("Launch error: $e");
    }
  }
}
