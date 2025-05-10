import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';

class TodayCard extends StatelessWidget {
  final String title;
  final String approvedLabel;

  const TodayCard({
    super.key,
    required this.title,
    this.approvedLabel = '2 Approved',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
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
                  borderRadius: BorderRadius.circular(8)
                  ),
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
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '12',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
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
                  style: TextStyle(color: AppColors.pending, fontSize: 10),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
