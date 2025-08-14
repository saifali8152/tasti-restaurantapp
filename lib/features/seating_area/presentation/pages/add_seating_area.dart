import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_input_field.dart';
import 'package:tasti_restaurant_app/core/widgets/field_label.dart';
import 'package:tasti_restaurant_app/features/seating_area/presentation/widgets/pax_tile.dart';

class AddSeatingAreaScreen extends StatefulWidget {
  const AddSeatingAreaScreen({super.key});

  @override
  State<AddSeatingAreaScreen> createState() => _AddSeatingAreaScreenState();
}

class _AddSeatingAreaScreenState extends State<AddSeatingAreaScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController abbreviationController = TextEditingController();

  // List to hold seating data
  final List<TableCapacityData> capacities =
      List.generate(15, (index) => TableCapacityData(pax: index + 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Restaurant Seating Area"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FieldLabel(title: "Seating Area Name"),
            CustomInputField(
                hintText: "Enter seating area name",
                controller: nameController),
            const SizedBox(height: 12),
            FieldLabel(title: "Seating Abbreviation"),
            CustomInputField(
                hintText: "Enter seating abbreviation",
                controller: abbreviationController),
            const SizedBox(height: 16),
            ...capacities.map((data) => PaxTile(data: data)),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () => _printData(),
              text: "Save Seating Area",
            ),
          ],
        ),
      ),
    );
  }

  void _printData() {
    debugPrint("Seating Area Name: ${nameController.text}");
    debugPrint("Abbreviation: ${abbreviationController.text}");
    for (var data in capacities) {
      if (data.isSelected) {
        debugPrint(
            "PAX ${data.pax} -> MinCap: ${data.minCapacityController.text}, Tables: ${data.numberOfTablesController.text}, Moveable: ${data.isMoveable}, Type: ${data.type}, Shape: ${data.shape}");
      }
    }
  }
}
