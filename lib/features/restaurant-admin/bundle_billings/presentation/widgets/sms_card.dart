import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/domain/entities/sms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/presentation/widgets/init_payment_dialog.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/card_details_row.dart';

class SmsCard extends StatelessWidget {
  final SMSEntity sms;
  const SmsCard({
    super.key,
    required this.sms,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withSafeOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardDetailsRow(label: 'S.No', value: sms.id.toString()),
          CardDetailsRow(label: 'Provider', value: sms.productOwner),
          CardDetailsRow(label: 'SMS Quantity', value: "${sms.bundles} SMS"),

          // Custom price row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Price',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                sms.amount,
                style: TextStyle(
                  decoration:
                      sms.hasDiscount ? TextDecoration.lineThrough : null,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          CardDetailsRow(label: 'Discount', value: sms.discount),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Saving',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                "${sms.percentage}% off",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: CustomButton(
              onPressed: () {
                context.showCustomDialog(InitPaymentDialog(bundleId: sms.id));
              },
              text: "Purchase",
              isFullWidth: false,
            ),
          )
        ],
      ),
    );
  }
}
