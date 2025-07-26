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
    required super.lat,
    required super.lon,
    required super.cost,
    required super.description,
    required super.dressCode,
    required super.minimumSpend,
    required super.paidStatus,
    required super.paidStatusText,
    required super.statusText,
  });

  factory RestaurantItemModel.fromJson(Map<String, dynamic> json) {
    return RestaurantItemModel(
      id: json['id'],
      userId: json['user_id'],
      owner: json['owner'].toString(),
      restaurantName: json['restaurant_name'].toString(),
      phone: json['phone'].toString(),
      email: json['email'].toString(),
      city: json['city'].toString(),
      status: json['status'].toString(),
      paid: json['paid'].toString(),
      address: json['address'].toString(),
      lat: json['lat'].toString(),
      lon: json['lon'].toString(),
      cost: json['cost'].toString(),
      description: json['description'].toString(),
      dressCode: json['dress_code'].toString(),
      minimumSpend: json['minimum_spend'].toString(),
      paidStatus: json['paid_status'].toString(),
      paidStatusText: json['paid_status_text'].toString(),
      statusText: json['status_text'].toString(),
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
