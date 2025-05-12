import 'package:flutter/material.dart';
import '/config/constants/colors.dart';

class CurvedContainer extends StatelessWidget {
  final Widget child;
  const CurvedContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      child: child,
    );
  }
}
