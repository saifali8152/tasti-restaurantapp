import 'package:flutter/material.dart';
import '/core/widgets/custom_app_bar.dart';
import '../../../../config/constants/colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/details_row.dart';

class SeatingAreaDetails extends StatelessWidget {
  const SeatingAreaDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Seating Area Details'),
      body: Column(
        children: [
          DetailsRow(title: "No.", value: "1"),
          DetailsRow(title: "Seating Area Name", value: "value"),
          DetailsRow(title: "Abbreviation", value: "value"),
          DetailsRow(title: "Table Capacity", value: "3 PAX"),
          DetailsRow(title: "Min Capacity", value: "3 PAX"),
          DetailsRow(title: "Number of Tables", value: "5"),
          DetailsRow(title: "Moveable", value: "Yes"),
          DetailsRow(title: "Type", value: "High"),
          DetailsRow(title: "Shape", value: "Round"),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {},
                  text: 'Update',
                  bgColor: Colors.white,
                  textColor: AppColors.darkOrange,
                  borderColor: AppColors.darkOrange,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomButton(
                  onPressed: () {},
                  text: "Delete",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
