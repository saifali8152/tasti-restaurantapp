import 'package:tasti_restaurant_app/features/admin/admin_user/domain/entities/restaurant_user.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IAdminUserRepo {
  Future<DataState<AdminUserEntity>> addAdminUser(AddAdminUserParms parms);
  Future<DataState<List<AdminUserEntity>>> fetchAdminUser();
  Future<DataState<String>> deleteAdminUser(int id);
}
