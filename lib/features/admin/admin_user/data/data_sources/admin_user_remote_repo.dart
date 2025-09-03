import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/data/models/admin_user.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IAdminUserRemoteApi {
  Future<AdminUserModel> addAdminUser(AddAdminUserParms parms);
  Future<List<AdminUserModel>> fetchAdminUser(String id);
  Future<String> deleteAdminUser(DeleteAdminUserParms parms);
}

class AdminUserRemoteApiImpl extends IAdminUserRemoteApi {
  final IApiService networkApiService;
  AdminUserRemoteApiImpl(this.networkApiService);

  @override
  Future<AdminUserModel> addAdminUser(
      AddAdminUserParms parms) async {
    try {
      var response = await networkApiService.post(
        parms.id == null
            ? AppUrls.addAdminUser
            : AppUrls.updateRestaurantUser,
        parms.toJson(),
      );
      var rawJson = response['user'];
      final AdminUserModel user = AdminUserModel.fromJson(rawJson);
      return user;
    } catch (e, stacktrace) {
      // Print error + stacktrace for debugging
      debugPrint("❌ Error in addAdminUser: $e");
      debugPrint("📌 Stacktrace: $stacktrace");

      // You can also rethrow for higher-level handling
      rethrow;
    }
  }

  @override
  Future<List<AdminUserModel>> fetchAdminUser(String id) async {
    var response = await networkApiService
        .get(AppUrls.fetchAdminUser, queryParams: {"restaurant_id": id});
    final List<dynamic> rawList = response['users'];
    final List<AdminUserModel> users =
        rawList.map((user) => AdminUserModel.fromJson(user)).toList();
    return users;
  }

  @override
  Future<String> deleteAdminUser(DeleteAdminUserParms parms) async {
    var response = await networkApiService.post(
      AppUrls.deleteAdminUser,
      {
        "restaurant_id": parms.restaurantId.toString(),
        "id": parms.id.toString()
      },
    );
    return response['message'];
  }
}
