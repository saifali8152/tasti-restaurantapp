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

      return null; // or throw/return default
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
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      description: json['description'],
      minimumSpend: json['minimum_spend'],
      address: json['address'],
      city: json['city'],
      cost: json['cost']??'0',
      status: json['status'],
      paid: json['paid'],
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      rating: json['rating'],
      website: json['website'],
      cuisineImage: json['cuisine'],
      cuisines: json['cuisines'],
      dressCode: json['dress_code'],
      attributes: json['attributes'],
      bookedTimesToday: json['booked_times_today'],
      tablesLeft: json['tables_left'],
      timeDuration: json['time_duration'],
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
}
