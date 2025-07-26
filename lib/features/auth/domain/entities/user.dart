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
      ];
}

class RestaurantEntity extends Equatable {
  const RestaurantEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
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
  final String email;
  final String address;
  final String city;
  final String status;
  final String paid;
  final double lat;
  final double lon;
  final int rating;

  final String? website;
  final String? cuisineImage;
  final String? cuisines;
  final String? dressCode;
  final String? attributes;
  final int? bookedTimesToday;
  final int? tablesLeft;
  final String? timeDuration;

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        email,
        address,
        city,
        status,
        paid,
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
