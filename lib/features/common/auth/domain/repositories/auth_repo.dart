import '/core/enum/account_type.dart';
import '/core/parms/parms.dart';
import '../entities/user.dart';
import '/core/network/response.dart';

abstract class IAuthRepo {
  Future<DataState<UserEntity>> login(LoginParms parms);
  Future<DataState<String>> signout();
  Future<DataState<String>> deleteAccount(AccountType accountType);
  Future<DataState<String>> forgotPassword(String email);
  Future<DataState<UserEntity>> signup(SignupParms parms);
}
