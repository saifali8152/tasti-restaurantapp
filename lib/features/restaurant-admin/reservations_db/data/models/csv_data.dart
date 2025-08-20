import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/domain/entities/csv_data.dart';

class CSVDataModel extends CSVDataEntity {
  CSVDataModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.city,
    required super.province,
    required super.country,
    required super.restaurantId,
  });

  /// Helper method to handle null/empty strings
  static String _stringOrNA(dynamic value) {
    if (value == null || value.toString().trim().isEmpty) {
      return 'N/A';
    }
    return value.toString();
  }

  factory CSVDataModel.fromJson(Map<String, dynamic> json) {
    return CSVDataModel(
      id: json['id'] ?? 0,
      name: _stringOrNA(json['name']),
      email: _stringOrNA(json['email']),
      phone: _stringOrNA(json['phone']),
      city: _stringOrNA(json['city']),
      province: _stringOrNA(json['province']),
      country: _stringOrNA(json['country']),
      restaurantId: json['restaurant_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "city": city,
      "province": province,
      "country": country,
      "restaurant_id": restaurantId,
    };
  }
}
