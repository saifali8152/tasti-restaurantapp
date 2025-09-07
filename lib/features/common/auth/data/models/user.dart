import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.type,
    required super.profilePic,
    required super.phoneNumber,
    required super.token,
    required super.restaurant,
    required super.subscriptionStatus,
    required super.subscriptionMessage,
    required super.permissions, // added
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? json;

    UserRestaurantModel? parseRestaurant(dynamic data) {
      if (data == null) return null;

      if (data is Map<String, dynamic>) {
        return UserRestaurantModel.fromJson(data);
      } else if (data is List &&
          data.isNotEmpty &&
          data.first is Map<String, dynamic>) {
        return UserRestaurantModel.fromJson(data.first);
      }

      return null;
    }

    List<PermissionEntity> parsePermissions(dynamic data) {
      if (data == null || data is! List) return [];
      return data
          .whereType<Map<String, dynamic>>()
          .map((e) => PermissionEntity.fromJson(e))
          .toList();
    }

    return UserModel(
      id: user['id'].toString(),
      token: json['token'].toString(),
      name: user['name'].toString(),
      email: user['email'].toString(),
      type: user['type'].toString(),
      profilePic: user['profile_pic'].toString(),
      phoneNumber: user['phone_number'].toString(),
      subscriptionStatus: user['subscription_status'].toString(),
      subscriptionMessage: user['subscription_message'].toString(),
      restaurant: parseRestaurant(user['restaurant']),
      permissions: parsePermissions(user['permissions']), // added
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'name': name,
      'email': email,
      'type': type,
      'phone_number': phoneNumber,
      'profile_pic': profilePic,
      'subscription_status': subscriptionStatus,
      'subscription_message': subscriptionMessage,
      'restaurant': restaurant is UserRestaurantModel
          ? (restaurant as UserRestaurantModel).toJson()
          : [],
      'permissions': permissions.map((e) => e.toJson()).toList(), // added
    };
  }

  UserEntity toEntity() => UserEntity(
        id: id,
        token: token,
        name: name,
        email: email,
        type: type,
        profilePic: profilePic,
        phoneNumber: phoneNumber,
        subscriptionStatus: subscriptionStatus,
        subscriptionMessage: subscriptionMessage,
        restaurant: restaurant,
        permissions: permissions, // added
      );

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      token: entity.token,
      name: entity.name,
      email: entity.email,
      type: entity.type,
      phoneNumber: entity.phoneNumber,
      profilePic: entity.profilePic,
      subscriptionStatus: entity.subscriptionStatus,
      subscriptionMessage: entity.subscriptionMessage,
      restaurant: entity.restaurant,
      permissions: entity.permissions, // added
    );
  }

  UserModel copyWith({
    String? id,
    String? token,
    String? name,
    String? email,
    String? type,
    String? profilePic,
    String? phoneNumber,
    String? subscriptionStatus,
    String? subscriptionMessage,
    UserRestaurantEntity? restaurant,
    List<PermissionEntity>? permissions, // added
  }) {
    return UserModel(
      id: id ?? this.id,
      token: token ?? this.token,
      name: name ?? this.name,
      email: email ?? this.email,
      type: type ?? this.type,
      profilePic: profilePic ?? this.profilePic,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      subscriptionMessage: subscriptionMessage ?? this.subscriptionMessage,
      restaurant: restaurant ?? this.restaurant,
      permissions: permissions ?? this.permissions, // added
    );
  }
}

class UserRestaurantModel extends UserRestaurantEntity {
  const UserRestaurantModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.email,
    required super.address,
    required super.description,
    required super.minimumSpend,
    required super.city,
    required super.status,
    required super.paid,
    required super.lat,
    required super.lon,
    required super.rating,
    required super.cost,
    super.website,
    super.cuisineImage,
    super.cuisines,
    super.dressCode,
    super.attributes,
    super.bookedTimesToday,
    super.tablesLeft,
    super.timeDuration,
  });

  factory UserRestaurantModel.fromJson(Map<String, dynamic> json) {
    return UserRestaurantModel(
      id: (json['id'] ?? 0) is int
          ? json['id'] as int
          : int.tryParse(json['id'].toString()) ?? 0,
      name: (json['name'] ?? '').toString(),
      phone: (json['phone_number'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      cost: (json['cost'] ?? '').toString(),
      city: (json['city'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      minimumSpend: (json['minimum_spend'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      paid: (json['paid'] ?? '').toString(),
      lat: (json['lat'] == null || json['lat'].toString().isEmpty)
          ? 0.0
          : (json['lat'] as num).toDouble(),
      lon: (json['lon'] == null || json['lon'].toString().isEmpty)
          ? 0.0
          : (json['lon'] as num).toDouble(),
      rating: (json['rating'] == null || json['rating'].toString().isEmpty)
          ? 0
          : int.tryParse(json['rating'].toString()) ?? 0,
      website: (json['website']?.toString().isNotEmpty ?? false)
          ? json['website'].toString()
          : null,
      cuisineImage: (json['cuisine_image']?.toString().isNotEmpty ?? false)
          ? json['cuisine_image'].toString()
          : null,
      cuisines: (json['cuisines']?.toString().isNotEmpty ?? false)
          ? json['cuisines'].toString()
          : null,
      dressCode: (json['dress_code']?.toString().isNotEmpty ?? false)
          ? json['dress_code'].toString()
          : null,
      attributes: (json['attributes']?.toString().isNotEmpty ?? false)
          ? json['attributes'].toString()
          : null,
      bookedTimesToday: (json['booked_times_today'] == null ||
              json['booked_times_today'].toString().isEmpty)
          ? null
          : int.tryParse(json['booked_times_today'].toString()),
      tablesLeft: (json['tables_left'] == null ||
              json['tables_left'].toString().isEmpty)
          ? null
          : int.tryParse(json['tables_left'].toString()),
      timeDuration: (json['time_duration']?.toString().isNotEmpty ?? false)
          ? json['time_duration'].toString()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'cost': cost,
      'address': address,
      'city': city,
      'minimum_spend': minimumSpend,
      'description': description,
      'status': status,
      'paid': paid,
      'lat': lat,
      'lon': lon,
      'rating': rating,
      'website': website,
      'cuisine': cuisineImage,
      'cuisines': cuisines,
      'dress_code': dressCode,
      'attributes': attributes,
      'booked_times_today': bookedTimesToday,
      'tables_left': tablesLeft,
      'time_duration': timeDuration,
    };
  }

  UserRestaurantModel copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? address,
    String? description,
    dynamic minimumSpend,
    String? city,
    dynamic status,
    dynamic paid,
    double? lat,
    double? lon,
    dynamic rating,
    String? cost,
    String? website,
    dynamic cuisineImage,
    dynamic cuisines,
    dynamic dressCode,
    dynamic attributes,
    dynamic bookedTimesToday,
    dynamic tablesLeft,
    dynamic timeDuration,
  }) {
    return UserRestaurantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      description: description ?? this.description,
      minimumSpend: minimumSpend ?? this.minimumSpend,
      city: city ?? this.city,
      status: status ?? this.status,
      paid: paid ?? this.paid,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      rating: rating ?? this.rating,
      cost: cost ?? this.cost,
      website: website ?? this.website,
      cuisineImage: cuisineImage ?? this.cuisineImage,
      cuisines: cuisines ?? this.cuisines,
      dressCode: dressCode ?? this.dressCode,
      attributes: attributes ?? this.attributes,
      bookedTimesToday: bookedTimesToday ?? this.bookedTimesToday,
      tablesLeft: tablesLeft ?? this.tablesLeft,
      timeDuration: timeDuration ?? this.timeDuration,
    );
  }
}
