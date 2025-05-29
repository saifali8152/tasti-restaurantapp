import 'package:flutter/material.dart';
import '/config/constants/colors.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';

class RequestDetails extends StatelessWidget {
  const RequestDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Request Details'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DetailsRow(title: "Full Name", value: "Tristan Flynn"),
            DetailsRow(title: "Email Address", value: "abc@gmail.com"),
            DetailsRow(title: "Phone Number", value: "1213465"),
            DetailsRow(title: "Restaurant Name", value: "Wine Bar"),
            DetailsRow(title: "Your Role", value: "Owner"),
            DetailsRow(
              title: "Restaurant Address",
              value:
                  "Shop 7, Delta Central, 74 Hillcrest Ave, Blairgowrie, Randburg, 2194, South Africa",
            ),
            DetailsRow(title: "Referral Source", value: "Friend"),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                  onPressed: () {},
                  text: "Reject",
                  bgColor: AppColors.grey,
                  textColor: Colors.black,
                )),
                SizedBox(width: 10),
                Expanded(
                  child: CustomButton(onPressed: () {}, text: "Approve"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
