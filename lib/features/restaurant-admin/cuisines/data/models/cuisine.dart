import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/domain/entities/cuisine.dart';

class CuisineModel extends CuisineEntity {
  CuisineModel({
    required super.typeId,
    required super.name,
    required super.type,
  });

  factory CuisineModel.fromJson(Map<String, dynamic> json) {
    return CuisineModel(
      typeId: json['type_id'].toString(),
      name: json['name'],
      type: json['type'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type_id': typeId,
      'name': name,
      'type': type,
    };
  }

  CuisineModel copyWith({
    String? typeId,
    String? name,
    String? type,
  }) {
    return CuisineModel(
      typeId: typeId ?? this.typeId,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }
}
