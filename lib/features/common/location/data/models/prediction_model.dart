import '/features/common/location/domain/entities/prediction_entity.dart';

class PredictionModel extends PredictionEntity {
  PredictionModel({required super.description, required super.placeId});

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}
