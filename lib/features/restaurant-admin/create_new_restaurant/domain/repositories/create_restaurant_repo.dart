import 'package:tasti_restaurant_app/features/auth/domain/entities/user.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/entities/location_entity.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/entities/prediction_entity.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class ICreateRestaurantRepo {
  Future<DataState<UserRestaurantEntity>> createRestaurant(CreateRestaurantParms parms);
  Future<DataState<List<PredictionEntity>>> getPlacePredictions(GetPlacePredictionParms params);
  Future<DataState<LocationEntity>> getPlaceDetails(GetPlaceDetailsParms params);
}
