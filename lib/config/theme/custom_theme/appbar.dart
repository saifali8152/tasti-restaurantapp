import 'package:flutter/material.dart';
import '../../constants/colors.dart';
class CustomAppBarTheme {
  static AppBarTheme lightTheme = const AppBarTheme(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.black),
    );

  static AppBarTheme darkTheme = const AppBarTheme(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.white),
  );
}
