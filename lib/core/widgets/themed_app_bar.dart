import 'package:flutter/material.dart';
import '/config/constants/colors.dart';

class ThemedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double? height;
  final Widget? subTitle;
  final List<Widget>? actions;

  const ThemedAppBar(
      {super.key, this.title, this.subTitle, this.height, this.actions});

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
              Row(
                children: [
                  Spacer(flex: actions == null ? 1 : 3),
                  Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  if (actions != null) ...[
                    ...actions ?? [],
                    SizedBox(width: 10)
                  ]
                ],
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
