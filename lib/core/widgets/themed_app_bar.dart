import 'package:flutter/material.dart';
import '/config/constants/colors.dart';

class ThemedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double? height;
  final Widget? subTitle;

  const ThemedAppBar({
    super.key,
    this.title,
    this.subTitle,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height ?? 100),
      child: Container(
        color: AppColors.darkOrange,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (title != null)
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            if (subTitle != null) ...[
              const SizedBox(height: 8),
              subTitle!,
            ]
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 100);
}
