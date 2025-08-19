import 'package:tasti_restaurant_app/features/restaurant-admin/make_reservation/domain/entities/restaurant_time_slots.dart';

class RestaurantTimeSlotModel extends RestaurantTimeSlotEntity {
  RestaurantTimeSlotModel({
    required super.restaurantId,
    required super.date,
    required super.availableTimeSlots,
  });

  // Factory constructor for JSON deserialization
  factory RestaurantTimeSlotModel.fromJson(Map<String, dynamic> json) {
    return RestaurantTimeSlotModel(
      restaurantId: int.parse(json['restaurant_id'].toString()), // ensure int
      date: json['date'] as String,
      availableTimeSlots: List<String>.from(json['available_time_slots']),
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'restaurant_id': restaurantId,
      'date': date,
      'available_time_slots': availableTimeSlots,
    };
  }
}
