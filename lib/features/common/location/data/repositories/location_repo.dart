import 'package:tasti_restaurant_app/features/common/location/domain/entities/location_entity.dart';
import 'package:tasti_restaurant_app/features/common/location/domain/entities/prediction_entity.dart';
import '/core/parms/parms.dart';
import '../data_sources/location_repo.dart';
import '../../domain/repositories/location_repo.dart';
import '/core/network/response.dart';

class LocationRepoImpl extends ILocationRepo {
  final ILocationRemoteApi remote;
  LocationRepoImpl(this.remote);

  @override
  Future<DataState<List<PredictionEntity>>> getPlacePredictions(
      GetPlacePredictionParms params) async {
    return await remote.fetchPredictions(params);
  }

  @override
  Future<DataState<LocationEntity>> getPlaceDetails(
      GetPlaceDetailsParms params) async {
    return await remote.fetchPlaceDetails(params);
  }
}
