import 'package:flutter/material.dart';
import '/core/widgets/custom_input_field.dart';
import '../today_requests/presentation/widgets/requests_card.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';

class Requests extends StatelessWidget {
  const Requests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 120,
        title: "Today's Requests",
        subTitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomInputField(
            icon: Icons.search,
            hintText: "Search",
          ),
        ),
      ),
      body: CurvedContainer(
        child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemBuilder: (context, index) {
            return RequestsCard(isVerified: false);
          },
        ),
      ),
    );
  }
}
