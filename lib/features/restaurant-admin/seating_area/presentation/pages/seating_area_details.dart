import 'package:flutter/material.dart';
import '/features/restaurant-admin/seating_area/domain/entities/seating_area.dart';
import '/features/restaurant-admin/seating_area/presentation/widgets/table_card.dart';
import '/core/widgets/custom_app_bar.dart';

class SeatingAreaDetails extends StatelessWidget {
  final List<TableEntity> tables;
  const SeatingAreaDetails({super.key, required this.tables});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Seating Area Details'),
        body: tables.isEmpty? Center(child: Text("Nothing Found!")) : ListView.separated(
          padding: EdgeInsets.all(20),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: tables.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final seatingArea = tables[index];
            return TableCard(table: seatingArea, index: (index + 1).toString());
          },
        ));
  }
}
