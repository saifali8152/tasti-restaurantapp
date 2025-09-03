import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/domain/repositories/restaurant_user.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class DeleteAdminUserUsecase extends UseCase<DataState<String>, DeleteAdminUserParms>{
  final IAdminUserRepo repo;
  
  DeleteAdminUserUsecase(this.repo);

  @override
  Future<DataState<String>> call(id) {
    return repo.deleteAdminUser(id);
  }
}