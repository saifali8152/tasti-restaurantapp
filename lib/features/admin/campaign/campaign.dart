import 'package:flutter/material.dart';
import 'widgets/marketing_campaign_card.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';

class MarketingCampain extends StatelessWidget {
  const MarketingCampain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 60,
        title: "Marketing Campaign",
      ),
      body: CurvedContainer(
        child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemBuilder: (context, index) {
            return MarketingcampaignCard();
          },
        ),
      ),
    );
  }
}
