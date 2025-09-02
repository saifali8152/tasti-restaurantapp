import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IRestaurantUserRemoteApi {
  Future<String> addRestaurantUser(AddRestaurantUserParms parms);
}

class RestaurantUserRemoteApiImpl extends IRestaurantUserRemoteApi {
  final IApiService networkApiService;
  RestaurantUserRemoteApiImpl(this.networkApiService);

  @override
  Future<String> addRestaurantUser(AddRestaurantUserParms parms) async {
    var response =
        await networkApiService.post(AppUrls.addRestaurantUser, parms.toJson());
    return response['message'];
  }
}
