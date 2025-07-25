import 'package:tasti_restaurant_app/features/admin/restaurants/domain/entities/restaurant.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IRestaurantRepo {
  Future<DataState<RestaurantEntity>> fetchRestaurant(AllRestaurantParms parms);
  Future<DataState<String>> suspendRestaurant(String id);
  Future<DataState<String>> activeRestaurant(String id);
}
