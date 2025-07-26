import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '/core/utils/general_extentions.dart';

import '../../../../../config/constants/colors.dart';

class MonthlyCard extends StatelessWidget {
  final String title;
  final String approvedLabel;

  const MonthlyCard({
    super.key,
    required this.title,
    this.approvedLabel = '13 Approved',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0XFFEDD2C8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColors.lightOrange.withSafeOpacity(.5),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Icon(
                    Icons.calendar_today,
                    size: 15,
                    color: AppColors.darkOrange,
                  ),
                ),
                const Icon(Icons.open_in_new, color: Colors.grey, size: 20),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Monthly Requests",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "(April 2025)",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '12',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 6.0,
                      percent: 0.6,
                      animation: true,
                      backgroundColor: Colors.green,
                      progressColor: AppColors.pending,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '2 ',
                          style: const TextStyle(
                              color: Colors.green,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Approved',
                          style: TextStyle(color: Colors.green, fontSize: 10),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          '13 ',
                          style: TextStyle(
                              color: AppColors.pending,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'pending',
                          style:
                              TextStyle(color: AppColors.pending, fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
