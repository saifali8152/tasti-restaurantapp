import 'package:tasti_restaurant_app/core/parms/parms.dart';

class AdminUserEntity {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String type; // e.g. "restaurant_user"
  final bool isPasswordChanged;
  final List<PermissionData> permissions;
  final int restaurantId;
  final String createdAt;
  final String updatedAt;

  AdminUserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.type,
    required this.isPasswordChanged,
    required this.permissions,
    required this.restaurantId,
    required this.createdAt,
    required this.updatedAt,
  });
}