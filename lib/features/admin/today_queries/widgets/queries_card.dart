import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/config/routes/route_name.dart';
import '/config/constants/colors.dart';
import '/core/widgets/custom_button.dart';

class QueriesCard extends StatelessWidget {
  final bool isVerified;
  const QueriesCard({super.key, this.isVerified = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.queryDetails);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Umar Khan",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              'Restaurant Name',
              style: TextStyle(fontSize: 12),
            ),
            const Text(
              'Chinese Chinese,Italian',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                SizedBox(width: 5),
                Expanded(
                  child: const Text(
                    'Shop 7, Delta Central, 74 Hillcrest Ave, Blairgowrie, Randburg, 2194, South Africa',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            if (!isVerified) ...[
              SizedBox(height: 10),
              CustomButton(
                onPressed: () {},
                text: "Delete",
                bgColor: AppColors.grey,
                textColor: Colors.black,
              )
            ]
          ],
        ),
      ),
    );
  }
}
