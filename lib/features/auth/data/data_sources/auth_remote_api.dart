import '/core/parms/parms.dart';
import '/features/auth/data/models/user.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IAuthRemoteApi {
  Future<UserModel> login(LoginParms parms);
  Future<String> signout();
  // Future<String> deleteAccount();
  // Future<String> forgotPassword(String email);
  // Future<UserModel> signup(SignupParms parms);
}

class AuthRemoteApiImpl extends IAuthRemoteApi {
  final IApiService networkApiService;
  AuthRemoteApiImpl(this.networkApiService);

  // @override
  // Future<String> deleteAccount() async {
  //   Map<String, dynamic> data = {};
  //   var response = await networkApiService.post(AppUrls.deleteAccount, data);
  //   return response['message'];
  // }

  // @override
  // Future<String> forgotPassword(String email) async {
  //   Map<String, dynamic> data = {"email": email};
  //   var response = await networkApiService.post(AppUrls.forgotPassword, data);
  //   return response['message'];
  // }

  @override
  Future<UserModel> login(LoginParms parms) async {
    Map<String, dynamic> data = {};

    data = {
      "email": parms.email,
      "password": parms.password,
    };
    var response = await networkApiService.post(AppUrls.login, data);

    final String token = response['token'];
    final Map<String, dynamic> userJson = response['user'];

    Map<String, dynamic> fullUserData;

    fullUserData = {
      'token': token,
      ...userJson,
    };

    final UserModel completeUser = UserModel.fromJson(fullUserData);
    return completeUser;
  }

  @override
  Future<String> signout() async {
    Map<String, dynamic> data = {};
    var response = await networkApiService.post(AppUrls.logout, data);
    return response['message'];
  }

  // @override
  // Future<UserModel> signup(SignupParms parms) async {
  //   Map<String, dynamic> data = {};

  //   data = {
  //     "name": parms.fullName,
  //     "email": parms.email,
  //     "phone_number": parms.phoneNumber,
  //     "password": parms.password,
  //   };
  //   var response = await networkApiService.post(AppUrls.signup, data);

  //   final String token = response['token'];
  //   final Map<String, dynamic> userJson = response['user'];

  //   Map<String, dynamic> fullUserData;

  //   fullUserData = {
  //     'token': token,
  //     ...userJson,
  //   };

  //   final UserModel completeUser = UserModel.fromJson(fullUserData);
  //   return completeUser;
  // }
}
