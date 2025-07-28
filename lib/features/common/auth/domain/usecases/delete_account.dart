import 'package:tasti_restaurant_app/core/enum/account_type.dart';
import '../repositories/auth_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class DeleteAccountUsecase extends UseCase<DataState<String>, AccountType>{
  final IAuthRepo authRepo;
  
  DeleteAccountUsecase(this.authRepo);

  @override
  Future<DataState<String>> call(accountType) {
    return authRepo.deleteAccount(accountType);
  }
}