import 'package:flutter/material.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_dropdown.dart';
import '/core/widgets/custom_input_field.dart';

class MakeReservationScreen extends StatefulWidget {
  const MakeReservationScreen({super.key});

  @override
  State<MakeReservationScreen> createState() => _MakeReservationScreenState();
}

class _MakeReservationScreenState extends State<MakeReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Make Resesrvation'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              FieldLabel(title: "Date"),
              CustomInputField(
                hintText: selectedDate == null
                    ? 'Select Date'
                    : selectedDate.formatDate().toString(),
                readOnly: true,
                onTap: () {
                  context.showCustomDatePicker(
                    initialDate: selectedDate ?? DateTime.now(),
                    onDateSelected: (picked) {
                      setState(() {
                        selectedDate = picked;
                      });
                    },
                  );
                },
                suffixIcon: Icon(Icons.calendar_today_outlined),
              ),
              SizedBox(height: 10),
              FieldLabel(title: "Time"),
              SizedBox(height: 5),
              CustomDropdown(
                items: [DropdownMenuEntry(value: 'value', label: 'label')],
                onChanged: (val) {},
                hintText: 'Select Time',
              ),
              SizedBox(height: 20),
              FieldLabel(title: "Number of Guests"),
              CustomInputField(
                hintText: 'Number of Guests',
              ),
              SizedBox(height: 10),
              FieldLabel(title: "Name"),
              CustomInputField(
                hintText: 'Enter Name',
              ),
              SizedBox(height: 10),
              FieldLabel(title: "Phone Number"),
              CustomInputField(
                hintText: 'Phone Number',
              ),
              SizedBox(height: 10),
              FieldLabel(title: "Dietary Requirements"),
              SizedBox(height: 10),
              CustomDropdown(
                items: [
                  DropdownMenuEntry(value: 'Vegan', label: 'Vegan'),
                  DropdownMenuEntry(value: 'Vegetarian', label: 'Vegetarian'),
                  DropdownMenuEntry(value: 'Lactose', label: 'Lactose'),
                  DropdownMenuEntry(value: 'Gluten intolerant', label: 'Gluten intolerant'),
                ],
                onChanged: (val) {},
                hintText: 'Select',
              ),
              SizedBox(height: 20),
              FieldLabel(title: "Special Occasion"),
              SizedBox(height: 10),
              CustomDropdown(
                items: [DropdownMenuEntry(value: 'value', label: 'label')],
                onChanged: (val) {},
                hintText: 'Select',
              ),
              SizedBox(height: 20),
              FieldLabel(title: "Special Request"),
              CustomInputField(
                hintText: 'Special Request',
                maxLines: 5,
              ),
              const SizedBox(height: 30),
              CustomButton(
                onPressed: () {},
                text: 'Make Reservation',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FieldLabel extends StatelessWidget {
  final String title;
  const FieldLabel({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(fontWeight: FontWeight.bold));
  }
}
