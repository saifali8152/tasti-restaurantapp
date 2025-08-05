import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/domain/entities/venue.dart';

class VenueModel extends VenueEntity {
  VenueModel({
    required super.venueId,
    required super.name,
    required super.date,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      venueId: json['spot_id'].toString(),
      name: json['name'],
      date: json['dates'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spot_id': venueId,
      'name': name,
      'dates': date,
    };
  }

  VenueModel copyWith({
    String? venueId,
    String? name,
    String? date,
  }) {
    return VenueModel(
      venueId: venueId ?? this.venueId,
      name: name ?? this.name,
      date: date ?? this.date,
    );
  }
}
