import 'package:flutter/material.dart';
import '/config/constants/colors.dart';

class ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const ContactInfoRow({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.lightGrey),
          const SizedBox(width: 10),
          Flexible(
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
