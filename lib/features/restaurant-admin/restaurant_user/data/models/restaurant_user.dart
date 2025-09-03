import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/domain/entities/restaurant_user.dart';

class RestaurantUserModel extends RestaurantUserEntity {
  RestaurantUserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phoneNumber,
    required super.type,
    required super.isPasswordChanged,
    required super.permissions,
    required super.restaurantId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory RestaurantUserModel.fromJson(Map<String, dynamic> json) {
    return RestaurantUserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      type: json['type'] ?? '',
      isPasswordChanged: json['is_password_changed'] ?? false,
      permissions: (json['permissions'] as List<dynamic>? ?? [])
          .map((p) => PermissionData(
                key: p['key'] ?? '',
                title: p['title'] ?? '',
              ))
          .toList(),
      restaurantId: json['restaurant_id'] ?? 0,
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
      "type": type,
      "is_password_changed": isPasswordChanged,
      "permissions":
          permissions.map((p) => {"key": p.key, "title": p.title}).toList(),
      "restaurant_id": restaurantId,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
