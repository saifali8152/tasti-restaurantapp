import 'package:flutter/material.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/card_details_row.dart';
import '/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/domain/entities/restaurant_user.dart';

class RestaurantUserCard extends StatelessWidget {
  final RestaurantUserEntity item;
  const RestaurantUserCard({super.key, required this.item});

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
            CardDetailsRow(label: "User ID", value: "#${item.id}"),
            const SizedBox(height: 8),
            CardDetailsRow(label: "Email", value: item.email),
            const SizedBox(height: 8),
            CardDetailsRow(label: "Phone", value: item.phoneNumber),
            const SizedBox(height: 8),
            CardDetailsRow(label: "Role", value: item.type),
            const SizedBox(height: 8),
            CardDetailsRow(
              label: "Password Changed",
              value: item.isPasswordChanged ? "Yes" : "No",
            ),
            const SizedBox(height: 8),
            CardDetailsRow(
              label: "Restaurant ID",
              value: item.restaurantId.toString(),
            ),

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
            ],
          ],
        ),
      ),
    );
  }
}
