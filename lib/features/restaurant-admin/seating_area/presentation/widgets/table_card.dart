import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/widgets/details_row.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/seating_area/domain/entities/seating_area.dart';
import '/core/utils/general_extentions.dart';

class TableCard extends StatelessWidget {
  final TableEntity table;
  final String index;
  const TableCard({
    super.key,
    required this.table,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
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
          DetailsRow(title: 'S.No', value: index),
          DetailsRow(title: 'Table Capacity', value: "${table.maxCapacity} PAX"),
          DetailsRow(title: 'Min Capacity', value: "${table.minCapacity} PAX"),
          DetailsRow(title: 'Number of Table', value: "${table.tableMax} PAX"),
          DetailsRow(title: 'Seating Area', value: table.abbreviation.toString()),
          DetailsRow(title: 'Moveable', value: table.isMoveable == 1 ? "Yes" : "No"),
          DetailsRow(title: 'Type', value: table.type),
          DetailsRow(title: 'Shape', value: table.shape),
        ],
      ),
    );
  }
}
