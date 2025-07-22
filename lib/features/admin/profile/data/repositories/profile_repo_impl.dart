import 'package:tasti_restaurant_app/features/admin/profile/data/data_sources/profile_remote_api.dart';
import 'package:tasti_restaurant_app/features/admin/profile/domain/repositories/profile_repo.dart';
import 'package:tasti_restaurant_app/features/auth/domain/entities/user.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

class ProfileRepoImpl extends IProfileRepo {
  final IProfileRemoteApi profileRemoteApi;
  ProfileRepoImpl(this.profileRemoteApi);

  @override
  Future<DataState<String>> changePassword(ChangePasswordParms parms) async {
    try {
      final result = await profileRemoteApi.changePassword(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<ApiResponse<UserEntity>> updateProfile(UpdateProfileParms parms) async {
    try {
      final result = await profileRemoteApi.updateProfile(parms);
      return ApiResponse.completed(result);
    } catch (error) {
      return ApiResponse.error(error.toString());
    }
  }
}
