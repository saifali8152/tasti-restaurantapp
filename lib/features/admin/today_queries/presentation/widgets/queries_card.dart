import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';
import 'package:tasti_restaurant_app/features/admin/today_queries/domain/entities/today_queries.dart';
import 'package:tasti_restaurant_app/features/admin/today_queries/presentation/widgets/decline_today_query_dialog.dart';
import '/config/routes/route_name.dart';
import '/config/constants/colors.dart';
import '/core/widgets/custom_button.dart';

class QueriesCard extends StatelessWidget {
  final bool isVerified;
  final TodayQueriesItem? query;

  const QueriesCard({super.key, this.isVerified = false, this.query});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.queryDetails, extra: query);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              query?.name ?? "N/A",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              query?.email ?? 'N/A',
              style: TextStyle(fontSize: 12),
            ),
            Text(
              query?.dateFormatted ?? 'N/A',
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
            if (!isVerified && query?.action == 'none') ...[
              SizedBox(height: 10),
              CustomButton(
                onPressed: () => context.showCustomDialog(
                    DeclineTodayQueryDialog(id: query!.reqId.toString())),
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
