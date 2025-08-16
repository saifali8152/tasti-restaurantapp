import 'package:tasti_restaurant_app/features/make_reservation/domain/entities/restaurant_seating_area.dart';

class RestaurantSeatingAreaModel extends RestaurantSeatingAreaEntity {
  RestaurantSeatingAreaModel({
    required super.id,
    required super.seatingAreaName,
    required super.restaurantId,
    required super.abbreviation,
  });

  // Factory constructor for JSON deserialization
  factory RestaurantSeatingAreaModel.fromJson(Map<String, dynamic> json) {
    return RestaurantSeatingAreaModel(
      id: json['id'] as int,
      seatingAreaName: json['seating_area_name'] as String,
      restaurantId: json['restaurant_id'] as int,
      abbreviation: json['abbreviation'] as String,
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'seating_area_name': seatingAreaName,
      'restaurant_id': restaurantId,
      'abbreviation': abbreviation,
    };
  }
}
