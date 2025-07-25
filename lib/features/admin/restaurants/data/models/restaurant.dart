import 'package:tasti_restaurant_app/features/admin/restaurants/domain/entities/restaurant.dart';
import '/core/models/pagination.dart';

class RestaurantModel extends RestaurantEntity {
  const RestaurantModel({
    required super.data,
    required super.pagination,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      data: List<RestaurantItemModel>.from(
        json['data'].map((item) => RestaurantItemModel.fromJson(item)),
      ),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => (e as RestaurantItemModel).toJson()).toList(),
      'pagination': (pagination as RestaurantItemModel).toJson(),
    };
  }
}

class RestaurantItemModel extends RestaurantItem {
  const RestaurantItemModel({
    required super.id,
    required super.userId,
    required super.owner,
    required super.restaurantName,
    required super.phone,
    required super.email,
    required super.city,
    required super.status,
    required super.paid,
    required super.address,
    super.lat,
    super.lon,
    super.cost,
    required super.description,
    required super.dressCode,
    super.minimumSpend,
    required super.paidStatus,
    required super.paidStatusText,
    required super.statusText,
  });

  factory RestaurantItemModel.fromJson(Map<String, dynamic> json) {
    return RestaurantItemModel(
      id: json['id'],
      userId: json['user_id'],
      owner: json['owner'],
      restaurantName: json['restaurant_name'],
      phone: json['phone'],
      email: json['email'],
      city: json['city'],
      status: json['status'],
      paid: json['paid'],
      address: json['address'],
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      cost: (json['cost'] as num?)?.toDouble(),
      description: json['description'] ?? '',
      dressCode: json['dress_code'] ?? '',
      minimumSpend: (json['minimum_spend'] as num?)?.toDouble(),
      paidStatus: json['paid_status'],
      paidStatusText: json['paid_status_text'],
      statusText: json['status_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'owner': owner,
      'restaurant_name': restaurantName,
      'phone': phone,
      'email': email,
      'city': city,
      'status': status,
      'paid': paid,
      'address': address,
      'lat': lat,
      'lon': lon,
      'cost': cost,
      'description': description,
      'dress_code': dressCode,
      'minimum_spend': minimumSpend,
      'paid_status': paidStatus,
      'paid_status_text': paidStatusText,
      'status_text': statusText,
    };
  }
}
