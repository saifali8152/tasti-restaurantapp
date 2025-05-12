import 'package:flutter/material.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '../../core/widgets/custom_dropdown.dart';

class UpdateTimeDurationScreen extends StatelessWidget {
  const UpdateTimeDurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Update Time Duration"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Time Duration"),
            SizedBox(height: 10),
            CustomDropdown(
              items: [
                DropdownMenuEntry(value: 'Vegan', label: 'Vegan'),
                DropdownMenuEntry(value: 'Vegetarian', label: 'Vegetarian'),
                DropdownMenuEntry(value: 'Lactose', label: 'Lactose'),
                DropdownMenuEntry(
                    value: 'Gluten intolerant', label: 'Gluten intolerant'),
              ],
              onChanged: (val) {},
              hintText: 'Select',
            ),
            SizedBox(height: 20),
            CustomButton(onPressed: (){}, text: "Update Duration")
          ],
        ),
      ),
    );
  }
}
