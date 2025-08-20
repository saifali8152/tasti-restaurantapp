import 'package:flutter/material.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/custom_button.dart';
import '/features/admin/restaurants/domain/entities/restaurant.dart';
import '/features/admin/restaurants/presentation/widgets/enable_restaurant_dialog.dart';
import '/features/admin/restaurants/presentation/widgets/suspend_restaurant_dialog.dart';
import '/core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';

class RestaurantDetails extends StatelessWidget {
  final RestaurantItem restaurant;
  const RestaurantDetails({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Restaurant Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DetailsRow(title: "Owner", value: restaurant.owner),
            DetailsRow(
                title: "Restaurant Name", value: restaurant.restaurantName),
            DetailsRow(title: "Phone Number", value: restaurant.phone),
            DetailsRow(title: "Email", value: restaurant.email),
            DetailsRow(title: "City", value: restaurant.city),
            DetailsRow(title: "Dress Code", value: restaurant.dressCode),
            DetailsRow(title: "Address", value: restaurant.address),
            DetailsRow(
              title: "Minimum Cost",
              value: restaurant.minimumSpend.toString(),
            ),
            DetailsRow(
              title: "Description",
              value: restaurant.description,
            ),
            DetailsRow(
              title: "Status",
              value: restaurant.status.toUpperCase(),
            ),
            DetailsRow(
              title: "Paid",
              value: restaurant.paidStatusText.toUpperCase(),
            ),
            DetailsRow(
              title: "Coordinaties",
              value: "Lat: ${restaurant.lat}, Long: ${restaurant.lon}",
            ),
            if (restaurant.status == 'suspended') ...[
              SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  context.showCustomDialog(
                      EnableRestaurantDialog(id: restaurant.id.toString()));
                },
                text: "Enable Restaurant",
              )
            ],
            if (restaurant.status == 'active') ...[
              SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  context.showCustomDialog(
                      SuspendRestaurantDialog(id: restaurant.id.toString()));
                },
                text: "Suspend Restaurant",
              )
            ]
          ],
        ),
      ),
    );
  }
}
