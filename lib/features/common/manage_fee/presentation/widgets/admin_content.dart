import 'package:flutter/material.dart';
import '/config/constants/colors.dart';
import '/config/routes/route_name.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/custom_button.dart';
import '/features/common/manage_fee/domain/entities/monthly_fee.dart';

class AdminContent extends StatelessWidget {
  final MonthlyFeeEntity item;
  const AdminContent({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Current Monthly Fee",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.darkOrange.withSafeOpacity(.3),
                borderRadius: BorderRadius.circular(5)),
            width: double.infinity,
            child: Center(child: Text(item.money))),
        SizedBox(height: 20),
        CustomButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.updateMonthlyFee,
              arguments: item.id.toString(),
            );
          },
          text: "Update Fee",
        ),
      ],
    );
  }
}
