import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';

class PermissionChip extends StatelessWidget {
  final PermissionData p;
  final VoidCallback onSelected;

  const PermissionChip({super.key, required this.p, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      showCheckmark: false,
      label: Text(p.title),
      selected: p.isSelected,
      selectedColor: AppColors.darkOrange.withSafeOpacity(.15),
      checkmarkColor: AppColors.darkOrange,
      labelStyle: TextStyle(
        color: p.isSelected ? AppColors.darkOrange : Colors.black87,
      ),
      onSelected: (_) => onSelected(),
    );
  }
}
