import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';
import 'package:tasti_restaurant_app/core/widgets/card_details_row.dart';
import '../../../core/widgets/custom_button.dart';

class RevervationCard extends StatelessWidget {
  const RevervationCard({super.key});

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
              const Text(
                'Hassan Khan',
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
          CardDetailsRow(label:'Name', value: 'Ali Khan'),
          CardDetailsRow(label:'Date', value: '12/05/2025'),
          CardDetailsRow(label:'Time', value: '1:45 PM'),
          SizedBox(height: 5),
          const Divider(),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {},
                  text: 'Decline',
                  bgColor: Color(0xffE3E5E6),
                  textColor: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomButton(onPressed: () {}, text: "Accept"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
