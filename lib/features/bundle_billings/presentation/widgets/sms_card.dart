import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/sms.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#${sms.id}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(
                  Icons.open_in_new,
                  size: 18,
                ),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 8),
          CardDetailsRow(label: 'Provider', value: sms.productOwner),
          CardDetailsRow(label: 'SMS Quantity', value: sms.bundles),
          CardDetailsRow(label: 'Price', value: sms.percentage),
          CardDetailsRow(label: 'Discount', value: sms.discount),
          SizedBox(height: 20),
          Center(child: CustomButton(onPressed: (){}, text: "Purchase", isFullWidth: false))
        ],
      ),
    );
  }
}
