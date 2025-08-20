import '/features/common/location/domain/entities/location_entity.dart';
import '/features/common/location/domain/entities/prediction_entity.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class ILocationRepo {
  Future<DataState<List<PredictionEntity>>> getPlacePredictions(GetPlacePredictionParms params);
  Future<DataState<LocationEntity>> getPlaceDetails(GetPlaceDetailsParms params);
}
