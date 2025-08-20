import 'package:flutter/material.dart';
import '/features/admin/restaurants/domain/entities/restaurant.dart';
import '/features/admin/restaurants/presentation/widgets/labeled_badge.dart';
import '/config/routes/route_name.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantItem restaurant;
  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final isActive = restaurant.status.toLowerCase() == 'active';
    final isPaid = restaurant.paidStatusText.toLowerCase() == 'paid';

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.restaurantDetails, arguments: restaurant),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Restaurant Name Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    restaurant.restaurantName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Icon(Icons.open_in_new, size: 16),
                ],
              ),
              const SizedBox(height: 8),

              // Owner Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Owner', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  Text(restaurant.owner, style: const TextStyle(fontSize: 12)),
                ],
              ),
              const SizedBox(height: 8),

              // Address
              Row(
                children: [
                  const Icon(Icons.location_on, size: 14, color: Colors.orange),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      restaurant.address,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const Divider(height: 20),

              // Status & Paid
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BadgeLabel(
                    label: 'Status',
                    value: restaurant.status.toUpperCase(),
                    bgColor: isActive ? Colors.green[50]! : Colors.orange[50]!,
                    textColor: isActive ? Colors.green[700]! : Colors.orange[700]!,
                  ),
                  BadgeLabel(
                    label: 'Paid',
                    value: restaurant.paidStatusText.toUpperCase(),
                    bgColor: isPaid ? Colors.green[50]! : Colors.red[100]!,
                    textColor: isPaid ? Colors.green[700]! : Colors.red[700]!,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}