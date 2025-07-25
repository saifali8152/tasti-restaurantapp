import 'package:flutter/material.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/custom_button.dart';
import '/features/admin/campaigns/presentation/widgets/approve_campaign_dialog.dart';
import '/features/admin/campaigns/domain/entities/campaigns_by_res.dart';
import '/core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';

class CampaignByResDetails extends StatelessWidget {
  final CampaignsByResEntity campaign;
  const CampaignByResDetails({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Campaign Details'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DetailsRow(title: "Recipients", value: campaign.people),
            DetailsRow(title: "Province", value: campaign.area),
            DetailsRow(title: "SMS/Email Bundles", value: "campaign.bundles"),
            DetailsRow(title: "Campaign Date", value: campaign.dates),
            DetailsRow(title: "Amount Paid", value: campaign.cash),
            DetailsRow(title: "Campaign Message", value: "campaign.message"),
            if(campaign.status.toLowerCase() == "pending")...[
             SizedBox(height: 20), 
            CustomButton(onPressed: (){
              context.showCustomDialog(ApproveCampaignDialog(id: campaign.cId.toString()));
            }, text: "Approve")
            ]
          ],
        ),
      ),
    );
  }
}
