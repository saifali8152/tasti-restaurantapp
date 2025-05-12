import 'package:flutter/material.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '../../config/constants/icons.dart';
import '../../core/widgets/icon_button.dart';
import '/config/constants/colors.dart';
import 'widgets/seating_area_card.dart';

class SeatingAreaScreen extends StatelessWidget {
  const SeatingAreaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 120,
        title: "Seating Area",
        subTitle: ButtonWithIcon(
          icon: Image.asset(AppIcons.seatingArea,
              color: Colors.white, height: 15),
          title: 'Create Seating Areas',
          onTap: () {},
          bgColor: Color(0xFF5A73E2),
        ),
      ),
      body: CurvedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: 3,
                itemBuilder: (_, index) => SeatingAreaCard(
                  index: index + 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
