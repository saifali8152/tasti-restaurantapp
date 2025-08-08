import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/domain/entities/working_hour.dart';

class WorkingHourModel extends WorkingHourEntity {
  WorkingHourModel({
    required super.restaurantId,
    required super.monday,
    required super.tuesday,
    required super.wednesday,
    required super.thursday,
    required super.friday,
    required super.saturday,
    required super.sunday,
  });

  factory WorkingHourModel.fromJson(Map<String, dynamic> json) {
    String orClosed(dynamic value) {
      if (value == null) return "Closed";
      final str = value.toString().trim();
      return str.isEmpty ? "Closed" : str;
    }

    return WorkingHourModel(
      restaurantId: json['restaurant_id'].toString(),
      monday: orClosed(json['monday']),
      tuesday: orClosed(json['tuesday']),
      wednesday: orClosed(json['wednesday']),
      thursday: orClosed(json['thursday']),
      friday: orClosed(json['friday']),
      saturday: orClosed(json['saturday']),
      sunday: orClosed(json['sunday']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spot_id': restaurantId,
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
      'sunday': sunday,
    };
  }

  WorkingHourModel copyWith({
    String? restaurantId,
    String? monday,
    String? tuesday,
    String? wednesday,
    String? thursday,
    String? friday,
    String? saturday,
    String? sunday,
  }) {
    return WorkingHourModel(
      restaurantId: restaurantId ?? this.restaurantId,
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
      sunday: sunday ?? this.sunday,
    );
  }
}
