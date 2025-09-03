import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/domain/entities/restaurant_user.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IRestaurantUserRepo {
  Future<DataState<String>> addRestaurantUser(AddRestaurantUserParms parms);
  Future<DataState<List<RestaurantUserEntity>>> fetchRestaurantUser(String id);
}
