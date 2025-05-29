import 'package:flutter/material.dart';
import '/core/widgets/custom_input_field.dart';
import 'widgets/restaurant_card.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';

class Restaurants extends StatelessWidget {
  const Restaurants({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 120,
        title: "Restaurants",
        subTitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomInputField(
            icon: Icons.search,
            hintText: "Search",
            suffixIcon: DropdownButton(
              padding: EdgeInsets.only(right: 20),
              underline: SizedBox.shrink(),
              items: [
                DropdownMenuItem(
                  value: "All",
                  child: Text("All"),
                ),
                DropdownMenuItem(
                  value: "Paid",
                  child: Text("Paid"),
                ),
                DropdownMenuItem(
                  value: "Unpaid",
                  child: Text("Unpaid"),
                ),
                DropdownMenuItem(
                  value: "Suspended",
                  child: Text("Suspended"),
                ),
              ],
              onChanged: (value) {},
              icon: Icon(Icons.sort),
            ),
          ),
        ),
      ),
      body: CurvedContainer(
        child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemBuilder: (context, index) {
            return RestaurantCard();
          },
        ),
      ),
    );
  }
}
