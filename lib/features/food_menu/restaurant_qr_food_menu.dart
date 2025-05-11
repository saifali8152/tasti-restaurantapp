import 'package:flutter/material.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/icon_button.dart';
import '/core/widgets/custom_app_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RestaurantQrFoodMenu extends StatelessWidget {
  const RestaurantQrFoodMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Restaurant QR Food Menu',
      ),
      backgroundColor: Colors.grey.shade50,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.grey.withSafeOpacity(.5), blurRadius: 10)
          ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Food Menu QR Code',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              QrImageView(
                data: 'https://pub.dev/packages/qr_flutter',
                version: QrVersions.auto,
                size: 250,
                gapless: false,
              ),
              SizedBox(height: 24),
              ButtonWithIcon(
                icon: Icon(Icons.download, color: Colors.white),
                title: "Download",
                onTap: () {},
              ),
              SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.info_outline, color: Colors.grey),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      "This QR code can be shared with anyone to access your restaurant's menu",
                      style: TextStyle(color: Colors.grey.shade600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
