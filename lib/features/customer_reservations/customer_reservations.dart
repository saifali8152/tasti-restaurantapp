import 'package:flutter/material.dart';
import '/config/routes/route_name.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '../../config/constants/icons.dart';
import '../../core/widgets/icon_button.dart';
import '/config/constants/colors.dart';
import 'widgets/customer_reservation_card.dart';

class CustomerReservations extends StatelessWidget {
  const CustomerReservations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 170,
        title: "Customer Reservations",
        subTitle: Column(
          children: [
            ButtonWithIcon(
              icon: Image.asset(AppIcons.envelop,
                  color: Colors.white, height: 15),
              title: 'SMS/Email Customers',
              onTap: () {},
              bgColor: Color(0xFF0D49AA),
            ),
            ButtonWithIcon(
              icon: Image.asset(AppIcons.target,
                  color: Colors.white, height: 15),
              title: 'Targeted Campaign',
              onTap: () {
                Navigator.pushNamed(context, RoutesName.targetedCampaign);
              },
              bgColor: Color(0xFFD97700),
            ),
            
          ],
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
                itemBuilder: (_, index) => CustomerReservationCard(
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
