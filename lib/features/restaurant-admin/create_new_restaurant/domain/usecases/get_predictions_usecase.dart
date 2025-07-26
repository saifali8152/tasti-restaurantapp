import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/entities/prediction_entity.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/repositories/create_restaurant_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';

class GetPlacePredictionsUseCase {
  final ICreateRestaurantRepo repository;

  GetPlacePredictionsUseCase(this.repository);

  Future<DataState<List<PredictionEntity>>> call(
      GetPlacePredictionParms params) async {
    return repository.getPlacePredictions(params);
  }
}
