import 'package:flutter/material.dart';
import '/core/utils/general_extentions.dart';
import '/config/constants/colors.dart';
import '/core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';

class RestaurantDetails extends StatelessWidget {
  const RestaurantDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Restaurant Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DetailsRow(title: "Owner", value: "Tristan Flynn"),
            DetailsRow(title: "Restaurant Name", value: "Wine Park"),
            DetailsRow(title: "Phone Number", value: "+5412441253"),
            DetailsRow(title: "Email", value: "abc@gmail.com"),
            DetailsRow(title: "City", value: "Sandton"),
            DetailsRow(title: "Dress Code", value: "Casual"),
            DetailsRow(title: "Address", value: "Casual"),
            DetailsRow(title: "Minimum Cost", value: "150"),
            DetailsRow(
              title: "Description",
              value:
                  "Beer Park sandton is an upmarket sports bar and grill where great food, craft cocktails, and refreshing beers meet in the heart of Sandton.",
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColors.borderColor.withSafeOpacity(.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Status",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('Paid',
                          style: TextStyle(
                              color: Colors.green[700], fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
            DetailsRow(
              title: "Coordinaties",
              value: "Lat: -26.1023, Long: 28.0571",
            ),
          ],
        ),
      ),
    );
  }
}
