import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    required this.profilePic,
    required this.phoneNumber,
    required this.token,
    required this.restaurant,
    required this.subscriptionStatus,
    required this.subscriptionMessage,
    required this.permissions,
  });

  final String id;
  final String name;
  final String email;
  final String type;
  final String profilePic;
  final String phoneNumber;
  final String token;
  final dynamic restaurant;
  final String subscriptionStatus;
  final String subscriptionMessage;
  final List<PermissionEntity> permissions;

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        type,
        profilePic,
        phoneNumber,
        token,
        restaurant,
        subscriptionStatus,
        subscriptionMessage,
        permissions,
      ];
}

class UserRestaurantEntity extends Equatable {
  const UserRestaurantEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.cost,
    required this.city,
    required this.description,
    required this.minimumSpend,
    required this.status,
    required this.paid,
    required this.lat,
    required this.lon,
    required this.rating,
    this.website,
    this.cuisineImage,
    this.cuisines,
    this.dressCode,
    this.attributes,
    this.bookedTimesToday,
    this.tablesLeft,
    this.timeDuration,
  });

  final int id;
  final String name;
  final String phone;
  final String cost;
  final String email;
  final String address;
  final String city;
  final String status;
  final String paid;
  final double lat;
  final double lon;
  final int rating;
  final String description;
  final String minimumSpend;

  final String? website;
  final String? cuisineImage;
  final String? cuisines;
  final String? dressCode;
  final String? attributes;
  final int? bookedTimesToday;
  final int? tablesLeft;
  final String? timeDuration;

  factory UserRestaurantEntity.fromJson(Map<String, dynamic> json) {
    return UserRestaurantEntity(
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

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        email,
        address,
        cost,
        city,
        status,
        paid,
        description,
        minimumSpend,
        lat,
        lon,
        rating,
        website,
        cuisineImage,
        cuisines,
        dressCode,
        attributes,
        bookedTimesToday,
        tablesLeft,
        timeDuration,
      ];
}

class PermissionEntity extends Equatable {
  const PermissionEntity({
    required this.key,
    required this.title,
  });

  final String key;
  final String title;

  factory PermissionEntity.fromJson(Map<String, dynamic> json) {
    return PermissionEntity(
      key: (json['key'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'title': title,
    };
  }

  @override
  List<Object?> get props => [key, title];
}
