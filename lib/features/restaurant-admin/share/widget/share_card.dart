import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/services/share_service.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';

class ShareCard extends StatelessWidget {
  final String imageUrl;
  final String label;
  final Color brandColor;
  final String url;

  const ShareCard({
    super.key,
    required this.imageUrl,
    required this.label,
    required this.brandColor,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: brandColor.withSafeOpacity(0.1),
              radius: 28,
              child: Image.network(imageUrl, width: 32, height: 32),
            ),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ShareService.shareOnPlatform(label.toLowerCase(), url);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                icon: const Icon(Icons.share, size: 16),
                label: const Text("Share"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
