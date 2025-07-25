import 'package:tasti_restaurant_app/features/admin/restaurants/data/models/restaurant.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IRestaurantRemoteSourceApi {
  Future<String> suspendRestaurant(String id);
  Future<String> activeRestaurant(String id);
  Future<RestaurantModel> fetchRestaurants(AllRestaurantParms parms);
}

class RestaurantSourceRemoteApiImpl extends IRestaurantRemoteSourceApi {
  final IApiService networkApiService;
  RestaurantSourceRemoteApiImpl(this.networkApiService);

  @override
  Future<String> suspendRestaurant(String id) async {
    Map<String, dynamic> data = {};

    data = {
      "id": id,
    };
    var response = await networkApiService.post(AppUrls.adminSuspendRestaurant, data);

    return response['message'];
  }
  
  @override
  Future<String> activeRestaurant(String id) async {
    Map<String, dynamic> data = {};

    data = {
      "id": id,
    };
    var response = await networkApiService.post(AppUrls.adminActivateRestaurant, data);

    return response['message'];
  }

  @override
  Future<RestaurantModel> fetchRestaurants(AllRestaurantParms parms) async {
    Map<String, String> data = {};
    String url = AppUrls.adminFetchAllRestaurants;

    data = {
      "page": parms.page,
      "limit": parms.limit,
      "search": parms.search,
      "filter": parms.filter,
    };
    final response = await networkApiService.get(url, queryParams: data);
    final Map<String, dynamic> allRestaurants = response;
    final RestaurantModel restaurants = RestaurantModel.fromJson(allRestaurants);
    return restaurants;
  }
}
