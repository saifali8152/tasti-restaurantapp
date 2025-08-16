import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/restaurant_campaign.dart';
import '/core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';

class RestaurantCampaignDetails extends StatelessWidget {
  final RestaurantCampaignEntity campaign;
  const RestaurantCampaignDetails({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Campaign Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsRow(title: 'Campaign Id', value: campaign.cId.toString()),
            DetailsRow(
                title: 'People Reached', value: campaign.people.toString()),
            DetailsRow(title: 'Date', value: campaign.dates),
            DetailsRow(title: 'Provience', value: campaign.area),
            DetailsRow(title: 'Amount Paid', value: campaign.cash.toString()),
            DetailsRow(title: 'Status', value: campaign.status),
            SizedBox(height: 5),
            Text(
              " Campaigns Message",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.darkGrey.withSafeOpacity(.2))
              ),
              child: Text(
                campaign.message,
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
