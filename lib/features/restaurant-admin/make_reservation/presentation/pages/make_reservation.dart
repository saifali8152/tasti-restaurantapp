import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/services/session_controller.dart';
import '/core/utils/flushbar_extention.dart';
import '/core/widgets/field_label.dart';
import '/dependency_injection.dart';
import '/features/restaurant-admin/make_reservation/domain/entities/restaurant_seating_area.dart';
import '/features/restaurant-admin/reservations/presentation/bloc/reservation_bloc.dart';
import '/features/restaurant-admin/reservations/presentation/bloc/reservation_event.dart';
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
  String selectedDiet = '';
  String selectedOccasion = '';

  final int id = SessionController().user?.restaurant.id ?? 0;
  final MakeReservationBloc bloc = sl();

  final TextEditingController guestsController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController requestController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // ✅ set today's date by default
    selectedDate = DateTime.now();

    // ✅ fetch seating areas
    bloc.add(FetchSeatingAreas(id: id.toString()));

    // ✅ also fetch time slots for today's date immediately
    bloc.add(
      FetchTimeSlots(
        parms: FetchTimeSlotParms(
          id: id,
          date: selectedDate!.toIso8601String(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Make Reservation'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocConsumer<MakeReservationBloc, MakeReservationState>(
          listener: (context, state) {
            if (state.reservationResponse.status == Status.completed) {
              Navigator.pop(context);
              context.read<ReservationBloc>().add(
                    FetchReservationEvent(
                      FetchReservationParms(
                        id: id.toString(),
                        date: DateTime.now().toString()
                      ),
                    ),
                  );
            }
            if (state.reservationResponse.status == Status.error) {
              context.flushBarErrorMessage(message: state.reservationResponse.message.toString());
            }
          },
          builder: (context, state) {
            return BlocBuilder<MakeReservationBloc, MakeReservationState>(
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ Date (already today)
                      FieldLabel(title: "Date"),
                      CustomInputField(
                        hintText: selectedDate!.formatDate(),
                        readOnly: true,
                        onTap: () {
                          context.showCustomDatePicker(
                            initialDate: selectedDate ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
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
                        enableValidation: false,
                      ),
                      const SizedBox(height: 10),

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
                            selectedTable = null;
                          });
                          if (selectedSeatingArea != null) {
                            bloc.add(FetchTables(
                                id: selectedSeatingArea!.id.toString()));
                          }
                        },
                      ),
                      const SizedBox(height: 15),

                      // Table / Guests
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
                          const DropdownMenuEntry(
                            value: 'larger_booking',
                            label: 'Larger Booking',
                          ),
                        ],
                        initialValue: selectedTable,
                        hintText: 'Select Number of Guests',
                        onChanged: (val) {
                          setState(() {
                            selectedTable = val;
                          });
                        },
                      ),
                      const SizedBox(height: 15),

                      if (selectedTable == 'larger_booking') ...[
                        FieldLabel(title: "Guests"),
                        CustomInputField(
                          controller: guestsController,
                          hintText: 'Enter Guests (minimum 16)',
                          keyboardInputType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter number of guests";
                            }
                            final guests = int.tryParse(value);
                            if (guests == null || guests < 16) {
                              return "Guests must be at least 16";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                      ],

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
                        items: const [
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
                        items: const [
                          DropdownMenuEntry(
                              value: 'Birthday', label: 'Birthday'),
                          DropdownMenuEntry(
                              value: 'Anniversary', label: 'Anniversary'),
                          DropdownMenuEntry(
                              value: 'Proposal', label: 'Proposal'),
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
                        enableValidation: false,
                      ),
                      const SizedBox(height: 20),

                      // Submit
                      CustomButton(
                        isLoading:
                            state.reservationResponse.status == Status.loading,
                        text: 'Make Reservation',
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              selectedDate != null &&
                              selectedSeatingArea != null &&
                              selectedTime != null &&
                              selectedTable != null) {
                            bloc.add(
                              MakeReservation(
                                MakeReservationParms(
                                  restaurantId: id,
                                  date: selectedDate.toString(),
                                  time: selectedTime.toString(),
                                  seatingAreaId:
                                      selectedSeatingArea?.id.toString() ?? '',
                                  guests: selectedTable.toString(),
                                  customGuests: guestsController.text,
                                  dietary: selectedDiet.toString(),
                                  occasion: selectedOccasion.toString(),
                                  specialRequests: requestController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
