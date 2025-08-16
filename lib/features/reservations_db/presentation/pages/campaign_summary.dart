import 'package:flutter/material.dart';
import '/config/constants/icons.dart';
import '/core/widgets/icon_button.dart';
import '/core/widgets/custom_app_bar.dart';

class CampaignSummary extends StatelessWidget {
  const CampaignSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Campaign Summary'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Recipient: ",
                    style: TextStyle(fontSize: 18, color: Colors.red)),
                Text(
                  "100",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ButtonWithIcon(
                    onTap: (){},
                    title: "Pay 150",
                    icon: Image.asset(AppIcons.pay, height: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
