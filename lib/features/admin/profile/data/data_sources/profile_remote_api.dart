import 'package:dio/dio.dart';
import '/features/auth/data/models/user.dart';
import '/features/auth/domain/entities/user.dart';
import '/core/services/session_controller.dart';
import '/dependency_injection.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IProfileRemoteApi {
  Future<String> changePassword(ChangePasswordParms parms);
  Future<UserEntity> updateProfile(UpdateProfileParms parms);
}

class ProfileRemoteApiImpl extends IProfileRemoteApi {
  final IApiService networkApiService;
  ProfileRemoteApiImpl(this.networkApiService);

  @override
  Future<String> changePassword(ChangePasswordParms parms) async {
    var response =
        await networkApiService.post(AppUrls.updateAdminPassword, parms.toMap());
    return response['message'];
  }

  @override
  Future<UserEntity> updateProfile(UpdateProfileParms parms) async {
    String url = AppUrls.updateAdminProfile;

    Map<String, MultipartFile> files = {};
    if (parms.profilePic.isNotEmpty && !(parms.profilePic.contains("http"))) {
      files = {
        "profile_pic": await MultipartFile.fromFile(parms.profilePic,
            filename: parms.profilePic.split('/').last),
      };
    }

    final Map<String, dynamic> fields = {
      "name": parms.name,
    };

    final response = await networkApiService.postMultipart(url, fields, files);

    final String token = sl<SessionController>().user!.token;

    final UserModel newUser = UserModel.fromJson(response['user']);

    final UserEntity updatedUser = newUser.copyWith(token: token).toEntity();
    return updatedUser;
  }
}
