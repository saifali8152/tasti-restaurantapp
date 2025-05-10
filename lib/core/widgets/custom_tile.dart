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
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 2),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            leading,
            SizedBox(width: 15),
            Text(title, style: TextStyle(fontSize: fontSize),),
            Spacer(),
            applyTrailing! ? Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ) : SizedBox(),
          ],
        ),
      ),
    );
  }
}
