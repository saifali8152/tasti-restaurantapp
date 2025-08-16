import 'package:flutter/material.dart';
import '../../../../core/widgets/card_details_row.dart';
import '/config/routes/route_name.dart';
import '/core/utils/general_extentions.dart';
import '../../../../core/widgets/custom_button.dart';

class CustomerReservationCard extends StatelessWidget {
  final int index;
  const CustomerReservationCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.customerReservationDetails);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withSafeOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                IconButton(
                  icon: const Icon(
                    Icons.open_in_new,
                    size: 18,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 8),
            CardDetailsRow(label: 'Customer Name', value:'Value'),
            CardDetailsRow(label: 'Total Reservations', value:'Value'),
            SizedBox(height: 5),
            const Divider(),
            SizedBox(height: 5),
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


