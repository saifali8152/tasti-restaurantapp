import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_input_field.dart';

class AddHoursRow extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  const AddHoursRow({super.key, required this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomInputField(
              hintText: "Enter Hours",
              controller: controller,
              enableValidation: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                final regex = RegExp(
                    r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]-([0-1]?[0-9]|2[0-3]):[0-5][0-9]$');
                if (!regex.hasMatch(value)) {
                  return 'Please enter hours in HH:mm-HH:mm format';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
