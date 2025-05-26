import 'package:flutter/material.dart';
import '/features/reviews/tabs_section.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.darkOrange,
        appBar: ThemedAppBar(
          height: 100,
          title: "Reviews",
        ),
        body: CurvedContainer(
          child: TabsSection(),
        ),
      ),
    );
  }
}
