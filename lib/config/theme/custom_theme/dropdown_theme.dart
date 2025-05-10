import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class CustomDropdownTheme {
  static DropdownMenuThemeData lightTheme = DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(AppColors.white),
    ),
  );

  static DropdownMenuThemeData darkTheme = DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(AppColors.black),
    ),
  );
}
