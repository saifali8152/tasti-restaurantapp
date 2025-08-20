import 'package:flutter/material.dart';
import '/config/constants/colors.dart';
import '/config/routes/route_name.dart';
import '/features/restaurant-admin/reservations_db/domain/entities/restaurant_campaign.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/card_details_row.dart';

class RestaurantCampaignCard extends StatelessWidget {
  final RestaurantCampaignEntity campaign;
  const RestaurantCampaignCard({
    super.key,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.campaignDetails,
            arguments: campaign);
      },
      child: Container(
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
            CardDetailsRow(
                label: 'Campaign Id', value: campaign.cId.toString()),
            CardDetailsRow(
                label: 'People Reached', value: campaign.people.toString()),
            CardDetailsRow(label: 'Date', value: campaign.dates),
            CardDetailsRow(label: 'Provience', value: campaign.area),
            CardDetailsRow(
                label: 'Amount Paid', value: campaign.cash.toString()),

            // Custom price row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status',
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(campaign.status).withSafeOpacity(0.1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    campaign.status,
                    style: TextStyle(
                      fontSize: 12,
                      color: _getStatusColor(campaign.status),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.pending;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
