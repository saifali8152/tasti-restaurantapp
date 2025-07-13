import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class CustomCardTheme {
  static CardThemeData lightTheme = CardThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    color: AppColors.white,
    margin: EdgeInsets.all(0),
    elevation: 3,
  );
}
