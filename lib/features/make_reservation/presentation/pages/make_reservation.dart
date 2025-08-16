import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/widgets/field_label.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/make_reservation/domain/entities/restaurant_seating_area.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_dropdown.dart';
import '/core/widgets/custom_input_field.dart';
import '../bloc/make_reservation_bloc.dart';
import '../bloc/make_reservation_event.dart';
import '../bloc/make_reservation_state.dart';

class MakeReservationScreen extends StatefulWidget {
  const MakeReservationScreen({super.key});

  @override
  State<MakeReservationScreen> createState() => _MakeReservationScreenState();
}

class _MakeReservationScreenState extends State<MakeReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  RestaurantSeatingAreaEntity? selectedSeatingArea;
  String? selectedTime;
  String? selectedTable;
  String? selectedDiet;
  String? selectedOccasion;

  final int id = SessionController().user?.restaurant.id ?? 0;
  final MakeReservationBloc bloc = sl();

  final TextEditingController guestsController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController requestController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.add(FetchSeatingAreas(id: id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Make Reservation'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocBuilder<MakeReservationBloc, MakeReservationState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date picker
                  FieldLabel(title: "Date"),
                  CustomInputField(
                    hintText: selectedDate == null
                        ? 'Select Date'
                        : selectedDate!.formatDate(),
                    readOnly: true,
                    onTap: () {
                      context.showCustomDatePicker(
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime.now(), // ✅ only today and onward
                        lastDate: DateTime.now().add(const Duration(
                            days: 365)), // optional, e.g., 1 year ahead
                        onDateSelected: (picked) {
                          setState(() {
                            selectedDate = picked;
                            selectedTime = null;
                          });
                          bloc.add(FetchTimeSlots(
                            parms: FetchTimeSlotParms(
                              id: id,
                              date: picked.toIso8601String(),
                            ),
                          ));
                        },
                      );
                    },
                    suffixIcon: const Icon(Icons.calendar_today_outlined),
                  ),
                  const SizedBox(height: 10),

                  // Seating area
                  FieldLabel(title: "Seating Area"),
                  const SizedBox(height: 5),
                  CustomDropdown(
                    items: state.seatingAreaResponse.data
                            ?.map((e) => DropdownMenuEntry(
                                  value: e.id.toString(),
                                  label: e.seatingAreaName,
                                ))
                            .toList() ??
                        [],
                    initialValue: selectedSeatingArea?.id.toString(),
                    hintText: 'Select Seating Area',
                    onChanged: (val) {
                      setState(() {
                        selectedSeatingArea = state.seatingAreaResponse.data
                            ?.firstWhere((e) => e.id.toString() == val);
                        selectedTable = null; // ✅ you are resetting the table
                      });
                      if (selectedSeatingArea != null) {
                        bloc.add(FetchTables(
                            id: selectedSeatingArea!.id.toString()));
                      }
                    },
                  ),
                  const SizedBox(height: 15),

                  // Time
                  FieldLabel(title: "Time"),
                  const SizedBox(height: 5),
                  CustomDropdown(
                    items: state.timeSlotResponse.data?.availableTimeSlots
                            .map((e) => DropdownMenuEntry(
                                  value: e,
                                  label: e,
                                ))
                            .toList() ??
                        [],
                    initialValue: selectedTime,
                    hintText: 'Select Time',
                    onChanged: (val) {
                      setState(() {
                        selectedTime = val;
                      });
                    },
                  ),
                  const SizedBox(height: 15),

                  // Table
                  FieldLabel(title: "Number of Guests"),
                  const SizedBox(height: 5),
                  CustomDropdown(
                    items: [
                      ...(state.tableResponse.data
                              ?.map((e) => DropdownMenuEntry(
                                    value: e,
                                    label: "$e Guests",
                                  ))
                              .toList() ??
                          []),
                      DropdownMenuEntry(
                        value: 'large',
                        label: 'Large Booking',
                      ),
                    ],
                    initialValue: selectedTable,
                    hintText: 'Select Table',
                    onChanged: (val) {
                      setState(() {
                        selectedTable = val;
                      });
                    },
                  ),
                  const SizedBox(height: 15),

                  // Number of Guests
                  FieldLabel(title: "Number of Guests"),
                  CustomInputField(
                    controller: guestsController,
                    hintText: 'Number of Guests',
                    keyboardInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),

                  // Name
                  FieldLabel(title: "Name"),
                  CustomInputField(
                    controller: nameController,
                    hintText: 'Enter Name',
                  ),
                  const SizedBox(height: 10),

                  // Phone
                  FieldLabel(title: "Phone Number"),
                  CustomInputField(
                    controller: phoneController,
                    hintText: 'Phone Number',
                    keyboardInputType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),

                  // Dietary
                  FieldLabel(title: "Dietary Requirements"),
                  const SizedBox(height: 5),
                  CustomDropdown(
                    items: [
                      DropdownMenuEntry(value: 'Vegan', label: 'Vegan'),
                      DropdownMenuEntry(
                          value: 'Vegetarian', label: 'Vegetarian'),
                      DropdownMenuEntry(value: 'Lactose', label: 'Lactose'),
                      DropdownMenuEntry(
                          value: 'Gluten intolerant',
                          label: 'Gluten intolerant'),
                      DropdownMenuEntry(value: 'Other', label: 'Other'),
                    ],
                    initialValue: selectedDiet,
                    hintText: 'Select',
                    onChanged: (val) {
                      setState(() {
                        selectedDiet = val;
                      });
                    },
                  ),
                  const SizedBox(height: 15),

                  // Occasion
                  FieldLabel(title: "Special Occasion"),
                  const SizedBox(height: 5),
                  CustomDropdown(
                    items: [
                      DropdownMenuEntry(value: 'Birthday', label: 'Birthday'),
                      DropdownMenuEntry(value: 'Anniversary', label: 'Anniversary'),
                      DropdownMenuEntry(value: 'Proposal', label: 'Proposal'),
                      DropdownMenuEntry(value: 'Other', label: 'Other'),
                    ],
                    initialValue: selectedOccasion,
                    hintText: 'Select',
                    onChanged: (val) {
                      setState(() {
                        selectedOccasion = val;
                      });
                    },
                  ),
                  const SizedBox(height: 15),

                  // Special Request
                  FieldLabel(title: "Special Request"),
                  CustomInputField(
                    controller: requestController,
                    hintText: 'Special Request',
                    maxLines: 5,
                  ),
                  const SizedBox(height: 20),

                  // Submit button
                  CustomButton(
                    text: 'Make Reservation',
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          selectedDate != null &&
                          selectedSeatingArea != null &&
                          selectedTime != null &&
                          selectedTable != null) {}
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
