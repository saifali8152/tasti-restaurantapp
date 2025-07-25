import 'package:tasti_restaurant_app/features/admin/restaurants/data/models/restaurant.dart';
import 'package:tasti_restaurant_app/features/admin/restaurants/domain/repositories/restaurant_repo.dart';
import '/core/parms/parms.dart';
import '../data_sources/restaurant_remote_source.dart';
import '/core/network/response.dart';

class RestaurantRepoImpl extends IRestaurantRepo {
  final IRestaurantRemoteSourceApi dataSource;
  RestaurantRepoImpl(this.dataSource);
  
  @override
  Future<DataState<String>> suspendRestaurant(String id) async{
    try {
      final result = await dataSource.suspendRestaurant(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<String>> activeRestaurant(String id) async{
    try {
      final result = await dataSource.activeRestaurant(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
    
  @override
  Future<DataState<RestaurantModel>> fetchRestaurant(AllRestaurantParms parms) async{
    try {
      final result = await dataSource.fetchRestaurants(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
