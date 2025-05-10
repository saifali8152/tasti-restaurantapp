import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class CustomSliderTheme {
  static SliderThemeData lightTheme = const SliderThemeData(
    activeTrackColor: AppColors.darkOrange,
    inactiveTrackColor: Colors.grey,
    thumbColor: AppColors.darkOrange,
    overlayColor: AppColors.darkOrange,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
    overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
  );

}
