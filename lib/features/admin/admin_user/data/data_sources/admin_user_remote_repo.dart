import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/data/models/admin_user.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IAdminUserRemoteApi {
  Future<AdminUserModel> addAdminUser(AddAdminUserParms parms);
  Future<List<AdminUserModel>> fetchAdminUser();
  Future<String> deleteAdminUser(int id);
}

class AdminUserRemoteApiImpl extends IAdminUserRemoteApi {
  final IApiService networkApiService;
  AdminUserRemoteApiImpl(this.networkApiService);

  @override
  Future<AdminUserModel> addAdminUser(AddAdminUserParms parms) async {
    try {
      var response = await networkApiService.post(
        parms.id == null ? AppUrls.addAdminUser : AppUrls.updateAdminUser,
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
  Future<List<AdminUserModel>> fetchAdminUser() async {
    var response = await networkApiService.get(AppUrls.fetchAdminUser);
    final List<dynamic> rawList = response['users'];
    final List<AdminUserModel> users =
        rawList.map((user) => AdminUserModel.fromJson(user)).toList();
    return users;
  }

  @override
  Future<String> deleteAdminUser(int id) async {
    var response = await networkApiService
        .post(AppUrls.deleteAdminUser, {"id": id.toString()});
    return response['message'];
  }
}
