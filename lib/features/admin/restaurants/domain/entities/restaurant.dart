import 'package:equatable/equatable.dart';
import '/core/models/pagination.dart';

class RestaurantEntity extends Equatable {
  final List<RestaurantItem> data;
  final PaginationModel pagination;

  const RestaurantEntity({
    required this.data,
    required this.pagination,
  });

  @override
  List<Object?> get props => [data, pagination];
}

class RestaurantItem extends Equatable {
  final int id;
  final int userId;
  final String owner;
  final String restaurantName;
  final String phone;
  final String email;
  final String city;
  final String status;
  final String paid;
  final String address;
  final String lat;
  final String lon;
  final String cost;
  final String description;
  final String dressCode;
  final String minimumSpend;
  final String paidStatus;
  final String paidStatusText;
  final String statusText;

  const RestaurantItem({
    required this.id,
    required this.userId,
    required this.owner,
    required this.restaurantName,
    required this.phone,
    required this.email,
    required this.city,
    required this.status,
    required this.paid,
    required this.address,
    required this.lat,
    required this.lon,
    required this.cost,
    required this.description,
    required this.dressCode,
    required this.minimumSpend,
    required this.paidStatus,
    required this.paidStatusText,
    required this.statusText,
  });

  RestaurantItem copyWith({
    int? id,
    int? userId,
    String? owner,
    String? restaurantName,
    String? phone,
    String? email,
    String? city,
    String? status,
    String? paid,
    String? address,
    String? lat,
    String? lon,
    String? cost,
    String? description,
    String? dressCode,
    String? minimumSpend,
    String? paidStatus,
    String? paidStatusText,
    String? statusText,
  }) {
    return RestaurantItem(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      owner: owner ?? this.owner,
      restaurantName: restaurantName ?? this.restaurantName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      city: city ?? this.city,
      status: status ?? this.status,
      paid: paid ?? this.paid,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      cost: cost ?? this.cost,
      description: description ?? this.description,
      dressCode: dressCode ?? this.dressCode,
      minimumSpend: minimumSpend ?? this.minimumSpend,
      paidStatus: paidStatus ?? this.paidStatus,
      paidStatusText: paidStatusText ?? this.paidStatusText,
      statusText: statusText ?? this.statusText,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        owner,
        restaurantName,
        phone,
        email,
        city,
        status,
        paid,
        address,
        lat,
        lon,
        cost,
        description,
        dressCode,
        minimumSpend,
        paidStatus,
        paidStatusText,
        statusText,
      ];
}
