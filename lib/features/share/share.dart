import 'package:flutter/material.dart';
import '/config/constants/colors.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/icon_button.dart';
import '/core/widgets/themed_app_bar.dart';

class ShareLinksScreen extends StatelessWidget {
  const ShareLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(
        title: "Share Links on Social Media",
      ),
      backgroundColor: AppColors.darkOrange,
      body: CurvedContainer(
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [
            ShareCard(
              imageUrl: 'https://cdn-icons-png.flaticon.com/512/174/174857.png',
              label: 'LinkedIn',
            ),
            ShareCard(
              imageUrl: 'https://cdn-icons-png.flaticon.com/512/733/733547.png',
              label: 'Facebook',
            ),
            ShareCard(
              imageUrl:
                  'https://cdn-icons-png.flaticon.com/512/3670/3670151.png',
              label: 'Twitter',
            ),
            ShareCard(
              imageUrl: 'https://cdn-icons-png.flaticon.com/512/733/733585.png',
              label: 'Whatsapp',
            ),
          ],
        ),
      ),
    );
  }
}

class ShareCard extends StatelessWidget {
  final String imageUrl;
  final String label;

  const ShareCard({
    super.key,
    required this.imageUrl,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(imageUrl, width: 40, height: 40),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          ButtonWithIcon(
            onTap: (){},
            icon: const Icon(Icons.share, size: 16, color: Colors.white),
            title: "Share",
          ),
        ],
      ),
    );
  }
}
