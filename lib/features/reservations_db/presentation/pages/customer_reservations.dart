import 'package:flutter/material.dart';
import '/config/routes/route_name.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';
import '../widgets/customer_reservation_card.dart';

class CustomerReservations extends StatelessWidget {
  const CustomerReservations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 100,
        title: "Customer Reservations",
        actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onSelected: (value) {
                switch (value) {
                  case 'csv':
                    // handle CSV Imported Data
                    break;
                  case 'sms':
                    // handle SMS/Email Customers
                    break;
                  case 'targeted':
                    Navigator.pushNamed(context, AppRoutes.targetedCampaign);
                    break;
                  case 'view_campaigns':
                    Navigator.pushNamed(context, AppRoutes.campaigns);
                    break;
                  case 'single_sms':
                    // handle SMS/Email Customer
                    break;
                  case 'import':
                    Navigator.pushNamed(context, AppRoutes.importDatabase);
                    break;
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 'csv',
                  child: Text('CSV Imported Data'),
                ),
                const PopupMenuItem(
                  value: 'sms',
                  child: Text('SMS/Email Customers'),
                ),
                const PopupMenuItem(
                  value: 'targeted',
                  child: Text('Targeted Campaign'),
                ),
                const PopupMenuItem(
                  value: 'view_campaigns',
                  child: Text('View Campaigns'),
                ),
                const PopupMenuItem(
                  value: 'single_sms',
                  child: Text('SMS/Email Customer'),
                ),
                const PopupMenuItem(
                  value: 'import',
                  child: Text('Import Database'),
                ),
              ],
            ),
          ],
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
