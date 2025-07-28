import '../repositories/auth_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/usecase/usecase.dart';
import '../entities/user.dart';

class LoginUseCase extends UseCase<DataState<UserEntity>, LoginParms>{
  final IAuthRepo authRepo;
  
  LoginUseCase(this.authRepo);

  @override
  Future<DataState<UserEntity>> call(LoginParms parms) {
    return authRepo.login(parms);
  }
}