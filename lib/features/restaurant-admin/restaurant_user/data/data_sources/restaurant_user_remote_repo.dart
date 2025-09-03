import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/data/models/restaurant_user.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IRestaurantUserRemoteApi {
  Future<RestaurantUserModel> addRestaurantUser(AddRestaurantUserParms parms);
  Future<List<RestaurantUserModel>> fetchRestaurantUser(String id);
}

class RestaurantUserRemoteApiImpl extends IRestaurantUserRemoteApi {
  final IApiService networkApiService;
  RestaurantUserRemoteApiImpl(this.networkApiService);

  @override
  Future<RestaurantUserModel> addRestaurantUser(AddRestaurantUserParms parms) async {
    try {
      var response = await networkApiService.post(
        AppUrls.addRestaurantUser,
        parms.toJson(),
      );
      var rawJson = response['user'];
      final RestaurantUserModel user = RestaurantUserModel.fromJson(rawJson);
      return user;
    } catch (e, stacktrace) {
      // Print error + stacktrace for debugging
      debugPrint("❌ Error in addRestaurantUser: $e");
      debugPrint("📌 Stacktrace: $stacktrace");

      // You can also rethrow for higher-level handling
      rethrow;
    }
  }

  @override
  Future<List<RestaurantUserModel>> fetchRestaurantUser(String id) async {
    var response = await networkApiService.get(AppUrls.fetchRestaurantUser, queryParams: {"restaurant_id": id});
    final List<dynamic> rawList = response['users'];
    final List<RestaurantUserModel> users = rawList.map((user)=> RestaurantUserModel.fromJson(user)).toList();
    return users;
  }
}
