import 'package:flutter/material.dart';
import '/config/constants/colors.dart';

class ButtonWithIcon extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final Widget icon;
  final Color? bgColor;
  const ButtonWithIcon({
    super.key,
    required this.title,
    this.bgColor,
    this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon,
      label: Text(title, style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? AppColors.darkOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onTap,
    );
  }
}
