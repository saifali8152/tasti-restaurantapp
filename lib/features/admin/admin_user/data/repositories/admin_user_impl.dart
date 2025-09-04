import 'package:tasti_restaurant_app/features/admin/admin_user/data/data_sources/admin_user_remote_repo.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/data/models/admin_user.dart';
import '/core/parms/parms.dart';
import '../../domain/repositories/restaurant_user.dart';
import '/core/network/response.dart';

class AdminUserRepoImpl extends IAdminUserRepo {
  final IAdminUserRemoteApi remote;
  AdminUserRepoImpl(this.remote);

  @override
  Future<DataState<AdminUserModel>> addAdminUser(
      AddAdminUserParms parms) async {
    try {
      final result = await remote.addAdminUser(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<List<AdminUserModel>>> fetchAdminUser() async {
    try {
      final result = await remote.fetchAdminUser();
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<String>> deleteAdminUser(int id) async {
    try {
      final result = await remote.deleteAdminUser(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
