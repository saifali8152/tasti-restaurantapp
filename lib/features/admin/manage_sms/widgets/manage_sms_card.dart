import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/config/routes/route_name.dart';
import '/core/widgets/custom_button.dart';
import '/config/constants/colors.dart';

class ManageSMSCard extends StatelessWidget {
  const ManageSMSCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.smsBundleDetails),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#1',
                    style: TextStyle(fontWeight: FontWeight.bold, ),
                  ),
                  Icon(Icons.open_in_new, size: 16),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Package Owner',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  Text(
                    'Tasti',
                    style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Original Price',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  Text(
                    '100',
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.darkOrange,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Divider(),
              SizedBox(height: 8),
              CustomButton(onPressed: (){}, text: "Delete", bgColor: AppColors.grey, textColor: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
