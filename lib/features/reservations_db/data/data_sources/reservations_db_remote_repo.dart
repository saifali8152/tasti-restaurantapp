import 'package:dio/dio.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/reservations_db/data/models/restaurant_campaign.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IReservationDbRemoteApi {
  Future<List<RestaurantCampaignModel>> fetchRestaurantCampaigns(String id);
  Future<String> importCSVFile(ImportCSVFileParms parms);
}

class ReservationDbRemoteApiImpl extends IReservationDbRemoteApi {
  final IApiService networkApiService;
  ReservationDbRemoteApiImpl(this.networkApiService);

  @override
  Future<List<RestaurantCampaignModel>> fetchRestaurantCampaigns(
      String id) async {
    var response = await networkApiService
        .get(AppUrls.fetchCampaigns, queryParams: {"id": id});
    final List<dynamic> rawList = response['data'];

    final List<RestaurantCampaignModel> campaigns = rawList
        .map((campaign) => RestaurantCampaignModel.fromJson(campaign))
        .toList();
    return campaigns;
  }

  @override
  Future<String> importCSVFile(ImportCSVFileParms parms) async {
    Map<String, MultipartFile> files = {};
    Map<String, String> data = {};

    if (parms.file.isNotEmpty) {
      files = {
        "file": await MultipartFile.fromFile(
          parms.file,
          filename: parms.file.split('/').last,
          contentType: DioMediaType('text', 'csv'), // <- important!
        ),
      };
    }
    data = {"restaurant_id": parms.restaurantId.toString()};
    var response =
        await networkApiService.postMultipart(AppUrls.importCSV, data, files);
    return response['message'];
  }
}
