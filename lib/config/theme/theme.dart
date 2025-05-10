import 'custom_theme/custom_themes.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.black,
    appBarTheme: CustomAppBarTheme.darkTheme,
    scaffoldBackgroundColor: AppColors.black,
    checkboxTheme: CustomCheckboxTheme.darkTheme,
    dropdownMenuTheme: CustomDropdownTheme.darkTheme,
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.white,
    appBarTheme: CustomAppBarTheme.lightTheme,
    scaffoldBackgroundColor: AppColors.white,
    checkboxTheme: CustomCheckboxTheme.lightTheme,
    dropdownMenuTheme: CustomDropdownTheme.lightTheme,
    sliderTheme: CustomSliderTheme.lightTheme,
    cardTheme: CustomCardTheme.lightTheme,
  );
}
