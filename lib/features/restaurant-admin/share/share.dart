import 'package:flutter/material.dart';
import '/core/services/session_controller.dart';
import '/features/restaurant-admin/share/widget/share_card.dart';
import '/config/constants/colors.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';

class ShareLinksScreen extends StatelessWidget {
  const ShareLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemedAppBar(
        title: "Share Links on Social Media",
      ),
      backgroundColor: AppColors.darkOrange,
      body: CurvedContainer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: .9,
            children: [
              ShareCard(
                url: 'https://tasti.co.za/reservation.php?id=${SessionController().user?.restaurant?.id}',
                imageUrl: 'https://cdn-icons-png.flaticon.com/512/174/174857.png',
                label: 'LinkedIn',
                brandColor: Color(0xFF0077B5),
              ),
              ShareCard(
                url: 'https://tasti.co.za/reservation.php?id=${SessionController().user?.restaurant?.id}',
                imageUrl: 'https://cdn-icons-png.flaticon.com/512/733/733547.png',
                label: 'Facebook',
                brandColor: Color(0xFF4267B2),
              ),
              ShareCard(
                url: 'https://tasti.co.za/reservation.php?id=${SessionController().user?.restaurant?.id}',
                imageUrl: 'https://cdn-icons-png.flaticon.com/512/3670/3670151.png',
                label: 'Twitter',
                brandColor: Color(0xFF1DA1F2),
              ),
              ShareCard(
                url: 'https://tasti.co.za/reservation.php?id=${SessionController().user?.restaurant?.id}',
                imageUrl: 'https://cdn-icons-png.flaticon.com/512/733/733585.png',
                label: 'WhatsApp',
                brandColor: Color(0xFF25D366),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

