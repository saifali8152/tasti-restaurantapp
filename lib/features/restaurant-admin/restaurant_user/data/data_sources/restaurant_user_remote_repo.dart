import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/data/models/restaurant_user.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IRestaurantUserRemoteApi {
  Future<String> addRestaurantUser(AddRestaurantUserParms parms);
  Future<List<RestaurantUserModel>> fetchRestaurantUser(String id);
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

  @override
  Future<List<RestaurantUserModel>> fetchRestaurantUser(String id) async {
    var response = await networkApiService.get(AppUrls.fetchRestaurantUser, queryParams: {"restaurant_id": id});
    final List<dynamic> rawList = response['users'];
    final List<RestaurantUserModel> users = rawList.map((user)=> RestaurantUserModel.fromJson(user)).toList();
    return users;
  }
}
