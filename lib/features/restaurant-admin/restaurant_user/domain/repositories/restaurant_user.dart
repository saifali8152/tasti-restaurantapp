import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IRestaurantUserRepo {
  Future<DataState<String>> addRestaurantUser(AddRestaurantUserParms parms);
}
