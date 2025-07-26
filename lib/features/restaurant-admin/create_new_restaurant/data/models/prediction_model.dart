import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/entities/prediction_entity.dart';

class PredictionModel extends PredictionEntity {
  PredictionModel({required super.description, required super.placeId});

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}
