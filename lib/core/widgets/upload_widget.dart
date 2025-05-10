import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../config/constants/colors.dart';

class UploadWidget extends StatelessWidget {
  const UploadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey.shade300,
      strokeWidth: 2,
      borderType: BorderType.RRect, // Add this
      radius: Radius.circular(10),
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 40,
              color: AppColors.lightGrey,
            ),
            SizedBox(height: 10),
            Text(
              'Drag & drop file here or.',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.lightGrey),
            ),
            SizedBox(height: 10),
            Text(
              'Browse',
              style: TextStyle(
                  color: AppColors.darkOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
