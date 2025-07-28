import 'package:tasti_restaurant_app/features/common/location/data/models/prediction_model.dart';

class PredictionEntity {
  final String description;
  final String placeId;

  PredictionEntity({required this.description, required this.placeId});

  PredictionModel toPredictionModel() {
    return PredictionModel(
      description: description,
      placeId: placeId,
    );
  }
}
