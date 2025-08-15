import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/seating_area/domain/entities/seating_area.dart';
import '/config/routes/route_name.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/card_details_row.dart';

class BillingCard extends StatelessWidget {
  final SeatingAreaEntity seatingArea;
  const BillingCard({
    super.key,
    required this.seatingArea,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.settingAreaDetails, arguments: seatingArea.tables);
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
                Text(
                  '#${seatingArea.id}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
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
            CardDetailsRow(
                label: 'Seating Area Name', value: seatingArea.seatingAreaName),
            CardDetailsRow(
                label: 'Abbreviation', value: seatingArea.abbreviation),
            CardDetailsRow(
                label: 'Capacity', value: "${seatingArea.capacity} PAX"),
          ],
        ),
      ),
    );
  }
}
