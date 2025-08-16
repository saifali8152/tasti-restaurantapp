import 'package:flutter/material.dart';
import '../../../../core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';

class CustomerReservationDetails extends StatelessWidget {
  const CustomerReservationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Customer Reservation'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DetailsRow(title: "Customer Name", value: "Value"),
            DetailsRow(title: "Email", value: "value"),
            DetailsRow(title: "Total Reservations", value: "value"),
            DetailsRow(title: "Last Visit", value: "3 PAX"),
            SizedBox(height: 20),
            CustomButton(
              onPressed: () {},
              text: "Delete",
            ),
          ],
        ),
      ),
    );
  }
}
