import '/features/auth/domain/repositories/auth_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/usecase/usecase.dart';
import '../entities/user.dart';

class SignUpUseCase extends UseCase<DataState<UserEntity>, SignupParms>{
  final IAuthRepo authRepo;
  
  SignUpUseCase(this.authRepo);

  @override
  Future<DataState<UserEntity>> call(SignupParms parms) {
    return authRepo.signup(parms);
  }
}