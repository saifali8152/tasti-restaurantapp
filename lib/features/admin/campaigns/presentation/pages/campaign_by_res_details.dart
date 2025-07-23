import 'package:flutter/material.dart';
import '/core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';

class CampaignByResDetails extends StatelessWidget {
  const CampaignByResDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Campaign Details'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DetailsRow(title: "Restaurant Name", value: "Tristan Flynn"),
            DetailsRow(title: "Latest Campaign Date", value: "2025-05-23"),
            DetailsRow(title: "Status", value: "pending"),
            DetailsRow(title: "Province", value: "xyz"),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
