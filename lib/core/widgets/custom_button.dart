import 'package:flutter/material.dart';
import '/core/widgets/loading_widget.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        width: isFullWidth ? double.infinity : null,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: isLoading
                ? const SizedBox(
                    key: ValueKey('loading'),
                    height: 24,
                    width: 24,
                    child: LoadingWidget(),
                  )
                : Text(
                    text,
                    key: const ValueKey('text'),
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
        ),
      ),
    );
  }
}
