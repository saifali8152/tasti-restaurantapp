import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/features/reviews/widgets/review_card.dart';
import '../../../../../config/constants/colors.dart';

class TabsSection extends StatelessWidget {
  const TabsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: AppColors.darkOrange,
          indicatorColor: Colors.deepOrange,
          splashFactory: NoSplash.splashFactory,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: "Verified"),
            Tab(text: "Unverified"),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  return ReviewCard(isVerified: true);
                },
              ),
              ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  return ReviewCard(isVerified: false);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
