import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/usecase/usecase.dart';
import 'package:tasti_restaurant_app/features/admin/profile/domain/repositories/profile_repo.dart';
import 'package:tasti_restaurant_app/features/auth/domain/entities/user.dart';
import '/core/network/response.dart';

class UpdateProfileUseCase
    extends UseCase<ApiResponse<UserEntity>, UpdateProfileParms> {
  final IProfileRepo profileRepository;

  UpdateProfileUseCase(this.profileRepository);

  @override
  Future<ApiResponse<UserEntity>> call(UpdateProfileParms params) async {
    return profileRepository.updateProfile(params);
  }
}
