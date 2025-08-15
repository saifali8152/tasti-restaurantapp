import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/utils/flushbar_extention.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_input_field.dart';
import 'package:tasti_restaurant_app/core/widgets/field_label.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/seating_area/presentation/bloc/seating_area_bloc.dart';
import 'package:tasti_restaurant_app/features/seating_area/presentation/bloc/seating_area_event.dart';
import 'package:tasti_restaurant_app/features/seating_area/presentation/bloc/seating_area_state.dart';
import 'package:tasti_restaurant_app/features/seating_area/presentation/widgets/pax_tile.dart';

class AddSeatingAreaScreen extends StatefulWidget {
  const AddSeatingAreaScreen({super.key});

  @override
  State<AddSeatingAreaScreen> createState() => _AddSeatingAreaScreenState();
}

class _AddSeatingAreaScreenState extends State<AddSeatingAreaScreen> {
  final SeatingAreaBloc bloc = sl();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController abbreviationController = TextEditingController();

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
              controller: nameController,
            ),
            const SizedBox(height: 12),
            FieldLabel(title: "Seating Abbreviation"),
            CustomInputField(
              hintText: "Enter seating abbreviation",
              controller: abbreviationController,
            ),
            const SizedBox(height: 16),
            ...capacities.map((data) => PaxTile(data: data)),
            const SizedBox(height: 20),
            BlocConsumer<SeatingAreaBloc, SeatingAreaState>(
              listener: (context, state) {
                if (state.addResponse.status == Status.error) {
                  _showSnackBar(state.addResponse.message.toString());
                }
              },
              builder: (context, state) {
                return CustomButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    final abbreviation = abbreviationController.text.trim();

                    if (name.isEmpty || abbreviation.isEmpty) {
                      _showSnackBar("Name and Abbreviation are required");
                      return;
                    }

                    final List<TableData> tables = [];
                    for (var data in capacities) {
                      if (data.isSelected) {
                        if (data.minCapacityController.text.isEmpty ||
                            data.numberOfTablesController.text.isEmpty ||
                            data.type == null ||
                            data.shape == null) {
                          _showSnackBar(
                              "Please fill all details for ${data.pax} PAX");
                          return;
                        }

                        final minCapacity =
                            int.tryParse(data.minCapacityController.text) ?? 0;

                        // ✅ Validation: minCapacity should not exceed pax (max capacity)
                        if (minCapacity > data.pax) {
                          _showSnackBar(
                            "Min Capacity for ${data.pax} PAX cannot exceed ${data.pax}",
                          );
                          return;
                        }

                        tables.add(
                          TableData(
                            maxCapacity: data.pax,
                            minCapacity: minCapacity,
                            tableMax:
                                int.parse(data.numberOfTablesController.text),
                            isMoveable: data.isMoveable,
                            type: data.type!,
                            shape: data.shape!,
                          ),
                        );
                      }
                    }

                    final parms = SeatingAreaParms(
                      restaurantId: 123,
                      seatingAreaName: name,
                      abbreviation: abbreviation,
                      tables: tables,
                    );

                    bloc.add(AddSeatingAreaEvent(parms));
                  },
                  text: "Save Seating Area",
                  isLoading: state.addResponse.status == Status.loading,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    context.flushBarErrorMessage(message: message);
  }
}
