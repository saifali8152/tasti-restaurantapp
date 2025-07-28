import 'package:tasti_restaurant_app/features/common/auth/domain/entities/user.dart';
import '/core/parms/parms.dart';
import '../data_sources/create_restaurant_repo.dart';
import '../../domain/repositories/create_restaurant_repo.dart';
import '/core/network/response.dart';

class CreateRestaurantRepoImpl extends ICreateRestaurantRepo {
  final ICreateRestaurantRemoteApi remote;
  CreateRestaurantRepoImpl(this.remote);

  @override
  Future<DataState<UserRestaurantEntity>> updateRestaurant(
      UpdateRestaurantParms parms) async {
    try {
      final result = await remote.updateRestaurant(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
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
}
