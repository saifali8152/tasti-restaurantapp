import '/features/common/location/domain/entities/prediction_entity.dart';
import '/features/common/location/domain/repositories/location_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';

class GetPlacePredictionsUseCase {
  final ILocationRepo repository;

  GetPlacePredictionsUseCase(this.repository);

  Future<DataState<List<PredictionEntity>>> call(
      GetPlacePredictionParms params) async {
    return repository.getPlacePredictions(params);
  }
}
