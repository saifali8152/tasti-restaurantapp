import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';
import 'package:tasti_restaurant_app/features/admin/today_requests/presentation/widgets/decline_today_request_dialog.dart';
import '/features/admin/today_requests/domain/entities/today_requests.dart';
import '/config/routes/route_name.dart';
import '/config/constants/colors.dart';
import '/core/widgets/custom_button.dart';

class RequestsCard extends StatelessWidget {
  final bool isVerified;
  final TodayRequestItem? request;
  const RequestsCard({super.key, this.isVerified = false, this.request});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push(AppRoutes.requestDetails, extra: request);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request?.name ?? 'N/A',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              request?.role ?? 'N/A',
              style: TextStyle(fontSize: 12),
            ),
            Text(
              request?.dateFormatted ?? 'N/A',
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
                  child: Text(
                    request?.city ?? 'N/A',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            if (!isVerified && request?.action == 'no') ...[
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: ()=> context.showCustomDialog(DeclineTodayRequestDialog(id: request!.reqId.toString())),
                      text: "Decline",
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
                      text: "Accept",
                      isFullWidth: false,
                    ),
                  )
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}
