import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/domain/entities/restaurant_user.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/presentation/widgets/delete_admin_user_dialog.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/card_details_row.dart';

class AdminUserCard extends StatelessWidget {
  final AdminUserEntity item;
  const AdminUserCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withSafeOpacity(0.15),
              blurRadius: 6,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const Divider(),

            /// User details
            CardDetailsRow(label: "Name", value: "#${item.name}"),
            const SizedBox(height: 8),
            CardDetailsRow(label: "Email", value: item.email),
            const SizedBox(height: 8),
            CardDetailsRow(label: "Phone", value: item.phoneNumber),
            const SizedBox(height: 16),

            /// Permissions
            if (item.permissions.isNotEmpty) ...[
              const Text(
                "Permissions",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: item.permissions
                    .map(
                      (p) => Chip(
                        label: Text(p.title),
                        backgroundColor: Colors.grey.shade100,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.addAdminUser,
                          arguments: {
                            "isEdit": true,
                            "initialData": AddAdminUserParms(
                              id: item.id,
                              name: item.name,
                              email: item.email,
                              phoneNumber: item.phoneNumber,
                              permissions: item.permissions,
                            )
                          },
                        );
                      },
                      text: 'Update',
                      bgColor: Colors.white,
                      textColor: AppColors.darkOrange,
                      borderColor: AppColors.darkOrange,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        context.showCustomDialog(
                          DeleteAdminUserDialog(item.id),
                        );
                      },
                      text: "Delete",
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
