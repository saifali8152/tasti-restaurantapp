import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';
import 'package:tasti_restaurant_app/features/admin/requests/domain/entities/requests.dart';
import 'package:tasti_restaurant_app/features/admin/requests/presentation/widgets/decline_request_dialog.dart';
import '/config/constants/colors.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';

class RequestDetails extends StatelessWidget {
  final RequestItem? request;
  const RequestDetails({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Request Details'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DetailsRow(title: "Full Name", value: request!.name),
            DetailsRow(title: "Email Address", value: request!.email),
            DetailsRow(title: "Phone Number", value: request!.phone),
            DetailsRow(title: "Restaurant Name", value: request!.names),
            DetailsRow(title: "Your Role", value: request!.role),
            DetailsRow(
              title: "Restaurant Address",
              value: request!.city,
            ),
            DetailsRow(title: "Referral Source", value: request!.text),
            SizedBox(height: 20),
            if (request?.action == 'no')
              Row(
                children: [
                  Expanded(
                      child: CustomButton(
                    onPressed: () => context.showCustomDialog(
                        DeclineRequestDialog(
                            id: request!.reqId.toString())),
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
