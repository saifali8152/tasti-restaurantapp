import 'package:flutter/material.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';

class ReservationDbDetails extends StatelessWidget {
  const ReservationDbDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Reservation Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DetailsRow(title: "Restaurant", value: "Wine Park"),
            DetailsRow(title: "Guest Name", value: "Tristan Flynn"),
            DetailsRow(title: "Phone Number", value: "+5412441253"),
            DetailsRow(title: "Email", value: "abc@gmail.com"),
            DetailsRow(title: "Number of Guests", value: "10"),
            DetailsRow(title: "Reservation Time", value: DateTime.now().formatDate()),
          ],
        ),
      ),
    );
  }
}
