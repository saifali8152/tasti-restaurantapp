import 'package:flutter/material.dart';
import '/config/routes/route_name.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/custom_button.dart';
import '../../core/widgets/upload_image.dart';
import '/core/widgets/themed_app_bar.dart';
import '../../config/constants/icons.dart';
import '../../core/widgets/icon_button.dart';
import '/config/constants/colors.dart';

class FoodMenuScreen extends StatelessWidget {
  const FoodMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 120,
        title: "Restaurant Food Menu",
        subTitle: ButtonWithIcon(
          icon: Image.asset(
            AppIcons.qr,
            color: Colors.white,
            height: 15,
          ),
          title: 'Generate Menu QR',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.restaurantQRFoodMenu);
          },
          bgColor: const Color(0xFF5A73E2),
        ),
      ),
      body: CurvedContainer(
        child: Column(
          children: [
            const CustomUploadImageCard(),
            const SizedBox(height: 20),
            CustomButton(onPressed: () {}, text: "Upload"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
