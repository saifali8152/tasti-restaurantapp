import '../../../auth/domain/entities/user.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IProfileRepo {
  Future<DataState<String>> changePassword(ChangePasswordParms parms);
  Future<ApiResponse<UserEntity>> updateProfile(UpdateProfileParms parms);
}
