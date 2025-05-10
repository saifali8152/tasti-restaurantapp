import 'package:flutter/material.dart';
import '/config/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFf2f2f2),
      toolbarHeight: 90,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leadingWidth: 80,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.darkOrange,
          ),
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 90.0);
}
