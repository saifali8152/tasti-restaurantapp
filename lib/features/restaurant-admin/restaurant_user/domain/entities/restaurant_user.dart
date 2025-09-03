class RestaurantUserEntity {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String type; // e.g. "restaurant_user"
  final bool isPasswordChanged;
  final List<UserPermission> permissions;
  final int restaurantId;
  final String createdAt;
  final String updatedAt;

  RestaurantUserEntity({
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

class UserPermission {
  final String key;
  final String title;

  UserPermission({
    required this.key,
    required this.title,
  });
}
