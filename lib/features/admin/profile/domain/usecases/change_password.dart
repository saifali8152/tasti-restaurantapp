import '/core/parms/parms.dart';
import '/features/admin/profile/domain/repositories/profile_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class ChangePasswordUsecase extends UseCase<DataState<String>, ChangePasswordParms>{
  final IProfileRepo profileRepo;
  
  ChangePasswordUsecase(this.profileRepo);

  @override
  Future<DataState<String>> call(parms) {
    return profileRepo.changePassword(parms);
  }
}