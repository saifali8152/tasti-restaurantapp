import 'package:flutter/material.dart';
import '/config/constants/colors.dart';
import '/core/widgets/custom_button.dart';

class ReviewCard extends StatelessWidget {
  final bool isVerified;
  const ReviewCard({super.key, this.isVerified = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/women/44.jpg',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Courtney Henry',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '2 mins ago',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          color: AppColors.pending,
                          size: 16,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Consequat velit qui adipisicing sunt do reprehenderit ad laborum tempor ullamco exercitation. Ullamco tempor adipisicing et voluptate duis sit esse aliqua',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
          if (!isVerified) ...[
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {},
                    text: "Delete",
                    bgColor: Colors.transparent,
                    borderColor: AppColors.darkOrange,
                    textColor: AppColors.darkOrange,
                    isFullWidth: false,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    onPressed: () {},
                    text: "Verify",
                    isFullWidth: false,
                  ),
                )
              ],
            ),
          ]
        ],
      ),
    );
  }
}
