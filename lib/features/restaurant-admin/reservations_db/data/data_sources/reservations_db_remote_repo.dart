import 'package:dio/dio.dart';
import '/core/parms/parms.dart';
import '/features/restaurant-admin/reservations_db/data/models/csv_data.dart';
import '/features/restaurant-admin/reservations_db/data/models/resevation_data.dart';
import '/features/restaurant-admin/reservations_db/data/models/resevation_data_email.dart';
import '/features/restaurant-admin/reservations_db/data/models/restaurant_campaign.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IReservationDbRemoteApi {
  Future<List<RestaurantCampaignModel>> fetchRestaurantCampaigns(String id);
  Future<String> importCSVFile(ImportCSVFileParms parms);
  Future<List<CSVDataModel>> fetchCSVData(String id);
  Future<List<ReservationDataModel>> fetchReservations(String id);
  Future<List<ReservationDataEmailModel>> fetchReservationsByEmail(
      FetchReservationByEmailParms parms);
  Future<String> fetchSmsAvailability(FetchSmsAvailabilityParms parms);
  Future<String> sendRestaurantData(SendRestaurantDataParms parms);
  Future<String> sendCSVData(SendCSVDataParams parms);
}

class ReservationDbRemoteApiImpl extends IReservationDbRemoteApi {
  final IApiService networkApiService;
  ReservationDbRemoteApiImpl(this.networkApiService);

  @override
  Future<String> sendCSVData(SendCSVDataParams parms) async {
    var response = await networkApiService.post(
      AppUrls.sendCsvDataSms,
      {
        "restaurant_id": parms.restaurantId,
        "subject": parms.subject,
        "message": parms.message,
        "selected_ids": parms.selectedIds,
      },
    );
    return response['message'];
  }

  @override
  Future<String> sendRestaurantData(SendRestaurantDataParms parms) async {
    var response = await networkApiService.post(
      AppUrls.sendReservationDatabaseSms,
      {
        "restaurant_id": parms.restaurantId,
        "subject": parms.subject,
        "message": parms.message,
        "customer_details": parms.customerDetails
            .map((c) => {
                  "name": c.name,
                  "email": c.email,
                  "phone": c.phone,
                  "type": c.type,
                })
            .toList(),
      },
    );
    return response['message'];
  }

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
  Future<String> fetchSmsAvailability(FetchSmsAvailabilityParms parms) async {
    var response = await networkApiService.get(AppUrls.fetchSmsAvailibility,
        queryParams: {
          "id": parms.restaurantId.toString(),
          "recipients": parms.recipients
        });
    return response['data'].toString();
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

  @override
  Future<List<CSVDataModel>> fetchCSVData(String id) async {
    final parms = {"id": id};
    var response =
        await networkApiService.get(AppUrls.getCsvData, queryParams: parms);

    final List<dynamic> rawList = response['data'];
    final List<CSVDataModel> data =
        rawList.map((val) => CSVDataModel.fromJson(val)).toList();
    return data;
  }

  @override
  Future<List<ReservationDataModel>> fetchReservations(String id) async {
    final parms = {"id": id};
    var response = await networkApiService.get(AppUrls.getRestaurantDatabase,
        queryParams: parms);

    final List<dynamic> rawList = response['data'];
    final List<ReservationDataModel> data =
        rawList.map((val) => ReservationDataModel.fromJson(val)).toList();
    return data;
  }

  @override
  Future<List<ReservationDataEmailModel>> fetchReservationsByEmail(
      FetchReservationByEmailParms parms) async {
    final queryParms = {
      "id": parms.restaurantId.toString(),
      "email": parms.email.toString()
    };
    var response = await networkApiService.get(AppUrls.getReservationsByEmail,
        queryParams: queryParms);

    final List<dynamic> rawList = response['data'];
    final List<ReservationDataEmailModel> data =
        rawList.map((val) => ReservationDataEmailModel.fromJson(val)).toList();
    return data;
  }
}
