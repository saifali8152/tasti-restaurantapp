import 'package:tasti_restaurant_app/features/admin/admin_user/domain/entities/restaurant_user.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/domain/repositories/restaurant_user.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchAdminUserUsecase extends UseCase<DataState<List<AdminUserEntity>>, void>{
  final IAdminUserRepo repo;
  
  FetchAdminUserUsecase(this.repo);

  @override
  Future<DataState<List<AdminUserEntity>>> call(id) {
    return repo.fetchAdminUser();
  }
}