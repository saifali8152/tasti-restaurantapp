import 'custom_theme/custom_themes.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppTheme {
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
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.darkOrange,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        elevation: 4,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ));
}
