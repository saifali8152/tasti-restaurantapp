import '/core/parms/parms.dart';
import '/features/auth/data/models/user.dart';
import '../data_sources/auth_remote_api.dart';
import '../../domain/repositories/auth_repo.dart';
import '/core/network/response.dart';

class AuthRepoImpl extends IAuthRepo {
  final IAuthRemoteApi authRemoteApi;
  AuthRepoImpl(this.authRemoteApi);

  @override
  Future<DataState<String>> deleteAccount() async {
    try {
      final result = await authRemoteApi.deleteAccount();
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<String>> forgotPassword(String email) async {
    try {
      final result = await authRemoteApi.forgotPassword(email);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<UserModel>> login(LoginParms parms) async {
    try {
      final result = await authRemoteApi.login(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<String>> signout() async {
    try {
      final result = await authRemoteApi.signout();
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  // @override
  // Future<DataState<UserModel>> signup(SignupParms parms) async {
  //   try {
  //     final result = await authRemoteApi.signup(parms);
  //     return DataSuccess(result);
  //   } catch (error) {
  //     return DataFailure(error.toString());
  //   }
  // }
}
