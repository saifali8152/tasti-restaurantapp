import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/data/models/cuisine.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class ICuisineRemoteApi {
  Future<String> deleteCuisine(String id);
  Future<String> addCuisine(AddCuisineParms parms);
  Future<List<CuisineModel>> fetchCuisine(String id);
}

class CuisineRemoteApiImpl extends ICuisineRemoteApi {
  final IApiService networkApiService;
  CuisineRemoteApiImpl(this.networkApiService);

  @override
  Future<String> addCuisine(AddCuisineParms parms) async {
    Map<String, String> data = {
      "id": parms.id.toString(),
      "name": parms.name,
      "type": parms.type,
    };

    var response = await networkApiService.post(AppUrls.addCuisine, data);
    return response['message'];
  }

  @override
  Future<List<CuisineModel>> fetchCuisine(String id) async {
    Map<String, String> data = {"id": id};

    var response = await networkApiService.get(
      AppUrls.getCuisine,
      queryParams: data,
    );
    final List<dynamic> rawList = response['data'];

    final List<CuisineModel> cuisines = rawList.map((cuisine)=> CuisineModel.fromJson(cuisine)).toList();
    return cuisines;
  }

  @override
  Future<String> deleteCuisine(String id) async {
    Map<String, String> data = {"id": id};

    var response = await networkApiService.post(AppUrls.deleteCuisine, data);
    return response['message'];
  }
}
