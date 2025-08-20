import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/services/session_controller.dart';
import '/core/utils/flushbar_extention.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_input_field.dart';
import '/core/widgets/field_label.dart';
import '/dependency_injection.dart';
import '/features/restaurant-admin/seating_area/presentation/bloc/seating_area_bloc.dart';
import '/features/restaurant-admin/seating_area/presentation/bloc/seating_area_event.dart';
import '/features/restaurant-admin/seating_area/presentation/bloc/seating_area_state.dart';
import '/features/restaurant-admin/seating_area/presentation/widgets/pax_tile.dart';

class AddSeatingAreaScreen extends StatefulWidget {
  final SeatingAreaParms? initialData;
  final bool isEdit;

  const AddSeatingAreaScreen({
    super.key,
    this.initialData,
    this.isEdit = false,
  });

  @override
  State<AddSeatingAreaScreen> createState() => _AddSeatingAreaScreenState();
}

class _AddSeatingAreaScreenState extends State<AddSeatingAreaScreen> {
  final SeatingAreaBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController abbreviationController = TextEditingController();

  final List<TableCapacityData> capacities =
      List.generate(15, (index) => TableCapacityData(pax: index + 1));

  @override
  void initState() {
    super.initState();

    if (widget.isEdit && widget.initialData != null) {
      nameController.text = widget.initialData!.seatingAreaName;
      abbreviationController.text = widget.initialData!.abbreviation;

      for (var table in widget.initialData!.tables) {
        final data = capacities.firstWhere((c) => c.pax == table.maxCapacity);
        data.isSelected = true;
        data.minCapacityController.text = table.minCapacity.toString();
        data.numberOfTablesController.text = table.tableMax.toString();
        data.isMoveable = table.isMoveable;
        data.type = table.type;
        data.shape = table.shape;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isEdit ? "Edit Restaurant Seating Area" : "Add Restaurant Seating Area",
      ),
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
                } else if (state.addResponse.status == Status.completed) {
                  Navigator.pop(context, true); // Return success flag
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
                          _showSnackBar("Please fill all details for ${data.pax} PAX");
                          return;
                        }

                        final minCapacity = int.tryParse(data.minCapacityController.text) ?? 0;
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
                            tableMax: int.parse(data.numberOfTablesController.text),
                            isMoveable: data.isMoveable,
                            type: data.type!,
                            shape: data.shape!,
                          ),
                        );
                      }
                    }

                    final parms = SeatingAreaParms(
                      id: widget.isEdit ? widget.initialData?.id : null,
                      restaurantId: id,
                      seatingAreaName: name,
                      abbreviation: abbreviation,
                      tables: tables,
                    );

                    if (widget.isEdit) {
                      bloc.add(UpdateSeatingAreaEvent(parms));
                    } else {
                      bloc.add(AddSeatingAreaEvent(parms));
                    }
                  },
                  text: widget.isEdit ? "Update Seating Area" : "Save Seating Area",
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
