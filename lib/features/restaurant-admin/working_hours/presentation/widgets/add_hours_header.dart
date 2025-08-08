import 'package:flutter/widgets.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';

class AddHoursHeader extends StatelessWidget {
  const AddHoursHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
}