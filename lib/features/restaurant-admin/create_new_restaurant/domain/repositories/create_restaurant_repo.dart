import 'package:tasti_restaurant_app/features/common/auth/domain/entities/user.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class ICreateRestaurantRepo {
  Future<DataState<UserRestaurantEntity>> createRestaurant(CreateRestaurantParms parms);
  Future<DataState<UserRestaurantEntity>> updateRestaurant(UpdateRestaurantParms parms);
}
