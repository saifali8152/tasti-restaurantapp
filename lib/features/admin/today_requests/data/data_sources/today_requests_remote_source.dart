import 'package:tasti_restaurant_app/core/enum/request_type.dart';
import 'package:tasti_restaurant_app/features/admin/today_requests/data/models/today_requests.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class ITodayRequestRemoteSourceApi {
  Future<TodayRequestModel> fetchTodayRequest(RequestParms parms);
  Future<String> deleteTodayRequest(String parms);
}

class TodayRequestSourceRemoteApiImpl extends ITodayRequestRemoteSourceApi {
  final IApiService networkApiService;
  TodayRequestSourceRemoteApiImpl(this.networkApiService);

  @override
  Future<String> deleteTodayRequest(String id) async {
    Map<String, dynamic> data = {};

    data = {
      "req_id": id,
    };
    var response =
        await networkApiService.post(AppUrls.adminDeleteTodayRequests, data);

    return response['message'];
  }

  @override
  Future<TodayRequestModel> fetchTodayRequest(RequestParms parms) async {
    Map<String, String> data = {};

    String url = parms.type == RequestType.todayRequests
        ? AppUrls.adminFetchTodayRequests
        : parms.type == RequestType.monthlyRequests
            ? AppUrls.adminFetchMonthRequests
            : parms.type == RequestType.overallRequests
                ? AppUrls.adminFetchOverallRequests
                : '';

    data = {
      "page": parms.page.toString(),
      "limit": parms.limit.toString(),
      "search": parms.search.toString(),
    };
    final response = await networkApiService
        .get(url, queryParams: data);
    final Map<String, dynamic> adminReservation = response;
    final TodayRequestModel adminSmsList =
        TodayRequestModel.fromJson(adminReservation);
    return adminSmsList;
  }
}
