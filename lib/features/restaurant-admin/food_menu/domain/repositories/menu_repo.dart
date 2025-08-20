import '/features/restaurant-admin/food_menu/domain/entities/menu.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IMenuRepo {
  Future<DataState<MenuEntity>> fetchMenu(String id);
  Future<DataState<String>> uploadMenu(UploadMenuParms parms);
}
