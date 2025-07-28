import '/core/parms/parms.dart';
import '/core/usecase/usecase.dart';
import '../repositories/profile_repo.dart';
import '../../../auth/domain/entities/user.dart';
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
