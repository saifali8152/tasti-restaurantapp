import 'package:dio/dio.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/food_menu/data/models/menu.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IMenuRemoteApi {
  Future<MenuModel> fetchMenu(String id);
  Future<String> uploadMenu(UploadMenuParms parms);
}

class MenuRemoteApiImpl extends IMenuRemoteApi {
  final IApiService networkApiService;
  MenuRemoteApiImpl(this.networkApiService);

  @override
  Future<String> uploadMenu(UploadMenuParms parms) async {
    Map<String, MultipartFile> files = {};
    if (parms.menuFile.isNotEmpty && !(parms.menuFile.contains("http"))) {
      files = {
        "menu_file": await MultipartFile.fromFile(parms.menuFile,
            filename: parms.menuFile.split('/').last),
      };
    }

    Map<String, String> data = {"id": parms.id.toString()};

    var response =
        await networkApiService.postMultipart(AppUrls.addMenu, data, files);
    return response['message'];
  }

  @override
  Future<MenuModel> fetchMenu(String id) async {
    Map<String, String> data = {"id": id};

    var response = await networkApiService.get(
      AppUrls.fetchMenu,
      queryParams: data,
    );
    final MenuModel menu = MenuModel.fromJson(response['data']);
    return menu;
  }
}
