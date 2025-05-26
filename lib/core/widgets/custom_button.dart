import 'package:flutter/material.dart';
import '../../config/constants/spaces.dart';
import '../../config/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final bool isFullWidth;
  final bool isLoading;
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final Color borderColor;

  const CustomButton({
    super.key,
    this.isFullWidth = true,
    this.isLoading = false,
    required this.onPressed,
    required this.text,
    this.bgColor = AppColors.darkOrange,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: isLoading ? 2 : 8,
          horizontal: AppSpaces.screenHpad,
        ),
        width: isFullWidth ? double.infinity : null,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              )
            : Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
        ),
      ),
    );
  }
}
