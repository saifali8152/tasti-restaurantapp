import 'package:tasti_restaurant_app/features/auth/domain/entities/user.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/entities/location_entity.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/entities/prediction_entity.dart';
import '/core/parms/parms.dart';
import '../data_sources/create_restaurant_repo.dart';
import '../../domain/repositories/create_restaurant_repo.dart';
import '/core/network/response.dart';

class CreateRestaurantRepoImpl extends ICreateRestaurantRepo {
  final ICreateRestaurantRemoteApi remote;
  CreateRestaurantRepoImpl(this.remote);

  @override
  Future<DataState<UserRestaurantEntity>> createRestaurant(
      CreateRestaurantParms parms) async {
    try {
      final result = await remote.createRestaurant(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

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
