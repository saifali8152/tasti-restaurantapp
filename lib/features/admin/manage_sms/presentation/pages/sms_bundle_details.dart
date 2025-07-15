import 'package:flutter/material.dart';
import '/config/constants/colors.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';

class SmsBundleDetails extends StatelessWidget {
  const SmsBundleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'SMS Bundle Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DetailsRow(title: "Package Owner", value: "Tasti"),
            DetailsRow(title: "SMS Quantity", value: "1000"),
            DetailsRow(title: "Origional Price", value: "1000"),
            DetailsRow(title: "Discounted Price", value: "700"),
            DetailsRow(title: "Discount %", value: "10%"),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                  onPressed: () {},
                  text: "Delete",
                  bgColor: AppColors.grey,
                  textColor: Colors.black,
                )),
                SizedBox(width: 10),
                Expanded(
                    child: CustomButton(
                        onPressed: () {}, text: "Manage Discount")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
