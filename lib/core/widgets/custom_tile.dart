import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final double? fontSize;
  final bool? applyTrailing;
  final Function()? onTap;
  const CustomTile({
    super.key,
    required this.leading,
    required this.title,
    this.fontSize = 14,
    this.applyTrailing = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      onTap: onTap ?? () {},
      leading: leading,
      trailing: applyTrailing!
          ? Icon(
              Icons.arrow_forward_ios,
              size: 14,
            )
          : SizedBox(),
      title: Text(
        title,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
