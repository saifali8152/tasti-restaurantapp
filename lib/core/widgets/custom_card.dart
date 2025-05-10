import 'package:flutter/material.dart';
import '/core/utils/general_extentions.dart';
import '../../config/constants/spaces.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final double radius;
  final bool applyShadow;
  final double opacity;
  const CustomCard({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.symmetric(horizontal: AppSpaces.screenHpad),
    this.radius = 16.0,
    this.applyShadow = true,
    this.opacity = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: applyShadow
            ? [
                BoxShadow(
                  color: Colors.black.withSafeOpacity(opacity),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(3, 3),
                ),
                BoxShadow(
                  color: Colors.black.withSafeOpacity(opacity),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(-3, -3),
                ),
              ]
            : [],
      ),
      child: child,
    );
  }
}
