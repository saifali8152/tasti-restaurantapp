import 'package:flutter/material.dart';
import '/features/add_cuisines/tabs_section.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';

class AddCuisinesScreen extends StatelessWidget {
  const AddCuisinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.darkOrange,
        appBar: ThemedAppBar(
          height: 100,
          title: "Add Cuisines & More", 
        ),
        body: CurvedContainer(
          child: CuisinesTabsSection(),
        ),
      ),
    );
  }
}
