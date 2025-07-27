import 'package:flutter/material.dart';
import '/config/constants/colors.dart';
import '/core/utils/general_extentions.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final Color bgColor;

  const DashboardCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColor,
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
                  child: Icon(
                    icon,
                    size: 15,
                    color: AppColors.darkOrange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text(
              count,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
