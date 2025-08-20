import '/features/restaurant-admin/food_menu/data/models/menu.dart';
import '/core/parms/parms.dart';
import '../data_sources/menu_repo.dart';
import '../../domain/repositories/menu_repo.dart';
import '/core/network/response.dart';

class MenuRepoImpl extends IMenuRepo {
  final IMenuRemoteApi remote;
  MenuRepoImpl(this.remote);

  @override
  Future<DataState<String>> uploadMenu(UploadMenuParms parms) async {
    try {
      final result = await remote.uploadMenu(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<MenuModel>> fetchMenu(String id) async {
    try {
      final result = await remote.fetchMenu(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
