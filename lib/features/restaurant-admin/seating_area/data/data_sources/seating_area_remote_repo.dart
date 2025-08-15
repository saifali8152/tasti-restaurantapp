import 'package:tasti_restaurant_app/features/restaurant-admin/seating_area/data/models/seating_area.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class ISeatingAreaRemoteApi {
  Future<String> deleteSeatingArea(String id);
  Future<String> addSeatingArea(SeatingAreaParms parms);
  Future<String> updateSeatingArea(SeatingAreaParms parms);
  Future<List<SeatingAreaModel>> fetchSeatingArea(String id);
}

class SeatingAreaRemoteApiImpl extends ISeatingAreaRemoteApi {
  final IApiService networkApiService;
  SeatingAreaRemoteApiImpl(this.networkApiService);

  @override
  Future<String> addSeatingArea(SeatingAreaParms parms) async {
    var response =
        await networkApiService.post(AppUrls.addSeatingAreas, parms.toJson());
    return response['message'];
  }

  @override
  Future<String> updateSeatingArea(SeatingAreaParms parms) async {
    var response = await networkApiService.post(
        AppUrls.updateSeatingAreas, parms.toJson());
    return response['message'];
  }

  @override
  Future<List<SeatingAreaModel>> fetchSeatingArea(String id) async {
    Map<String, String> data = {"id": id};

    var response = await networkApiService.get(
      AppUrls.fetchSeatingAreas,
      queryParams: data,
    );
    final List<dynamic> rawList = response['data'];

    final List<SeatingAreaModel> seatingAreas = rawList
        .map((seatignArea) => SeatingAreaModel.fromJson(seatignArea))
        .toList();
    return seatingAreas;
  }

  @override
  Future<String> deleteSeatingArea(String id) async {
    Map<String, String> data = {"id": id};

    var response =
        await networkApiService.post(AppUrls.deleteSeatingAreas, data);
    return response['message'];
  }
}
