import 'package:tasti_restaurant_app/features/admin/admin_user/domain/entities/restaurant_user.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/domain/repositories/restaurant_user.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class AddAdminUserUsecase extends UseCase<DataState<AdminUserEntity>, AddAdminUserParms>{
  final IAdminUserRepo repo;
  
  AddAdminUserUsecase(this.repo);

  @override
  Future<DataState<AdminUserEntity>> call(parm) {
    return repo.addAdminUser(parm);
  }
}