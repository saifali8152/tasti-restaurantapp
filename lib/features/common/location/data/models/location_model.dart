import '/features/common/location/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.lat,
    required super.lng,
    required super.city,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
      city: json['city'],
    );
  }
}
