import '/features/auth/domain/repositories/auth_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class SignOutUseCase extends UseCase<DataState<String>, void>{
  final IAuthRepo authRepo;
  
  SignOutUseCase(this.authRepo);

  @override
  Future<DataState<String>> call(parms) {
    return authRepo.signout();
  }
}