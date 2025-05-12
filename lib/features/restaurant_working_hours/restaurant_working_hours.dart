import 'package:flutter/material.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_input_field.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';

class RestaurantWorkingHoursScreen extends StatelessWidget {
  const RestaurantWorkingHoursScreen({super.key});

  final List<String> _weekDays = const [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 150,
        title: "Working Hours",
        subTitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Please set your restaurant's working hours below.\nFormat: HH:MM-HH:MM (e.g. 09:00-22:00)",
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: CurvedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 10),
            Expanded(child: _buildWorkingHourRow()),
            const SizedBox(height: 20),
            CustomButton(onPressed: () {}, text: "Save Working Hours"),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 48,
      padding: const EdgeInsets.only(top: 5, right: 30, bottom: 5, left: 10),
      decoration: const BoxDecoration(
        color: AppColors.tileHeader,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Row(
        children: const [
          Expanded(
            child: Text(
              "Day",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Working Hours",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkingHourRow() {
    return ListView.builder(
      itemCount: _weekDays.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _weekDays[index],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Expanded(
                flex: 2,
                child: CustomInputField(hintText: "Enter Hours"),
              ),
            ],
          ),
        );
      },
    );
  }
}
