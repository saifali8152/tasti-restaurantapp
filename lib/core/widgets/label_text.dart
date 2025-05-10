import 'package:flutter/material.dart';
import '../../config/constants/colors.dart';

class LabelText extends StatelessWidget {
  final String text;
  const LabelText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: AppColors.lightGrey));
  }
}