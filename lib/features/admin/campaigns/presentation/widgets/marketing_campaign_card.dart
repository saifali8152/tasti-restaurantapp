import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasti_restaurant_app/core/widgets/card_details_row.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/domain/entities/campaigns.dart';
import '/config/routes/route_name.dart';

class MarketingcampaignCard extends StatelessWidget {
  final CampaignsEntity campaign;
  const MarketingcampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push(AppRoutes.campaignByRes, extra: campaign.id.toString());
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "#${campaign.id.toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.open_in_new, size: 16),
                ],
              ),
              SizedBox(height: 12),
              CardDetailsRow(label: "Restaurant Name", value: campaign.name),
              SizedBox(height: 12),
              CardDetailsRow(label: "Latest Campaign Date", value: campaign.dates),
              SizedBox(height: 12),
              CardDetailsRow(label: "Pending Approval", value: campaign.pendingApproval.toString()),
              SizedBox(height: 12),
              CardDetailsRow(label: "Approved", value: campaign.approved.toString()),
              SizedBox(height: 12),
              CardDetailsRow(label: "Province", value: campaign.area),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
