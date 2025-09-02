import '/core/parms/parms.dart';
import '../data_sources/restaurant_user_remote_repo.dart';
import '../../domain/repositories/restaurant_user.dart';
import '/core/network/response.dart';

class RestaurantUserRepoImpl extends IRestaurantUserRepo {
  final IRestaurantUserRemoteApi remote;
  RestaurantUserRepoImpl(this.remote);

  @override
  Future<DataState<String>> addRestaurantUser(AddRestaurantUserParms parms) async {
    try {
      final result = await remote.addRestaurantUser(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
