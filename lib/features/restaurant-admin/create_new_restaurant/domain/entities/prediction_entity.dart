import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/data/models/prediction_model.dart';

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
