import 'package:flutter/material.dart';
import '../../constants/colors.dart';
class CustomCheckboxTheme {
  static CheckboxThemeData darkTheme = CheckboxThemeData(
      fillColor: WidgetStateProperty.all(AppColors.white),
      checkColor: WidgetStateProperty.all(AppColors.black),
    );

  static CheckboxThemeData lightTheme = CheckboxThemeData(
      fillColor: WidgetStateProperty.all(AppColors.white),
      checkColor: WidgetStateProperty.all(AppColors.black),
    );
}