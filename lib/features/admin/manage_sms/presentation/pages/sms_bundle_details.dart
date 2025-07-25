import 'package:flutter/material.dart';
import '/config/routes/route_name.dart';
import '/core/utils/general_extentions.dart';
import '/features/admin/manage_sms/domain/entities/admin_sms.dart';
import '/features/admin/manage_sms/presentation/widgets/delete_sms_dialog.dart';
import '/config/constants/colors.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';

class SmsBundleDetails extends StatelessWidget {
  final AdminSmsItem item;
  const SmsBundleDetails({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'SMS Bundle Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DetailsRow(title: "Package Owner", value: item.productOwner),
            DetailsRow(title: "SMS Quantity", value: item.bundles),
            DetailsRow(title: "Origional Price", value: item.amount),
            if (item.hasDiscount) ...[
              DetailsRow(title: "Discounted Price", value: item.discount),
              DetailsRow(title: "Discount %", value: item.percentage),
            ],
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                  onPressed: () {
                    context.showCustomDialog(
                      DeleteSmsDialog(id: item.id.toString()),
                    );
                  },
                  text: "Delete",
                  bgColor: AppColors.grey,
                  textColor: Colors.black,
                )),
                SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      Navigator.pushNamed(context,
                        AppRoutes.manageSmsBundleDiscount,
                        arguments: item,
                      );
                    },
                    text: "Manage Discount",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
